import socket
import json
import traceback
import psycopg2
from threading import Thread

# --- Konfiguracja bazy danych ---
DB_CONFIG = {
    "dbname": "postgres",
    "user": "postgres",
    "password": "Test1234!",
    "host": "localhost",
    "port": 5432,
    "sslmode": "disable"   # 🔑 zmiana tutaj
}
# --- Funkcja aktualizacji pojedynczego rekordu ---
def update_machine_part_stat(data: dict):
    try:
        part_id = int(data["part_id"])
        counter = int(data["counter"])
        is_empty = bool(data["is_empty"])

        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor()

        # Sprawdzenie, czy rekord istnieje
        cur.execute("SELECT id FROM machine_part_stats WHERE part_id = %s", (part_id,))
        result = cur.fetchone()
        if not result:
            print(f"⚠️ Nie znaleziono części o part_id={part_id}")
            cur.close()
            conn.close()
            return False

        # Aktualizacja rekordu
        cur.execute("""
            UPDATE machine_part_stats
            SET counter = %s,
                is_empty = %s
            WHERE part_id = %s
        """, (counter, is_empty, part_id))
        conn.commit()

        print(f"✅ Zaktualizowano part_id={part_id}: counter={counter}, is_empty={is_empty}")
        cur.close()
        conn.close()
        return True

    except Exception as e:
        print(f"❌ Błąd aktualizacji: {e}")
        traceback.print_exc()
        return False


# --- Serwer TCP ---===
class TCPServer:
    def __init__(self, host='0.0.0.0', port=4200):
        self.host = host
        self.port = port

    def start(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            try:
                s.bind((self.host, self.port))
                s.listen()
                print(f"🚀 Serwer nasłuchuje na {self.host}:{self.port}")
            except Exception as e:
                print(f"❌ Błąd przy uruchomieniu serwera: {e}")
                return

            try:
                while True:
                    conn, addr = s.accept()
                    print(f"🔌 Połączono z {addr}")
                    client_thread = Thread(target=self.handle_client, args=(conn, addr))
                    client_thread.start()
            except KeyboardInterrupt:
                print("🛑 Serwer zatrzymany ręcznie.")
            except Exception as e:
                print(f"❌ Błąd działania serwera: {e}")

    def handle_client(self, conn, addr):
        with conn:
            try:
                data = conn.recv(4096).decode()  # większy bufor
                print(f"📥 Odebrano od {addr}: {data}")
                if not data:
                    return

                parsed = json.loads(data)

                # --- Jeśli lista obiektów ---
                if isinstance(parsed, list):
                    print(f"📦 Odebrano listę {len(parsed)} rekordów")
                    success_count = 0
                    for item in parsed:
                        if update_machine_part_stat(item):
                            success_count += 1
                    conn.sendall(f"OK - zaktualizowano {success_count}/{len(parsed)} rekordów\n".encode())

                # --- Jeśli pojedynczy obiekt ---
                elif isinstance(parsed, dict):
                    success = update_machine_part_stat(parsed)
                    if success:
                        conn.sendall(b"OK - pojedynczy rekord zaktualizowany\n")
                    else:
                        conn.sendall(b"Nie znaleziono czesci\n")

                else:
                    conn.sendall(b"Blad - nieprawidlowy format JSON\n")

            except json.JSONDecodeError:
                print("⚠️ Nieprawidłowy format JSON")
                conn.sendall(b"Blad danych JSON\n")
            except Exception as e:
                print(f"❌ Błąd klienta {addr}: {e}")
                traceback.print_exc()
                conn.sendall(b"Blad serwera\n")


if __name__ == "__main__":
    server = TCPServer(port=4200)
    server.start()
