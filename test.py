"""
=============================================================================
SYMULATOR PLC – reczny test WMS_BRIDGE.py
=============================================================================

Symuluje sterownik PLC: wysyla liste pozycji palety na port INPUT (4300)
i odbiera odpowiedz z portu OUTPUT (4301).

Uzycie:
    1. Uruchom bridge:                python WMS_BRIDGE.py
       (bez prawdziwego WMS mozna uzyc atrapy:
            python mock_wms.py
        i uruchomic bridge z WMS_BASE=http://127.0.0.1:8081/WilkRestServer/Wilk)
    2. Uruchom symulator:             python test.py [adres_bridge]

UWAGA: przy prawdziwym WMS kazdy test zaklada w WMS prawdziwe zlecenie!
=============================================================================
"""

import json
import socket
import sys
import time

BRIDGE_IP   = sys.argv[1] if len(sys.argv) > 1 else "127.0.0.1"
PORT_IN     = 4300   # tu wysylamy dane palety
PORT_OUT    = 4301   # tu odbieramy odpowiedz
TIMEOUT     = 15     # [s] czekania na odpowiedz


def _read_all(s: socket.socket) -> bytes:
    """Czyta dane az do zamkniecia polaczenia przez bridge lub timeoutu."""
    chunks = []
    while True:
        try:
            chunk = s.recv(4096)
        except socket.timeout:
            break
        if not chunk:
            break
        chunks.append(chunk)
    return b"".join(chunks)


def send_to_bridge(payload, port=PORT_IN):
    """Wysyla dane (obiekt -> JSON, bytes -> bez zmian) na port INPUT."""
    raw = payload if isinstance(payload, bytes) else json.dumps(payload, ensure_ascii=False).encode("utf-8")
    try:
        with socket.create_connection((BRIDGE_IP, port), timeout=TIMEOUT) as s:
            s.sendall(raw)
            s.shutdown(socket.SHUT_WR)
    except OSError as e:
        print(f"   ❌ Blad TCP: {e}")


def open_output():
    """
    Otwiera polaczenie na port OUTPUT. Tak jak prawdziwy PLC robimy to PRZED
    wyslaniem danych na INPUT – bridge oddaje odpowiedz tylko najnowszemu
    polaczeniu OUTPUT.
    """
    try:
        s = socket.create_connection((BRIDGE_IP, PORT_OUT), timeout=TIMEOUT)
        time.sleep(0.2)  # chwila, zeby bridge zarejestrowal polaczenie
        return s
    except OSError as e:
        print(f"   ❌ Blad TCP: {e}")
        return None


def receive_from_bridge(s):
    """Czeka na odpowiedz na otwartym polaczeniu OUTPUT i ja dekoduje."""
    if s is None:
        return None
    try:
        raw = _read_all(s)
    finally:
        s.close()
    if not raw:
        return None
    try:
        return json.loads(raw.decode("utf-8"))
    except ValueError:
        print(f"   ⚠️ Odpowiedz nie jest JSON-em: {raw!r}")
        return None


def print_result(result):
    """Ladnie wyswietla odpowiedz z bridge."""
    if result is None:
        print("   ❌ Brak odpowiedzi (timeout lub blad polaczenia)")
        return

    status = result.get("status")
    if status == "OK":
        print("   ✅ STATUS    : OK")
        print(f"   📦 SSCC      : {result.get('sscc')}")
        if len(result.get("sscc_list") or []) > 1:
            print(f"   📦 SSCC LIST : {result.get('sscc_list')}")
        print(f"   📅 DATA      : {result.get('picking_date')}")
        print(f"   ⚖️  WAGA      : {result.get('gross_weight_kg')} kg")
        print(f"   🏷️  PRODUKT   : {result.get('product_name')}")
        if result.get("warning"):
            print(f"   ⚠️  OSTRZEZENIE: {result.get('warning')}")
    elif status == "ERR":
        print("   ❌ STATUS    : ERR")
        print(f"   🔴 BLAD      : {result.get('error')}")
        print(f"   📝 OPIS      : {result.get('message')}")
    else:
        print(f"   ⚠️  Nieznana odpowiedz: {result}")


def run_case(title, payload):
    """Jeden scenariusz: OUTPUT -> wyslanie na INPUT -> odbior odpowiedzi."""
    print()
    print("─" * 65)
    print(title)
    print("─" * 65)
    out = open_output()
    print(f"   📤 Wysylam na port {PORT_IN}: {payload!r}")
    send_to_bridge(payload)
    print(f"   ⏳ Czekam na odpowiedz z portu {PORT_OUT}...")
    print_result(receive_from_bridge(out))
    time.sleep(1)


def main():
    print()
    print("=" * 65)
    print("  SYMULATOR PLC – test WMS_BRIDGE.py")
    print(f"  Bridge: {BRIDGE_IP}  IN:{PORT_IN}  OUT:{PORT_OUT}")
    print("=" * 65)

    run_case("TEST 1: Jedna partia na palecie", [
        {"POSITION_NR": "0", "PRODUCT_NR": "0100000039", "PROD_SERIAL_NR": "Partia", "BU_QUANTITY": "2"},
    ])

    run_case("TEST 2: Dwie partie na palecie", [
        {"POSITION_NR": "0", "PRODUCT_NR": "0100000039", "PROD_SERIAL_NR": "PartiaA", "BU_QUANTITY": "60"},
        {"POSITION_NR": "1", "PRODUCT_NR": "0100000039", "PROD_SERIAL_NR": "PartiaB", "BU_QUANTITY": "30"},
    ])

    run_case("TEST 3: Trzy partie na palecie", [
        {"POSITION_NR": "0", "PRODUCT_NR": "0100000039", "PROD_SERIAL_NR": "Partia1", "BU_QUANTITY": "40"},
        {"POSITION_NR": "1", "PRODUCT_NR": "0100000039", "PROD_SERIAL_NR": "Partia2", "BU_QUANTITY": "30"},
        {"POSITION_NR": "2", "PRODUCT_NR": "0100000039", "PROD_SERIAL_NR": "Partia3", "BU_QUANTITY": "20"},
    ])

    # spodziewany wynik: ERR / EMPTY_OR_INVALID_ITEMS
    run_case("TEST 4: BLAD – pusta lista pozycji", [])

    # spodziewany wynik: ERR / INVALID_JSON
    run_case("TEST 5: BLAD – niepoprawny JSON", b"TO NIE JEST JSON {{{")

    # spodziewany wynik: OK – bridge ignoruje padding (null-e/spacje) po JSON-ie
    run_case("TEST 6: JSON z paddingiem jak z PLC",
             json.dumps([{"POSITION_NR": "0", "PRODUCT_NR": "0100000039",
                          "PROD_SERIAL_NR": "Pad", "BU_QUANTITY": "1"}]).encode() + b"\x00" * 50)

    print()
    print("=" * 65)
    print("  Testy zakonczone")
    print("=" * 65)
    print()


if __name__ == "__main__":
    main()
