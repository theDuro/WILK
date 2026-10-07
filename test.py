"""
=============================================================================
SYMULATOR PLC – testuje wms_bridge_simple.py
=============================================================================

Uruchom najpierw bridge:
    python wms_bridge_simple.py

Potem uruchom ten symulator:
    python test_plc_symulator.py

=============================================================================
"""

import socket
import json
import time

BRIDGE_IP   = "127.0.0.1"
PORT_IN     = 4300   # tu wysylamy dane palety
PORT_OUT    = 4301   # tu odbieramy odpowiedz
TIMEOUT     = 15     # sekund czekania na odpowiedz


def send_to_bridge(payload, port=PORT_IN):
    """Wysyla JSON do bridge i zwraca odpowiedz jesli jest."""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(TIMEOUT)
        s.connect((BRIDGE_IP, port))
        s.sendall(json.dumps(payload, ensure_ascii=False).encode("utf-8"))
        s.shutdown(socket.SHUT_WR)

        chunks = []
        while True:
            try:
                chunk = s.recv(4096)
                if not chunk:
                    break
                chunks.append(chunk)
            except socket.timeout:
                break
        s.close()

        raw = b"".join(chunks)
        if raw:
            return json.loads(raw.decode("utf-8"))
        return None

    except Exception as e:
        print(f"   ❌ Blad TCP: {e}")
        return None


def receive_from_bridge():
    """Laczy sie na port 4301 i czeka na odpowiedz."""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(TIMEOUT)
        s.connect((BRIDGE_IP, PORT_OUT))

        chunks = []
        while True:
            try:
                chunk = s.recv(4096)
                if not chunk:
                    break
                chunks.append(chunk)
            except socket.timeout:
                break
        s.close()

        raw = b"".join(chunks)
        if raw:
            return json.loads(raw.decode("utf-8"))
        return None

    except Exception as e:
        print(f"   ❌ Blad TCP: {e}")
        return None


def print_result(result):
    """Ladnie wyswietla odpowiedz z bridge."""
    if result is None:
        print("   ❌ Brak odpowiedzi (timeout lub blad polaczenia)")
        return

    status = result.get("status")

    if status == "OK":
        print(f"   ✅ STATUS    : OK")
        print(f"   📦 SSCC      : {result.get('sscc')}")
        if result.get("sscc_list") and len(result.get("sscc_list", [])) > 1:
            print(f"   📦 SSCC LIST : {result.get('sscc_list')}")
        print(f"   📅 DATA      : {result.get('picking_date')}")
        print(f"   ⚖️  WAGA      : {result.get('gross_weight_kg')} kg")
        items = result.get("items", [])
        if items:
            print(f"   📋 POZYCJE   : {len(items)} szt.")
            for i, item in enumerate(items):
                print(f"      [{i}] produkt={item.get('product_nr')}  "
                      f"partia={item.get('prod_serial_nr')}  "
                      f"ilosc={item.get('bu_quantity')}")
        if result.get("warning"):
            print(f"   ⚠️  OSTRZEZENIE: {result.get('warning')}")
    elif status == "ERR":
        print(f"   ❌ STATUS    : ERR")
        print(f"   🔴 BLAD      : {result.get('error')}")
        print(f"   📝 OPIS      : {result.get('message')}")
    else:
        print(f"   ⚠️  Nieznana odpowiedz: {result}")


# =============================================================================
# TESTY
# =============================================================================

print()
print("=" * 65)
print("  SYMULATOR PLC – test wms_bridge_simple.py")
print(f"  Bridge: {BRIDGE_IP}  IN:{PORT_IN}  OUT:{PORT_OUT}")
print("=" * 65)

# ── TEST 1: 1 partia na palecie ──────────────────────────────────────────────
print()
print("─" * 65)
print("TEST 1: Jedna partia na palecie")
print("─" * 65)

items_t1 = [
    {
        "POSITION_NR":    "0",
        "PRODUCT_NR":     "0100000039",
        "PROD_SERIAL_NR": "Partia",
        "BU_QUANTITY":    "2"
    }
]

print(f"   📤 Wysylam na port {PORT_IN}: {items_t1}")
send_to_bridge(items_t1)
print(f"   ⏳ Czekam na odpowiedz z portu {PORT_OUT}...")
result = receive_from_bridge()
print_result(result)

time.sleep(1)

# ── TEST 2: 2 partie na palecie ──────────────────────────────────────────────
print()
print("─" * 65)
print("TEST 2: Dwie partie na palecie")
print("─" * 65)

items_t2 = [
    {
        "POSITION_NR":    "0",
        "PRODUCT_NR":     "0100000039",
        "PROD_SERIAL_NR": "PartiaA",
        "BU_QUANTITY":    "60"
    },
    {
        "POSITION_NR":    "1",
        "PRODUCT_NR":     "0100000039",
        "PROD_SERIAL_NR": "PartiaB",
        "BU_QUANTITY":    "30"
    }
]

print(f"   📤 Wysylam na port {PORT_IN}: 2 pozycje")
for i, item in enumerate(items_t2):
    print(f"      [{i}] {item}")
send_to_bridge(items_t2)
print(f"   ⏳ Czekam na odpowiedz z portu {PORT_OUT}...")
result = receive_from_bridge()
print_result(result)

time.sleep(1)

# ── TEST 3: 3 rozne artykuly ─────────────────────────────────────────────────
print()
print("─" * 65)
print("TEST 3: Trzy rozne artykuly na palecie")
print("─" * 65)

items_t3 = [
    {
        "POSITION_NR":    "0",
        "PRODUCT_NR":     "0100000039",
        "PROD_SERIAL_NR": "Partia1",
        "BU_QUANTITY":    "40"
    },
    {
        "POSITION_NR":    "1",
        "PRODUCT_NR":     "0100000039",
        "PROD_SERIAL_NR": "Partia2",
        "BU_QUANTITY":    "30"
    },
    {
        "POSITION_NR":    "2",
        "PRODUCT_NR":     "0100000039",
        "PROD_SERIAL_NR": "Partia3",
        "BU_QUANTITY":    "20"
    }
]

print(f"   📤 Wysylam na port {PORT_IN}: 3 pozycje")
send_to_bridge(items_t3)
print(f"   ⏳ Czekam na odpowiedz z portu {PORT_OUT}...")
result = receive_from_bridge()
print_result(result)

time.sleep(1)

# ── TEST 4: blad – pusta lista ───────────────────────────────────────────────
print()
print("─" * 65)
print("TEST 4: BLAD – pusta lista pozycji")
print("─" * 65)

print(f"   📤 Wysylam pusta liste []")
send_to_bridge([])
print(f"   ⏳ Czekam na odpowiedz z portu {PORT_OUT}...")
result = receive_from_bridge()
print_result(result)

time.sleep(1)

# ── TEST 5: blad – niepoprawny JSON ─────────────────────────────────────────
print()
print("─" * 65)
print("TEST 5: BLAD – niepoprawny JSON")
print("─" * 65)

print(f"   📤 Wysylam niepoprawny JSON")
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(TIMEOUT)
    s.connect((BRIDGE_IP, PORT_IN))
    s.sendall(b"TO NIE JEST JSON {{{")
    s.shutdown(socket.SHUT_WR)
    s.close()
except Exception as e:
    print(f"   ❌ {e}")

print(f"   ⏳ Czekam na odpowiedz z portu {PORT_OUT}...")
result = receive_from_bridge()
print_result(result)

# ── PODSUMOWANIE ─────────────────────────────────────────────────────────────
print()
print("=" * 65)
print("  Testy zakonczone")
print("=" * 65)
print()