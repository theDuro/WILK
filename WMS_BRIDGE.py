"""
=============================================================================
WMS BRIDGE – identyczna struktura polaczen jak w oryginalnym kodzie
=============================================================================
"""

import json
import socket
import threading
import time
import uuid
import logging
import requests
import queue
import select
from datetime import datetime, UTC

TCP_IP      = "0.0.0.0"
PORT_IN     = 4300
PORT_OUT    = 4301
BUFFER_SIZE = 4096

WMS_BASE      = "http://192.168.1.34:8080/WilkRestServer/Wilk"
WMS_SPR_URL   = WMS_BASE + "/Spr"
WMS_LABEL_URL = WMS_BASE + "/SprLabelPrint"

FIRM_NR     = "MAGH"
CUSTOMER_NR = "MAGH"
WH_NR       = "MAGH"
ORDER_TYPE_NR = "AUTO"

WMS_TIMEOUT = 10
TCP_TIMEOUT = 5

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s  %(levelname)-8s  %(message)s",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler("wms_bridge_simple.log", encoding="utf-8"),
    ]
)
log = logging.getLogger("bridge")

order_queue = queue.Queue()


def build_order(items_list):
    c_order_nr = datetime.now(UTC).strftime("%Y%m%d%H%M%S") + \
                 uuid.uuid4().hex[:6].upper()

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


def server_input():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((TCP_IP, PORT_IN))
    s.listen(5)
    log.info("📥 Serwer INPUT dziala na porcie %d", PORT_IN)

    while True:
        conn, addr = s.accept()
        threading.Thread(target=handle_input_client, args=(conn, addr), daemon=True).start()


def handle_input_client(conn, addr):
    log.info("🔗 Klient INPUT polaczony: %s", addr)
    try:
        raw = conn.recv(BUFFER_SIZE)
        log.debug("📨 RAW DATA ODEBRANE (bytes): %s", raw)

        try:
            text = raw.decode("utf-8", errors="replace")
            log.debug("📄 RAW DATA jako tekst:\n%s", text)
        except Exception:
            log.warning("⚠️ Nie udalo sie zdekodowac danych jako UTF-8")
            conn.close()
            return

        try:
            # Wycinamy do ostatniego ']' – PLC moze dosylac padding/null bajty po JSON
            last_bracket = text.rfind(']')
            if last_bracket == -1:
                raise json.JSONDecodeError("Brak zamkniecia tablicy JSON", text, 0)
            cleaned = text[:last_bracket + 1]
            tcp_data_list = json.loads(cleaned)
        except json.JSONDecodeError as e:
            log.error("❌ JSON ERROR:")
            log.error("• Pozycja bledu: index %d", e.pos)
            log.error("• Linia: %d, kolumna: %d", e.lineno, e.colno)
            log.error("• Wiadomosc: %s", e.msg)
            log.error("⛔ Fragment przed bledem: %s", text[max(0, e.pos-40):e.pos+40])
            conn.close()
            return

        log.info("📦 Odebrano LISTE JSONOW na %d: %s", PORT_IN, tcp_data_list)
        order_queue.put(tcp_data_list)
        log.info("💾 Dane LISTY dodane do kolejki – OUTPUT moze je odebrac")

    except Exception as e:
        log.error("❌ Blad INPUT %s: %s", addr, e)
    finally:
        conn.close()


def server_output():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((TCP_IP, PORT_OUT))
    s.listen(5)
    log.info("📤 Serwer OUTPUT dziala na porcie %d", PORT_OUT)

    while True:
        conn, addr = s.accept()
        threading.Thread(target=handle_output_client, args=(conn, addr), daemon=True).start()


def polaczenie_zamkniete(conn):
    """
    POPRAWKA WinError 10054: sprawdza (bez czekania), czy PLC zamknal
    polaczenie OUTPUT. Wtedy nie wolno na nim czekac na dane, bo odpowiedz
    i tak by nie doszla, a paleta przepadlaby dla nowego polaczenia PLC.
    """
    try:
        gotowe, _, _ = select.select([conn], [], [], 0)
        if not gotowe:
            return False
        return conn.recv(1, socket.MSG_PEEK) == b""
    except OSError:
        return True


def handle_output_client(conn, addr):
    try:
        log.info("\n🔗 Klient OUTPUT polaczony: %s", addr)

        items_list = None
        while items_list is None:
            if polaczenie_zamkniete(conn):  # POPRAWKA WinError 10054
                log.info("PLC zamknal polaczenie OUTPUT %s – nie czekam na nim dalej", addr)
                return
            try:
                items_list = order_queue.get_nowait()
            except queue.Empty:
                time.sleep(0.1)

        order_payload, c_order_nr = build_order(items_list)
        log.info("➡️ POST %s  C_ORDER_NR=%s", WMS_SPR_URL, c_order_nr)
        log.debug("SPR payload: %s", json.dumps(order_payload, ensure_ascii=False))

        try:
            post_resp = requests.post(
                WMS_SPR_URL,
                json=order_payload,
                timeout=WMS_TIMEOUT,
                headers={"Content-Type": "application/json"}
            )
        except Exception as e:
            log.error("❌ Blad POST do WMS: %s", e)
            conn.send(json.dumps({"status": "ERR", "error": "WMS_ERROR", "message": str(e)}).encode("utf-8"))
            return

        log.debug("WMS SPR odpowiedz HTTP=%d body=%s", post_resp.status_code, post_resp.text[:300])

        if not post_resp.text or not post_resp.text.strip():
            log.error("❌ WMS zwrocil puste body")
            conn.send(json.dumps({"status": "ERR", "error": "WMS_EMPTY_RESPONSE", "message": "WMS zwrocil puste body"}).encode("utf-8"))
            return

        try:
            post_json = post_resp.json()
        except Exception:
            log.error("❌ WMS niepoprawny JSON: %s", post_resp.text[:100])
            conn.send(json.dumps({"status": "ERR", "error": "WMS_INVALID_JSON", "message": post_resp.text[:100]}).encode("utf-8"))
            return

        wms_ok = (
            post_json.get("status") == "OK"
            or post_json.get("error") == "IMPORT_COMPLETED"
            or post_json.get("success") in (1, "1", True)
        )

        if not wms_ok:
            error_code = post_json.get("errorCode") or post_json.get("error") or "WMS_ERROR"
            error_msg  = post_json.get("errorMessage") or post_json.get("message") or "WMS odrzucil zamowienie"
            log.warning("❌ WMS odrzucil SPR: %s – %s", error_code, error_msg)
            conn.send(json.dumps({"status": "ERR", "error": error_code, "message": error_msg}).encode("utf-8"))
            return

        sscc_raw = post_json.get("sscc") or post_json.get("SSCC")
        if not sscc_raw:
            log.error("❌ Brak SSCC w odpowiedzi WMS")
            conn.send(json.dumps({"status": "ERR", "error": "NO_SSCC", "message": "WMS nie zwrocil SSCC"}).encode("utf-8"))
            return

        sscc_list  = [s.strip() for s in str(sscc_raw).split(",")]
        first_sscc = sscc_list[0]
        log.info("✔ WMS przyjal SPR  SSCC=%s", sscc_raw)

        label_payload = {"c_order_nr": c_order_nr, "sscc": first_sscc}
        log.info("➡️ POST %s  sscc=%s", WMS_LABEL_URL, first_sscc)

        try:
            get_resp = requests.post(
                WMS_LABEL_URL,
                json=label_payload,
                timeout=WMS_TIMEOUT,
                headers={"Content-Type": "application/json"}
            )
        except Exception as e:
            log.error("❌ Blad POST etykiety: %s", e)
            conn.send(json.dumps({"status": "ERR", "error": "WMS_LABEL_ERROR", "message": str(e)}).encode("utf-8"))
            return

        log.debug("WMS LABEL odpowiedz HTTP=%d body=%s", get_resp.status_code, get_resp.text[:300])

        if not get_resp.text or not get_resp.text.strip():
            log.warning("⚠️ Brak danych etykiety – wysylam samo SSCC")
            conn.send(json.dumps({"status": "OK", "sscc": sscc_raw, "sscc_list": sscc_list, "warning": "Brak danych etykiety"}).encode("utf-8"))
            return

        try:
            full_order = get_resp.json()
        except Exception:
            log.error("❌ LABEL niepoprawny JSON: %s", get_resp.text[:100])
            conn.send(json.dumps({"status": "ERR", "error": "WMS_LABEL_INVALID_JSON", "message": get_resp.text[:100]}).encode("utf-8"))
            return

        weight_raw = full_order.get("gross_weight_kg", "0")
        try:
            weight_float = float(str(weight_raw).replace(",", "."))
        except (ValueError, TypeError):
            weight_float = 0.0

        items = full_order.get("SPR_LABEL_PRINT_RES_IT", [])

        product_name = items[0].get("product_name")

        response_data = {
            "status":          "OK",
            "sscc":            full_order.get("sscc") or sscc_raw,
            "picking_date":    full_order.get("picking_date"),
            "gross_weight_kg": weight_float,
            "product_name":    product_name
        }

        #przed 01.10.2026
        #response_data = {
        #    "status":          "OK",
        #    "sscc":            full_order.get("sscc") or sscc_raw,
        #    "sscc_list":       sscc_list,
        #    "picking_date":    full_order.get("picking_date"),
        #    "gross_weight_kg": weight_float,
        #    "items":           full_order.get("SPR_LABEL_PRINT_RES_IT", []),
        #    "ts":              full_order.get("ts"),
        #}

        conn.send(json.dumps(response_data, ensure_ascii=False).encode("utf-8"))
        log.info("📤 Wyslano odpowiedz do PLC  sscc=%s  waga=%.4f kg", response_data["sscc"], weight_float)

    except Exception as e:
        log.exception("❌ Blad OUTPUT %s: %s", addr, e)
    finally:
        conn.close()
        log.info("❌ Rozlaczono OUTPUT: %s", addr)


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
    t1.join()
    t2.join()