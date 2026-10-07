"""
=============================================================================
WMS BRIDGE – most miedzy sterownikiem PLC a systemem magazynowym WMS
=============================================================================

Przeplyw (jedna paleta):

  1. PLC laczy sie na port OUTPUT (4301) i czeka na odpowiedz.
  2. PLC laczy sie na port INPUT (4300) i wysyla liste pozycji palety, np.
         [{"POSITION_NR": "0", "PRODUCT_NR": "0100000039",
           "PROD_SERIAL_NR": "Partia", "BU_QUANTITY": "2"}]
     (polaczenie INPUT moze byc otwarte dlugo przed wyslaniem danych).
  3. Bridge zaklada w WMS zlecenie:      POST {WMS_BASE}/Spr
     i pobiera dane etykiety:            POST {WMS_BASE}/SprLabelPrint
  4. Na polaczenie OUTPUT odsyla JSON i je zamyka:
         {"status": "OK", "sscc": "...", "picking_date": "YYYY-MM-DD",
          "gross_weight_kg": 25.0054, "product_name": "..."}
     albo przy bledzie:
         {"status": "ERR", "error": "<KOD>", "message": "<opis>"}

Zmiany wzgledem poprzedniej wersji:
  * dane z PLC sa doczytywane do konca JSON-a (wczesniej jeden recv(4096)
    mogl uciac dluzsza wiadomosc), smieci/null-e po JSON-ie sa ignorowane,
  * gdy PLC przysle niepoprawny JSON albo pusta liste, na OUTPUT od razu
    wraca {"status": "ERR", ...} (wczesniej PLC czekal w nieskonczonosc),
  * na zlecenie czeka tylko NAJNOWSZE polaczenie OUTPUT – stare/zerwane
    polaczenia nie "zjadaja" juz zlecen, ktorych nikt by nie odebral,
  * pusta lista pozycji etykiety z WMS nie wywraca juz watku (items[0]).

Konfiguracja – stale ponizej lub zmienne srodowiskowe o tych samych nazwach.
=============================================================================
"""

import json
import logging
import os
import queue
import select
import socket
import threading
import time
import uuid
from datetime import datetime, UTC

import requests

# ─────────────────────────────────────────────────────────
#  KONFIGURACJA
# ─────────────────────────────────────────────────────────

TCP_IP      = os.environ.get("BRIDGE_TCP_IP", "0.0.0.0")
PORT_IN     = int(os.environ.get("BRIDGE_PORT_IN", 4300))    # PLC wysyla dane palety
PORT_OUT    = int(os.environ.get("BRIDGE_PORT_OUT", 4301))   # PLC odbiera odpowiedz
BUFFER_SIZE = 4096

WMS_BASE      = os.environ.get("WMS_BASE", "http://192.168.1.34:8080/WilkRestServer/Wilk")
WMS_SPR_URL   = WMS_BASE + "/Spr"
WMS_LABEL_URL = WMS_BASE + "/SprLabelPrint"

FIRM_NR       = os.environ.get("WMS_FIRM_NR", "MAGH")
CUSTOMER_NR   = os.environ.get("WMS_CUSTOMER_NR", "MAGH")
WH_NR         = os.environ.get("WMS_WH_NR", "MAGH")
ORDER_TYPE_NR = os.environ.get("WMS_ORDER_TYPE_NR", "AUTO")

WMS_TIMEOUT       = 10    # [s] timeout zapytan HTTP do WMS
JSON_MORE_TIMEOUT = 2.0   # [s] ile czekac na reszte niepelnego JSON-a z PLC
ERROR_JOB_TTL     = 30.0  # [s] po tym czasie nieodebrany blad z INPUT jest porzucany,
                          #     zeby nie trafil do PLC przy kolejnej palecie
MAX_MESSAGE_BYTES = 1024 * 1024  # zabezpieczenie przed nieskonczonym strumieniem

# Log zapisywany obok skryptu (niezaleznie od katalogu, z ktorego go uruchomiono)
LOG_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "wms_bridge_simple.log")

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s  %(levelname)-8s  %(message)s",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(LOG_FILE, encoding="utf-8"),
    ]
)
log = logging.getLogger("bridge")

# Kolejka zadan INPUT -> OUTPUT. Element to krotka:
#   ("order", [pozycje...])              – poprawne zamowienie do wyslania do WMS
#   ("error", kod, opis, czas_monotonic) – blad danych z PLC, odsylany od razu jako ERR
order_queue: "queue.Queue[tuple]" = queue.Queue()

# Numer najnowszego polaczenia OUTPUT. Starsze polaczenia przestaja czekac.
_output_generation = 0
_output_lock = threading.Lock()


# ─────────────────────────────────────────────────────────
#  ODBIOR JSON-a Z PLC
# ─────────────────────────────────────────────────────────

def _decode_json(data: bytes):
    """
    Dekoduje pierwszy kompletny dokument JSON z bufora.
    Ignoruje smieci przed '[' / '{' oraz padding (spacje, \\x00) po JSON-ie.
    Rzuca json.JSONDecodeError, gdy JSON jest niepelny lub bledny.
    """
    text = data.decode("utf-8", errors="replace")
    starts = [i for i in (text.find("["), text.find("{")) if i != -1]
    if not starts:
        raise json.JSONDecodeError("Brak poczatku JSON ('[' lub '{')", text, 0)
    obj, _end = json.JSONDecoder().raw_decode(text, min(starts))
    return obj


def recv_json(conn: socket.socket):
    """
    Czyta z gniazda az do otrzymania kompletnego JSON-a.

    Pierwszy fragment: czekamy bez limitu (PLC potrafi trzymac otwarte
    polaczenie i wyslac dane po wielu minutach). Kolejne fragmenty: czekamy
    maks. JSON_MORE_TIMEOUT sekund.

    Zwraca (surowe_bajty, obiekt) albo (surowe_bajty, None) gdy JSON jest
    bledny/niepelny, albo (b"", None) gdy klient rozlaczyl sie bez danych.
    """
    data = b""
    conn.settimeout(None)
    while len(data) < MAX_MESSAGE_BYTES:
        try:
            chunk = conn.recv(BUFFER_SIZE)
        except socket.timeout:
            break
        if not chunk:
            break  # klient zamknal polaczenie
        data += chunk
        try:
            return data, _decode_json(data)
        except json.JSONDecodeError:
            conn.settimeout(JSON_MORE_TIMEOUT)  # moze reszta jeszcze dojdzie
    return data, None


def _log_json_error(data: bytes) -> str:
    """Loguje szczegoly bledu JSON i zwraca krotki opis."""
    try:
        _decode_json(data)
        return "Nieznany blad JSON"
    except json.JSONDecodeError as e:
        log.error("❌ JSON ERROR:")
        log.error("• Pozycja bledu: index %d", e.pos)
        log.error("• Linia: %d, kolumna: %d", e.lineno, e.colno)
        log.error("• Wiadomosc: %s", e.msg)
        log.error("⛔ Fragment przy bledzie: %s", e.doc[max(0, e.pos - 40):e.pos + 40])
        return f"{e.msg} (index {e.pos})"


# ─────────────────────────────────────────────────────────
#  ZAMOWIENIE WMS
# ─────────────────────────────────────────────────────────

def build_order(items_list):
    """Buduje payload zlecenia SPR dla WMS. Zwraca (payload, c_order_nr)."""
    # Unikalny numer zlecenia: data/czas UTC + 6 losowych znakow
    c_order_nr = datetime.now(UTC).strftime("%Y%m%d%H%M%S") + uuid.uuid4().hex[:6].upper()

    return {
        "SPR_HEADER": [
            {
                "FIRM_NR":       FIRM_NR,
                "CUSTOMER_NR":   CUSTOMER_NR,
                "C_ORDER_NR":    c_order_nr,
                "DATE_SHIPPING": datetime.now(UTC).strftime("%Y/%m/%d"),
                "WH_NR":         WH_NR,
                "ORDER_TYPE_NR": ORDER_TYPE_NR,
                "SPR_ITEM": [
                    {
                        "POSITION_NR":    str(item.get("POSITION_NR", "0")),
                        "PRODUCT_NR":     str(item.get("PRODUCT_NR", "")),
                        "PROD_SERIAL_NR": str(item.get("PROD_SERIAL_NR", "")),
                        "BU_QUANTITY":    str(item.get("BU_QUANTITY", "0")),
                    }
                    for item in items_list
                ]
            }
        ]
    }, c_order_nr


def _err(code: str, message: str) -> dict:
    return {"status": "ERR", "error": code, "message": message}


def _post_json(url: str, payload: dict):
    """POST do WMS. Zwraca (slownik_odpowiedzi, None) albo (None, (kod, opis)) przy bledzie."""
    try:
        resp = requests.post(url, json=payload, timeout=WMS_TIMEOUT)
    except Exception as e:
        return None, ("REQUEST_ERROR", str(e))

    log.debug("WMS odpowiedz %s HTTP=%d body=%s", url, resp.status_code, resp.text[:300])

    if not resp.text or not resp.text.strip():
        return None, ("EMPTY_RESPONSE", "WMS zwrocil puste body")
    try:
        body = resp.json()
    except ValueError:
        return None, ("INVALID_JSON", resp.text[:100])
    if not isinstance(body, dict):
        return None, ("INVALID_JSON", "Odpowiedz WMS nie jest obiektem JSON")
    return body, None


def process_order(items_list) -> dict:
    """
    Wysyla zlecenie do WMS, pobiera dane etykiety i zwraca odpowiedz dla PLC.
    Nigdy nie rzuca wyjatku – bledy zamieniane sa na {"status": "ERR", ...}.
    """
    order_payload, c_order_nr = build_order(items_list)
    log.info("➡️ POST %s  C_ORDER_NR=%s", WMS_SPR_URL, c_order_nr)
    log.debug("SPR payload: %s", json.dumps(order_payload, ensure_ascii=False))

    # --- 1. zalozenie zlecenia ---
    post_json, error = _post_json(WMS_SPR_URL, order_payload)
    if error:
        code, msg = error
        log.error("❌ Blad SPR (%s): %s", code, msg)
        mapping = {"REQUEST_ERROR": "WMS_ERROR", "EMPTY_RESPONSE": "WMS_EMPTY_RESPONSE",
                   "INVALID_JSON": "WMS_INVALID_JSON"}
        return _err(mapping[code], msg)

    wms_ok = (
        post_json.get("status") == "OK"
        or post_json.get("error") == "IMPORT_COMPLETED"
        or post_json.get("success") in (1, "1", True)
    )
    if not wms_ok:
        error_code = post_json.get("errorCode") or post_json.get("error") or "WMS_ERROR"
        error_msg  = post_json.get("errorMessage") or post_json.get("message") or "WMS odrzucil zamowienie"
        log.warning("❌ WMS odrzucil SPR: %s – %s", error_code, error_msg)
        return _err(error_code, error_msg)

    sscc_raw = post_json.get("sscc") or post_json.get("SSCC")
    if not sscc_raw:
        log.error("❌ Brak SSCC w odpowiedzi WMS")
        return _err("NO_SSCC", "WMS nie zwrocil SSCC")

    # WMS moze zwrocic kilka SSCC rozdzielonych przecinkiem – etykiete bierzemy dla pierwszego
    sscc_list  = [s.strip() for s in str(sscc_raw).split(",") if s.strip()]
    first_sscc = sscc_list[0] if sscc_list else str(sscc_raw)
    log.info("✔ WMS przyjal SPR  SSCC=%s", sscc_raw)

    # --- 2. dane etykiety ---
    label_payload = {"c_order_nr": c_order_nr, "sscc": first_sscc}
    log.info("➡️ POST %s  sscc=%s", WMS_LABEL_URL, first_sscc)

    full_order, error = _post_json(WMS_LABEL_URL, label_payload)
    if error:
        code, msg = error
        if code == "EMPTY_RESPONSE":
            # zlecenie jest juz zalozone – odsylamy chociaz SSCC
            log.warning("⚠️ Brak danych etykiety – wysylam samo SSCC")
            return {"status": "OK", "sscc": sscc_raw, "sscc_list": sscc_list,
                    "warning": "Brak danych etykiety"}
        log.error("❌ Blad etykiety (%s): %s", code, msg)
        mapping = {"REQUEST_ERROR": "WMS_LABEL_ERROR", "INVALID_JSON": "WMS_LABEL_INVALID_JSON"}
        return _err(mapping[code], msg)

    # waga przychodzi jako tekst z przecinkiem dziesietnym, np. "25,0054"
    weight_raw = full_order.get("gross_weight_kg", "0")
    try:
        weight_float = float(str(weight_raw).replace(",", "."))
    except (ValueError, TypeError):
        weight_float = 0.0

    items = full_order.get("SPR_LABEL_PRINT_RES_IT") or []
    product_name = items[0].get("product_name") if items and isinstance(items[0], dict) else None

    return {
        "status":          "OK",
        "sscc":            full_order.get("sscc") or sscc_raw,
        "picking_date":    full_order.get("picking_date"),
        "gross_weight_kg": weight_float,
        "product_name":    product_name,
    }


# ─────────────────────────────────────────────────────────
#  SERWER INPUT (PLC -> bridge)
# ─────────────────────────────────────────────────────────

def _listen(port: int) -> socket.socket:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((TCP_IP, port))
    s.listen(5)
    return s


def server_input():
    s = _listen(PORT_IN)
    log.info("📥 Serwer INPUT dziala na porcie %d", PORT_IN)
    while True:
        conn, addr = s.accept()
        threading.Thread(target=handle_input_client, args=(conn, addr), daemon=True).start()


def handle_input_client(conn: socket.socket, addr):
    log.info("🔗 Klient INPUT polaczony: %s", addr)
    # keepalive – system wykryje "martwe" polaczenie, gdy PLC zniknie bez zamkniecia
    conn.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
    try:
        raw, parsed = recv_json(conn)
        log.debug("📨 RAW DATA ODEBRANE (bytes): %s", raw)

        if not raw:
            log.info("PLC zamknal polaczenie INPUT bez danych: %s", addr)
            return

        if parsed is None:
            msg = _log_json_error(raw)
            order_queue.put(("error", "INVALID_JSON", msg, time.monotonic()))
            return

        # pojedynczy obiekt traktujemy jak liste z jedna pozycja
        if isinstance(parsed, dict):
            parsed = [parsed]

        if not parsed or not all(isinstance(i, dict) for i in parsed):
            log.error("❌ Niepoprawna lista pozycji: %s", parsed)
            order_queue.put(("error", "EMPTY_OR_INVALID_ITEMS",
                             "Lista pozycji jest pusta lub niepoprawna", time.monotonic()))
            return

        log.info("📦 Odebrano LISTE JSONOW na %d: %s", PORT_IN, parsed)
        order_queue.put(("order", parsed))
        log.info("💾 Dane LISTY dodane do kolejki – OUTPUT moze je odebrac")

    except Exception as e:
        log.error("❌ Blad INPUT %s: %s", addr, e)
    finally:
        conn.close()


# ─────────────────────────────────────────────────────────
#  SERWER OUTPUT (bridge -> PLC)
# ─────────────────────────────────────────────────────────

def server_output():
    global _output_generation
    s = _listen(PORT_OUT)
    log.info("📤 Serwer OUTPUT dziala na porcie %d", PORT_OUT)
    while True:
        conn, addr = s.accept()
        with _output_lock:
            _output_generation += 1
            generation = _output_generation
        threading.Thread(target=handle_output_client, args=(conn, addr, generation), daemon=True).start()


def _peer_closed(conn: socket.socket) -> bool:
    """True, jesli druga strona zamknela/zerwala polaczenie (sprawdzenie bez blokowania)."""
    try:
        readable, _, _ = select.select([conn], [], [], 0)
        if not readable:
            return False
        return conn.recv(1, socket.MSG_PEEK) == b""
    except (OSError, ValueError):
        return True


def _is_current(generation: int) -> bool:
    with _output_lock:
        return generation == _output_generation


def handle_output_client(conn: socket.socket, addr, generation: int):
    log.info("🔗 Klient OUTPUT polaczony: %s", addr)
    conn.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
    try:
        # --- czekamy na zadanie z INPUT ---
        while True:
            if not _is_current(generation):
                log.info("PLC otworzyl nowsze polaczenie OUTPUT – zamykam stare %s", addr)
                return
            if _peer_closed(conn):
                log.info("PLC zamknal polaczenie OUTPUT %s przed otrzymaniem odpowiedzi", addr)
                return
            try:
                job = order_queue.get(timeout=0.5)
            except queue.Empty:
                continue

            if job[0] == "error" and time.monotonic() - job[3] > ERROR_JOB_TTL:
                log.warning("Porzucam przeterminowany blad z INPUT: %s", job[1:3])
                continue

            # Zadanie pobrane – jesli w miedzyczasie polaczenie umarlo, oddajemy je
            # do kolejki, zeby obsluzylo je kolejne polaczenie PLC.
            if _peer_closed(conn) or not _is_current(generation):
                order_queue.put(job)
                log.info("Polaczenie OUTPUT %s nieaktualne – zadanie wraca do kolejki", addr)
                return
            break

        # --- przetwarzamy zadanie ---
        if job[0] == "error":
            _, code, msg, _ts = job
            response_data = _err(code, msg)
        else:
            response_data = process_order(job[1])

        conn.sendall(json.dumps(response_data, ensure_ascii=False).encode("utf-8"))
        if response_data.get("status") == "OK":
            log.info("📤 Wyslano odpowiedz do PLC  sscc=%s  waga=%s kg",
                     response_data.get("sscc"), response_data.get("gross_weight_kg"))
        else:
            log.info("📤 Wyslano blad do PLC: %s", response_data)

    except Exception as e:
        log.exception("❌ Blad OUTPUT %s: %s", addr, e)
    finally:
        conn.close()
        log.info("❌ Rozlaczono OUTPUT: %s", addr)


# ─────────────────────────────────────────────────────────

if __name__ == "__main__":
    log.info("=" * 60)
    log.info("  WMS Bridge Simple")
    log.info("  TCP IN   : %d  (PLC wysyla dane)", PORT_IN)
    log.info("  TCP OUT  : %d  (PLC odbiera odpowiedz)", PORT_OUT)
    log.info("  WMS SPR  : %s", WMS_SPR_URL)
    log.info("  WMS LABEL: %s", WMS_LABEL_URL)
    log.info("  FIRM_NR  : %s", FIRM_NR)
    log.info("=" * 60)

    t1 = threading.Thread(target=server_input,  daemon=True)
    t2 = threading.Thread(target=server_output, daemon=True)
    t1.start()
    t2.start()

    log.info("🚀 Serwery INPUT i OUTPUT uruchomione")
    try:
        t1.join()
        t2.join()
    except KeyboardInterrupt:
        log.info("🛑 Zatrzymano (Ctrl+C)")
