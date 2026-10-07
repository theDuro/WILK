import socket
import json
import re
import os
import tempfile
import subprocess
import psycopg2
import traceback
from threading import Thread, Lock
from http.server import BaseHTTPRequestHandler, HTTPServer
from socketserver import ThreadingMixIn

# ─────────────────────────────────────────────────────────
#  KONFIGURACJA
# ─────────────────────────────────────────────────────────

DB_CONFIG = {
    "dbname": "postgres",
    "user": "postgres",
    "password": "Test1234!",
    "host": "localhost",
    "port": 5432,
    "sslmode": "disable"
}

ALERT_IDS = {440}
TCP_PORT = 4000
ALARM_PORT = 4100                 # tylko do recznego testu /test
FRONT_CONTAINER = "autosoft_front"
FRONT_PATH = "/app/build/alarm.json"


# ─────────────────────────────────────────────────────────
#  STAN ALARMU
# ─────────────────────────────────────────────────────────

_alock = Lock()
_astate = {"seq": 0, "code": None}


def push_state_to_front():
    """Zapisuje stan alarmu jako plik serwowany przez port 8080."""
    try:
        with _alock:
            payload = json.dumps(_astate)
        tmp = os.path.join(tempfile.gettempdir(), "alarm.json")
        with open(tmp, "w") as f:
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
    """Szuka ALERT_IDS w surowym tekscie. Odporne na format danych."""
    found = set(int(n) for n in re.findall(r'\d+', text))
    hit = found & ALERT_IDS
    print(f"[CHECK] liczby w danych: {sorted(found)}")
    if hit:
        code = sorted(hit)[0]
        print(f"[CHECK] ZNALEZIONO {code}")
        trigger_alarm(code)
        return True
    print(f"[CHECK] brak {ALERT_IDS} w danych")
    return False


# ─────────────────────────────────────────────────────────
#  MALY SERWER HTTP - tylko do recznego testu
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
        pass


def start_alarm_server():
    try:
        srv = ThreadedHTTPServer(("0.0.0.0", ALARM_PORT), AlarmHandler)
        Thread(target=srv.serve_forever, daemon=True).start()
        print(f"Serwer testowy na porcie {ALARM_PORT}")
        print(f"  test recznie:  http://localhost:{ALARM_PORT}/test")
    except Exception as e:
        print(f"BLAD serwera testowego: {e}")


# ─────────────────────────────────────────────────────────
#  ZAPIS DO BAZY
# ─────────────────────────────────────────────────────────

def insert_part_error_occurrences(error_ids):
    if not error_ids:
        print("Brak alarmow do dodania")
        return []

    conn = None
    cur = None
    codes = []

    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor()
        query = """
            INSERT INTO machine_part_error_occurrences (
                error_id, part_id, occurred_at, error_code, description
            )
            SELECT
                e.id,
                e.part_id,
                NOW(),
                e.error_code,
                e.description
            FROM machine_part_errors e
            WHERE e.id = ANY(%s)
            RETURNING error_code
        """
        cur.execute(query, (error_ids,))
        codes = [str(r[0]).strip() for r in cur.fetchall()]
        conn.commit()
        print(f"Dodano occurrences dla error_id: {error_ids}, kody: {codes}")

    except Exception as e:
        print("Blad zapisu do bazy:", e)
        traceback.print_exc()

    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

    return codes


# ─────────────────────────────────────────────────────────
#  SERWER TCP
# ─────────────────────────────────────────────────────────

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
            except Exception as e:
                print(f"Blad przy uruchomieniu serwera TCP: {e}")
                return

            try:
                while True:
                    conn, addr = s.accept()
                    print(f"Polaczono z {addr}")
                    Thread(target=self.handle_client,
                           args=(conn, addr), daemon=True).start()
            except KeyboardInterrupt:
                print("Serwer zatrzymany recznie.")
            except Exception as e:
                print(f"Blad dzialania serwera: {e}")

    def handle_client(self, conn, addr):
        with conn:
            try:
                data = conn.recv(4096).decode()
                print("-" * 60)
                print(f"Odebrano od {addr}: {data}")

                if not data:
                    return

                # alarm najpierw - niezaleznie od bazy
                check_alert_raw(data)

                try:
                    parsed = json.loads(data)
                    alarms = parsed.get("alarms", [])
                    insert_part_error_occurrences(alarms)
                except json.JSONDecodeError:
                    print("Nieprawidlowy format JSON - pomijam zapis do bazy")
                    conn.sendall(b"Blad danych\n")
                    return

                conn.sendall(b"OK\n")
                print("-" * 60)

            except Exception as e:
                print(f"Blad klienta {addr}: {e}")
                traceback.print_exc()
                try:
                    conn.sendall(b"Blad serwera\n")
                except Exception:
                    pass


# ─────────────────────────────────────────────────────────

if __name__ == "__main__":
    push_state_to_front()
    start_alarm_server()
    server = TCPServer()
    server.start()