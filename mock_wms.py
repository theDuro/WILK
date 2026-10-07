"""
Atrapa (mock) systemu WMS do testow WMS_BRIDGE.py bez prawdziwego WMS.

Udaje dwa endpointy WilkRestServer:
    POST /WilkRestServer/Wilk/Spr            – zalozenie zlecenia, zwraca SSCC
    POST /WilkRestServer/Wilk/SprLabelPrint  – dane etykiety (waga, produkt)

Uruchomienie:
    python mock_wms.py            (nasluchuje na porcie 8081)

i bridge skierowany na atrape (Windows cmd):
    set WMS_BASE=http://127.0.0.1:8081/WilkRestServer/Wilk
    python WMS_BRIDGE.py
"""

import json
import random
from datetime import datetime
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

PORT = 8081
PREFIX = "/WilkRestServer/Wilk"


class MockWmsHandler(BaseHTTPRequestHandler):

    def _send_json(self, body: dict):
        data = json.dumps(body, ensure_ascii=False).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_POST(self):
        length = int(self.headers.get("Content-Length") or 0)
        try:
            body = json.loads(self.rfile.read(length) or b"{}")
        except ValueError:
            body = {}

        if self.path == PREFIX + "/Spr":
            header = (body.get("SPR_HEADER") or [{}])[0]
            items = header.get("SPR_ITEM") or []
            if not items:
                # zachowanie jak w prawdziwym WMS przy blednym zleceniu
                self._send_json({"c_order_nr": header.get("C_ORDER_NR"), "status": "ER",
                                 "error": "NO_ITEMS", "message": "Zlecenie bez pozycji"})
                return
            sscc = "0200" + "".join(random.choice("0123456789") for _ in range(14))
            self._send_json({"c_order_nr": header.get("C_ORDER_NR"), "status": "OK",
                             "error": "IMPORT_COMPLETED", "message": "Import zakończony sukcesem",
                             "sscc": sscc})

        elif self.path == PREFIX + "/SprLabelPrint":
            self._send_json({
                "c_order_nr": body.get("c_order_nr"),
                "status": "OK",
                "sscc": body.get("sscc"),
                "picking_date": datetime.now().strftime("%Y-%m-%d"),
                "gross_weight_kg": "25,0054",
                "SPR_LABEL_PRINT_RES_IT": [
                    {"position_nr": "1", "product_nr": "0100000039",
                     "product_name": "Produkt testowy", "prod_serial_nr": "Partia",
                     "bu_quantity": "2"}
                ],
            })
        else:
            self.send_response(404)
            self.end_headers()


if __name__ == "__main__":
    print(f"Mock WMS na http://127.0.0.1:{PORT}{PREFIX}")
    ThreadingHTTPServer(("0.0.0.0", PORT), MockWmsHandler).serve_forever()
