"""
=============================================================================
SprFinishApl BRIDGE – zamkniecie palety
=============================================================================

PLC  --TCP:4400-->  Bridge  --POST /SprFinishApl-->  WMS Wilk
PLC  <--TCP:4401--  Bridge  <-- OK / NOK         --  WMS Wilk

PLC wysyla:  {"sscc": "020012340000738569"}
PLC dostaje: OK  lub  NOK

URUCHOMIENIE:
    pip install requests
    python finish_bridge.py
=============================================================================
"""

import json
import socket
import threading
import time
import queue
import logging
import requests

# =============================================================================
# KONFIGURACJA
# =============================================================================

TCP_IP          = "0.0.0.0"
PORT_IN         = 4400
PORT_OUT        = 4401
BUFFER_SIZE     = 4096


WMS_URL     = "http://192.168.1.34:8080/WilkRestServer/Wilk/SprFinishApl"
WMS_TIMEOUT = 10

# =============================================================================
# LOGGING
# =============================================================================

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s  %(levelname)-8s  %(message)s",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler("finish_bridge.log", encoding="utf-8"),
    ]
)
log = logging.getLogger("finish")

# =============================================================================
# KOLEJKA
# =============================================================================

finish_queue = queue.Queue()

# =============================================================================
# PORT 4400 – odbior SSCC od PLC
# =============================================================================

def server_input():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((TCP_IP, PORT_IN))
    s.listen(5)
    log.info("📥 INPUT nasluchuje na porcie %d", PORT_IN)

    while True:
        conn, addr = s.accept()
        threading.Thread(
            target=handle_input,
            args=(conn, addr),
            daemon=True
        ).start()


def handle_input(conn, addr):
    log.info("🔗 INPUT polaczenie od: %s", addr)
    try:
        raw = conn.recv(BUFFER_SIZE)
        if not raw:
            log.warning("⚠️ Puste dane od %s", addr)
            return

        # PLC wysyla JSON: {"sscc": "020012340000738569"}
        text = raw.decode("utf-8", errors="replace").strip()
        log.debug("📨 RAW: %s", text)

        try:
            obj = json.loads(text)
            if isinstance(obj, dict):
                sscc = str(obj.get("sscc") or obj.get("SSCC") or "").strip()
            else:
                sscc = str(obj).strip().strip('"')
        except Exception:
            sscc = text.strip().strip('"').strip("'")

        log.info("📦 Odebrano SSCC: [%s] od %s", sscc, addr)
        finish_queue.put(sscc)
        log.info("💾 SSCC dodane do kolejki")

    except Exception as e:
        log.error("❌ Blad INPUT %s: %s", addr, e)
    finally:
        conn.close()


# =============================================================================
# PORT 4401 – wysylanie OK lub NOK do PLC
# =============================================================================

def server_output():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((TCP_IP, PORT_OUT))
    s.listen(5)
    log.info("📤 OUTPUT nasluchuje na porcie %d", PORT_OUT)

    while True:
        conn, addr = s.accept()
        threading.Thread(
            target=handle_output,
            args=(conn, addr),
            daemon=True
        ).start()


def handle_output(conn, addr):
    log.info("🔗 OUTPUT polaczenie od: %s", addr)
    try:
        # Czekaj na SSCC z kolejki
        sscc = None
        while sscc is None:
            try:
                sscc = finish_queue.get_nowait()
            except queue.Empty:
                time.sleep(0.1)

        log.info("➡️ POST %s  sscc=%s", WMS_URL, sscc)

        # Wyslij do WMS
        try:
            resp = requests.post(
                WMS_URL,
                json={"sscc": sscc},
                timeout=WMS_TIMEOUT,
                headers={"Content-Type": "application/json"}
            )
        except requests.Timeout:
            log.error("❌ WMS timeout")
            conn.send(b"NOK")
            return
        except requests.ConnectionError as e:
            log.error("❌ WMS brak polaczenia: %s", e)
            conn.send(b"NOK")
            return
        except Exception as e:
            log.error("❌ WMS blad: %s", e)
            conn.send(b"NOK")
            return

        log.debug("WMS HTTP=%d body=%s", resp.status_code, resp.text[:200])

        if not resp.text or not resp.text.strip():
            log.info("✅ WMS zwrocil puste body – traktujemy jako OK  sscc=%s", sscc)
            conn.send(b"OK")
            return

        # Parsuj odpowiedz WMS – dwa mozliwe formaty:
        # Format A: {"SPR_FINISH_APL_RES_HR": {"status": "OK", "message": "..."}}
        # Format B: {"status": "OK", "message": "..."}  (plaska odpowiedz)
        try:
            resp_json = resp.json()

            # Sprawdz format A najpierw
            if "SPR_FINISH_APL_RES_HR" in resp_json:
                res = resp_json["SPR_FINISH_APL_RES_HR"]
            else:
                res = resp_json

            wms_status = res.get("status", "")
            wms_msg    = res.get("message", "")

            if wms_status == "OK":
                log.info("✅ WMS zamknal palete  sscc=%s  msg=%s", sscc, wms_msg)
                conn.send(b"OK")
            else:
                log.warning("❌ WMS blad  sscc=%s  status=%s  msg=%s",
                            sscc, wms_status, wms_msg)
                conn.send(b"NOK")

        except Exception:
            log.error("❌ WMS niepoprawna odpowiedz: %s", resp.text[:100])
            conn.send(b"NOK")

    except Exception as e:
        log.exception("❌ Blad OUTPUT %s: %s", addr, e)
        try:
            conn.send(b"NOK")
        except Exception:
            pass
    finally:
        conn.close()
        log.info("🔌 Rozlaczono OUTPUT: %s", addr)


# =============================================================================
# START
# =============================================================================

if __name__ == "__main__":
    log.info("=" * 55)
    log.info("  SprFinishApl Bridge")
    log.info("  TCP IN  : %d  (PLC wysyla SSCC)", PORT_IN)
    log.info("  TCP OUT : %d  (PLC odbiera OK/NOK)", PORT_OUT)
    log.info("  WMS     : %s", WMS_URL)
    log.info("=" * 55)

    t1 = threading.Thread(target=server_input,  daemon=True)
    t2 = threading.Thread(target=server_output, daemon=True)

    t1.start()
    t2.start()

    log.info("🚀 Bridge uruchomiony")

    try:
        t1.join()
        t2.join()
    except KeyboardInterrupt:
        log.info("Bridge zatrzymany (Ctrl+C)")
