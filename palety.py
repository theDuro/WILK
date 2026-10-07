"""
=============================================================================
PALETY – serwer TCP aktualizujacy liczniki/stany czesci (machine_part_stats)
=============================================================================

PLC wysyla na port 4200 JSON z jednym obiektem albo lista obiektow:
    {"part_id": 21, "counter": 5, "is_empty": false}
    [{"part_id": 21, "counter": 5, "is_empty": false}, {...}]

Dla kazdego obiektu aktualizowane sa wszystkie wiersze machine_part_stats
z danym part_id. Front (kafelki "OK" / "MALO" / "BRAK") odczytuje te dane
przez API Flask.

Konwencja frontu: is_empty = true -> BRAK, counter = -1 -> MALO.

Odpowiedz do PLC (tekst):
    "OK - zaktualizowano X/Y rekordow"         – dla listy
    "OK - pojedynczy rekord zaktualizowany"    – dla obiektu
    "Nie znaleziono czesci" / "Blad ..."       – przy bledach

Konfiguracja bazy: stale ponizej lub zmienne srodowiskowe DB_HOST, DB_PORT,
DB_NAME, DB_USER, DB_PASSWORD. Port TCP: PALETY_PORT.
=============================================================================
"""

import json
import os
import socket
import traceback
from threading import Thread

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

TCP_PORT          = int(os.environ.get("PALETY_PORT", 4200))
BUFFER_SIZE       = 4096
JSON_MORE_TIMEOUT = 2.0          # [s] ile czekac na reszte niepelnego JSON-a
MAX_MESSAGE_BYTES = 1024 * 1024


# ─────────────────────────────────────────────────────────
#  POMOCNICZE
# ─────────────────────────────────────────────────────────

def parse_bool(value) -> bool:
    """bool("false") w Pythonie to True – dlatego napisy obslugujemy jawnie."""
    if isinstance(value, str):
        return value.strip().lower() in ("1", "true", "t", "yes", "y", "tak")
    return bool(value)


def _decode_json(data: bytes):
    """Dekoduje pierwszy kompletny JSON z bufora (ignoruje padding/null-e po nim)."""
    text = data.decode("utf-8", errors="replace")
    starts = [i for i in (text.find("["), text.find("{")) if i != -1]
    if not starts:
        raise json.JSONDecodeError("Brak poczatku JSON ('[' lub '{')", text, 0)
    obj, _end = json.JSONDecoder().raw_decode(text, min(starts))
    return obj


def recv_json(conn: socket.socket):
    """
    Czyta z gniazda az do otrzymania kompletnego JSON-a (wczesniej byl jeden
    recv(4096), ktory mogl uciac dluzsza wiadomosc).
    Zwraca (surowe_bajty, obiekt) lub (surowe_bajty, None) gdy JSON jest bledny.
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
        try:
            return data, _decode_json(data)
        except json.JSONDecodeError:
            conn.settimeout(JSON_MORE_TIMEOUT)
    return data, None


# ─────────────────────────────────────────────────────────
#  BAZA DANYCH
# ─────────────────────────────────────────────────────────

def update_machine_part_stat(cur, data: dict) -> bool:
    """
    Aktualizuje licznik czesci. Zwraca True, jesli rekord istnial i zostal
    zaktualizowany. Bledne dane (brak pola, zly typ) -> False.
    """
    try:
        part_id = int(data["part_id"])
        counter = int(data["counter"])
        is_empty = parse_bool(data["is_empty"])
    except (KeyError, TypeError, ValueError) as e:
        print(f"⚠️ Niepoprawny rekord {data!r}: {e}")
        return False

    cur.execute("""
        UPDATE machine_part_stats
        SET counter = %s,
            is_empty = %s
        WHERE part_id = %s
    """, (counter, is_empty, part_id))

    if cur.rowcount == 0:
        print(f"⚠️ Nie znaleziono części o part_id={part_id}")
        return False

    print(f"✅ Zaktualizowano part_id={part_id}: counter={counter}, is_empty={is_empty}")
    return True


def update_many(items: list) -> int:
    """Aktualizuje wiele rekordow w jednej transakcji. Zwraca liczbe zaktualizowanych."""
    conn = psycopg2.connect(**DB_CONFIG)
    try:
        with conn:                      # commit na koniec / rollback przy wyjatku
            with conn.cursor() as cur:
                return sum(1 for item in items
                           if isinstance(item, dict) and update_machine_part_stat(cur, item))
    finally:
        conn.close()


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
                print(f"🚀 Serwer nasłuchuje na {self.host}:{self.port}")
            except OSError as e:
                print(f"❌ Błąd przy uruchomieniu serwera: {e}")
                return

            try:
                while True:
                    conn, addr = s.accept()
                    print(f"🔌 Połączono z {addr}")
                    Thread(target=self.handle_client, args=(conn, addr), daemon=True).start()
            except KeyboardInterrupt:
                print("🛑 Serwer zatrzymany ręcznie.")

    def handle_client(self, conn, addr):
        with conn:
            try:
                raw, parsed = recv_json(conn)
                print(f"📥 Odebrano od {addr}: {raw!r}")
                if not raw:
                    return

                if parsed is None:
                    print("⚠️ Nieprawidłowy format JSON")
                    conn.sendall(b"Blad danych JSON\n")
                    return

                if isinstance(parsed, list):
                    print(f"📦 Odebrano listę {len(parsed)} rekordów")
                    success_count = update_many(parsed)
                    conn.sendall(f"OK - zaktualizowano {success_count}/{len(parsed)} rekordów\n".encode())

                elif isinstance(parsed, dict):
                    if update_many([parsed]):
                        conn.sendall(b"OK - pojedynczy rekord zaktualizowany\n")
                    else:
                        conn.sendall(b"Nie znaleziono czesci\n")

                else:
                    conn.sendall(b"Blad - nieprawidlowy format JSON\n")

            except Exception as e:
                print(f"❌ Błąd klienta {addr}: {e}")
                traceback.print_exc()
                try:
                    conn.sendall(b"Blad serwera\n")
                except OSError:
                    pass  # klient juz sie rozlaczyl


if __name__ == "__main__":
    TCPServer().start()
