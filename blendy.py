"""
=============================================================================
BLEDY (alarmy) – serwer TCP zapisujacy wystapienia alarmow z PLC
=============================================================================

PLC wysyla na port 4000 JSON z lista ID alarmow:
    {"alarms": [305, 312]}

ID to klucze tabeli machine_part_errors (slownik alarmow, patrz add_to_base.py).
Dla kazdego ID w tabeli machine_part_error_occurrences zapisywane jest
wystapienie z aktualnym czasem, kodem (np. A305) i opisem ze slownika.

Dodatkowo, jesli w danych pojawi sie liczba z ALERT_IDS (domyslnie 440),
skrypt zapisuje {"seq": N, "code": "440"} do pliku alarm.json w kontenerze
frontu (docker cp), skad mozna go odczytac pod http://<host>:8080/alarm.json.
Obecny build frontu tego pliku jeszcze nie czyta – to przygotowanie pod
wyskakujace okienko alarmu.

Pomocniczy serwer HTTP na porcie 4100:
    GET /state – aktualny stan alarmu (JSON)
    GET /test  – wywoluje testowy alarm 440

Konfiguracja bazy: stale ponizej lub zmienne srodowiskowe DB_HOST, DB_PORT,
DB_NAME, DB_USER, DB_PASSWORD.
=============================================================================
"""

import json
import os
import re
import socket
import subprocess
import tempfile
import traceback
from http.server import BaseHTTPRequestHandler, HTTPServer
from socketserver import ThreadingMixIn
from threading import Thread, Lock

import psycopg2

# ─────────────────────────────────────────────────────────
#  KONFIGURACJA
# ─────────────────────────────────────────────────────────

DB_CONFIG = {
    "dbname":   os.environ.get("DB_NAME", "postgres"),
    "user":     os.environ.get("DB_USER", "postgres"),
    "password": os.environ.get("DB_PASSWORD", "Test1234!"),
    "host":     os.environ.get("DB_HOST", "localhost"),
    "port":     int(os.environ.get("DB_PORT", 5432)),
    "sslmode":  "disable",
}

ALERT_IDS = {440}                 # ID alarmow, ktore maja wywolac komunikat na ekranie
TCP_PORT = int(os.environ.get("BLEDY_PORT", 4000))
ALARM_PORT = int(os.environ.get("ALARM_HTTP_PORT", 4100))   # tylko do recznego testu /test
FRONT_CONTAINER = os.environ.get("FRONT_CONTAINER", "autosoft_front")
FRONT_PATH = "/app/build/alarm.json"

BUFFER_SIZE = 4096
JSON_MORE_TIMEOUT = 2.0           # [s] ile czekac na reszte niepelnego JSON-a
MAX_MESSAGE_BYTES = 1024 * 1024


# ─────────────────────────────────────────────────────────
#  STAN ALARMU
# ─────────────────────────────────────────────────────────

_alock = Lock()
_astate = {"seq": 0, "code": None}   # seq rosnie przy kazdym alarmie


def push_state_to_front():
    """Zapisuje stan alarmu jako plik serwowany przez kontener frontu (port 8080)."""
    try:
        with _alock:
            payload = json.dumps(_astate)
        tmp = os.path.join(tempfile.gettempdir(), "alarm.json")
        with open(tmp, "w", encoding="utf-8") as f:
            f.write(payload)
        subprocess.run(
            ["docker", "cp", tmp, f"{FRONT_CONTAINER}:{FRONT_PATH}"],
            check=True, capture_output=True
        )
        print(f"[FRONT] {payload}")
    except subprocess.CalledProcessError as e:
        print(f"[FRONT] blad docker cp: {e.stderr.decode(errors='ignore')}")
    except Exception as e:
        print(f"[FRONT] blad: {e}")


def trigger_alarm(code):
    with _alock:
        _astate["seq"] += 1
        _astate["code"] = str(code)
        seq = _astate["seq"]
    print(f">>> ALARM {code} WYSLANY NA EKRAN (seq={seq}) <<<")
    push_state_to_front()


# ─────────────────────────────────────────────────────────
#  WYKRYWANIE ALARMU
# ─────────────────────────────────────────────────────────

def check_alert_raw(text):
    """
    Szuka ALERT_IDS w surowym tekscie (kazda liczba w danych).
    Celowo dziala na surowym tekscie, zeby alarm zadzialal nawet gdy PLC
    przysle dane w nieoczekiwanym formacie.
    """
    found = {int(n) for n in re.findall(r'\d+', text)}
    hit = found & ALERT_IDS
    print(f"[CHECK] liczby w danych: {sorted(found)}")
    if hit:
        code = min(hit)
        print(f"[CHECK] ZNALEZIONO {code}")
        trigger_alarm(code)
        return True
    print(f"[CHECK] brak {ALERT_IDS} w danych")
    return False


# ─────────────────────────────────────────────────────────
#  MALY SERWER HTTP – tylko do recznego testu
# ─────────────────────────────────────────────────────────

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True


class AlarmHandler(BaseHTTPRequestHandler):

    def _hdr(self, ctype):
        self.send_header("Content-Type", ctype)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Cache-Control", "no-store")
        self.end_headers()

    def do_GET(self):
        try:
            if self.path.startswith("/state"):
                with _alock:
                    body = json.dumps(_astate).encode()
                self.send_response(200)
                self._hdr("application/json")
                self.wfile.write(body)

            elif self.path.startswith("/test"):
                trigger_alarm("440")
                self.send_response(200)
                self._hdr("text/plain; charset=utf-8")
                self.wfile.write("ALARM TESTOWY WYSLANY\n".encode("utf-8"))

            else:
                self.send_response(404)
                self._hdr("text/plain")

        except (ConnectionAbortedError, ConnectionResetError, BrokenPipeError):
            pass

    def handle_one_request(self):
        try:
            super().handle_one_request()
        except (ConnectionAbortedError, ConnectionResetError, BrokenPipeError):
            self.close_connection = True

    def log_message(self, *args):
        pass  # wyciszenie logow kazdego zapytania HTTP


def start_alarm_server():
    try:
        srv = ThreadedHTTPServer(("0.0.0.0", ALARM_PORT), AlarmHandler)
        Thread(target=srv.serve_forever, daemon=True).start()
        print(f"Serwer testowy na porcie {ALARM_PORT}")
        print(f"  test recznie:  http://localhost:{ALARM_PORT}/test")
    except OSError as e:
        print(f"BLAD serwera testowego: {e}")


# ─────────────────────────────────────────────────────────
#  ZAPIS DO BAZY
# ─────────────────────────────────────────────────────────

def parse_alarm_ids(parsed) -> list[int]:
    """
    Wyciaga liste ID alarmow z danych PLC. Akceptuje {"alarms": [...]}
    albo sama liste [...]. Wartosci niebedace liczbami sa pomijane.
    """
    if isinstance(parsed, dict):
        alarms = parsed.get("alarms", [])
    elif isinstance(parsed, list):
        alarms = parsed
    else:
        return []
    if not isinstance(alarms, list):
        alarms = [alarms]

    ids = []
    for a in alarms:
        try:
            ids.append(int(a))
        except (TypeError, ValueError):
            print(f"Pomijam niepoprawne ID alarmu: {a!r}")
    return ids


def insert_part_error_occurrences(error_ids):
    """
    Zapisuje wystapienia alarmow na podstawie slownika machine_part_errors.
    Zwraca liste kodow (np. ['A305']) faktycznie zapisanych alarmow.
    ID, ktorych nie ma w slowniku, sa pomijane.
    """
    if not error_ids:
        print("Brak alarmow do dodania")
        return []

    conn = None
    codes = []
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        with conn:                      # commit / rollback
            with conn.cursor() as cur:
                cur.execute("""
                    INSERT INTO machine_part_error_occurrences (
                        error_id, part_id, occurred_at, error_code, description
                    )
                    SELECT e.id, e.part_id, NOW(), e.error_code, e.description
                    FROM machine_part_errors e
                    WHERE e.id = ANY(%s)
                    RETURNING error_code
                """, (error_ids,))
                codes = [str(r[0]).strip() for r in cur.fetchall()]
        print(f"Dodano occurrences dla error_id: {error_ids}, kody: {codes}")

    except Exception as e:
        print("Blad zapisu do bazy:", e)
        traceback.print_exc()

    finally:
        if conn:
            conn.close()

    return codes


# ─────────────────────────────────────────────────────────
#  SERWER TCP
# ─────────────────────────────────────────────────────────

def recv_text(conn: socket.socket) -> str:
    """
    Czyta dane z gniazda az do otrzymania kompletnego JSON-a, zamkniecia
    polaczenia lub braku nowych danych przez JSON_MORE_TIMEOUT sekund.
    """
    data = b""
    conn.settimeout(None)
    while len(data) < MAX_MESSAGE_BYTES:
        try:
            chunk = conn.recv(BUFFER_SIZE)
        except socket.timeout:
            break
        if not chunk:
            break
        data += chunk
        text = data.decode("utf-8", errors="replace")
        try:
            json.loads(text.strip(" \r\n\t\x00"))
            break                       # kompletny JSON
        except json.JSONDecodeError:
            conn.settimeout(JSON_MORE_TIMEOUT)
    return data.decode("utf-8", errors="replace")


class TCPServer:
    def __init__(self, host='0.0.0.0', port=TCP_PORT):
        self.host = host
        self.port = port

    def start(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            try:
                s.bind((self.host, self.port))
                s.listen()
                print(f"Serwer TCP nasluchuje na {self.host}:{self.port}")
            except OSError as e:
                print(f"Blad przy uruchomieniu serwera TCP: {e}")
                return

            try:
                while True:
                    conn, addr = s.accept()
                    print(f"Polaczono z {addr}")
                    Thread(target=self.handle_client, args=(conn, addr), daemon=True).start()
            except KeyboardInterrupt:
                print("Serwer zatrzymany recznie.")

    def handle_client(self, conn, addr):
        with conn:
            try:
                data = recv_text(conn)
                print("-" * 60)
                print(f"Odebrano od {addr}: {data!r}")
                if not data:
                    return

                # alarm na ekran najpierw – niezaleznie od bazy
                check_alert_raw(data)

                try:
                    parsed = json.loads(data.strip(" \r\n\t\x00"))
                except json.JSONDecodeError:
                    print("Nieprawidlowy format JSON - pomijam zapis do bazy")
                    conn.sendall(b"Blad danych\n")
                    return

                insert_part_error_occurrences(parse_alarm_ids(parsed))
                conn.sendall(b"OK\n")
                print("-" * 60)

            except Exception as e:
                print(f"Blad klienta {addr}: {e}")
                traceback.print_exc()
                try:
                    conn.sendall(b"Blad serwera\n")
                except OSError:
                    pass


# ─────────────────────────────────────────────────────────

if __name__ == "__main__":
    push_state_to_front()   # wyzerowanie alarm.json we froncie po starcie
    start_alarm_server()
    TCPServer().start()
