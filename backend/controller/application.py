"""
API REST (Flask) dla dashboardu WILK / Niverplast.

Uruchomienie (z katalogu backend/):
    python -m controller.application

Konfiguracja przez zmienne srodowiskowe:
    PORT            – port HTTP (domyslnie 5000)
    DATABASE_URL    – adres bazy (patrz repository/autosoftrep.py)
    JWT_SECRET_KEY  – klucz do podpisywania tokenow JWT
    FLASK_DEBUG     – "1" wlacza tryb debug Flaska (domyslnie wylaczony)

Formaty odpowiedzi celowo NIE zostaly zmienione wzgledem poprzedniej wersji,
bo zbudowany frontend (front/build) na nich polega – np. daty w polu
`occurred_at` sa serializowane domyslnym formatem Flaska
("Tue, 06 May 2026 10:18:36 GMT"), ktory front parsuje przez `new Date(...)`.
"""

import json
import os
import threading
from datetime import datetime, timedelta, timezone
from queue import Queue, Empty

from flask import Flask, jsonify, request, Response, stream_with_context
from flask_cors import CORS
from flask_jwt_extended import JWTManager, create_access_token

from repository.autosoftrep import AutoSoftRepository

# ------------------ Flask setup ------------------
app = Flask(__name__)
CORS(app)  # front dziala na innym porcie (8080), wiec potrzebny jest CORS
app.config["JWT_SECRET_KEY"] = os.environ.get("JWT_SECRET_KEY", "tajny_klucz")
jwt = JWTManager(app)

repo = AutoSoftRepository()


# ------------------ SSE: powiadamianie klientow o zmianach ------------------
# Kazdy podlaczony klient /api/stream dostaje wlasna kolejke. Endpointy zapisujace
# dane wywoluja notify_sse(), co budzi WSZYSTKICH klientow (wczesniej byla jedna
# wspolna kolejka i sygnal trafial tylko do jednego z nich).
_sse_clients: list[Queue] = []
_sse_lock = threading.Lock()


def notify_sse() -> None:
    """Sygnalizuje wszystkim klientom SSE, ze dane sie zmienily."""
    with _sse_lock:
        for q in _sse_clients:
            q.put(True)


# ------------------ helpery ------------------
def parse_bool(value) -> bool:
    """
    Zamienia wartosc z JSON-a na bool. Uwaga: bool("false") w Pythonie to True,
    dlatego napisy "false"/"0"/"nie" itp. sa obslugiwane jawnie.
    """
    if isinstance(value, str):
        return value.strip().lower() in ("1", "true", "t", "yes", "y", "tak")
    return bool(value)


def parse_date_from(raw: str) -> datetime:
    """
    Parsuje parametr date_from (ISO 8601, np. z JS: 2026-05-06T08:18:36.000Z).
    Daty w bazie sa zapisywane w UTC bez strefy, wiec date ze strefa
    przeliczamy na UTC i usuwamy informacje o strefie.
    """
    if not raw:
        raise ValueError("brak parametru date_from")
    dt = datetime.fromisoformat(raw)
    if dt.tzinfo is not None:
        dt = dt.astimezone(timezone.utc).replace(tzinfo=None)
    return dt


def to_primitive(obj):
    """Rekurencyjnie zamienia DTO/datetime/listy na typy, ktore przyjmie json.dumps."""
    if obj is None or isinstance(obj, (str, int, float, bool)):
        return obj
    if isinstance(obj, datetime):
        return obj.isoformat()
    if isinstance(obj, (list, tuple)):
        return [to_primitive(i) for i in obj]
    if isinstance(obj, dict):
        return {k: to_primitive(v) for k, v in obj.items()}
    # obiekty DTO z metoda to_dict()
    if hasattr(obj, "to_dict") and callable(obj.to_dict):
        try:
            return to_primitive(obj.to_dict())
        except Exception:
            pass
    # inne obiekty z __dict__
    if hasattr(obj, "__dict__"):
        return {k: to_primitive(v) for k, v in vars(obj).items()}
    return str(obj)


def get_payload(machine_id: int = 1) -> dict:
    """
    Zwraca serializowalny "snapshot" stanu maszyny dla strumienia SSE:
      - parts       – lista czesci,
      - counters    – liczniki czesci,
      - last_errors – 10 ostatnich wystapien alarmow,
      - error_str   – wystapienia alarmow z ostatnich 30 dni,
      - timestamp.
    """
    try:
        date_from = datetime.now(timezone.utc).replace(tzinfo=None) - timedelta(days=30)

        payload = {
            "timestamp": datetime.now().isoformat(),
            "machine_id": machine_id,
            "parts": to_primitive(repo.get_machine_parts_by_machine_id(machine_id)),
            "counters": to_primitive(repo.get_stats_for_machine(machine_id)),
            "last_errors": to_primitive(repo.get_last_errors(machine_id)),
            "error_str": to_primitive(
                repo.get_error_code_for_machine_in_date_range(machine_id, date_from)
            ),
        }
        return payload

    except Exception as e:
        # blad nie moze zamknac strumienia – zwracamy opis bledu
        app.logger.exception("Blad w get_payload()")
        return {"timestamp": datetime.now().isoformat(), "error": "get_payload_failed", "msg": str(e)}


# ------------------ TEST / PING ------------------
@app.route("/ping", methods=["GET"])
def ping():
    return jsonify({"message": "pong"}), 200


@app.route('/test', methods=['GET'])
def test():
    return jsonify("TEST")


# ------------------ MACHINE DATA ------------------
@app.route('/api/get_machine_data_by_company_id/<int:company_id>', methods=['GET'])
def get_machine_data_by_company_id(company_id):
    result = repo.get_all_machine_data_by_company_id_dto(company_id)
    return jsonify([item.__dict__ for item in result])


@app.route('/api/get_machine_data_by_id/<int:machine_id>', methods=['GET'])
def get_machine_data_by_id(machine_id):
    result = repo.get_machine_data_dto_by_id(machine_id)
    return jsonify([item.__dict__ for item in result])


@app.route('/api/get_machines_by_company_id/<int:company_id>', methods=['GET'])
def get_all_machines_by_company_id(company_id):
    result = repo.get_machines_dto_by_company_id(company_id)
    return jsonify([item.to_dict() for item in result])


# ------------------ MACHINE CONFIG ------------------
@app.route('/api/get_conf_by_machine_id/<int:machine_id>', methods=['GET'])
def get_conf_by_machine_id(machine_id):
    """Zwraca konfiguracje maszyny (JSON z kolumny machines.config)."""
    try:
        result = repo.get_machine_config(machine_id)
    except ValueError as e:
        return jsonify({'error': str(e)}), 404

    if not result:
        return jsonify([])

    if isinstance(result, dict):
        return jsonify(result)

    if isinstance(result, list):
        # konfiguracja moze byc tez lista slownikow albo lista napisow JSON
        first_item = result[0]
        if isinstance(first_item, str):
            try:
                return jsonify([json.loads(item) for item in result])
            except json.JSONDecodeError:
                return jsonify({'error': 'Invalid JSON format in list'}), 500
        if isinstance(first_item, dict):
            return jsonify(result)
        return jsonify({'error': f'Unsupported list item type: {type(first_item).__name__}'}), 500

    return jsonify({'error': f'Unsupported data type: {type(result).__name__}'}), 500


@app.route('/api/update_conf_by_machine_id/<int:machine_id>', methods=['POST'])
def update_conf_by_machine_id(machine_id):
    """Nadpisuje konfiguracje maszyny. Body: {"new_config": {...}}."""
    data = request.get_json(silent=True)
    if not isinstance(data, dict):
        return jsonify({'error': 'Body musi byc obiektem JSON'}), 400
    new_config = data.get('new_config')
    if new_config is None:
        return jsonify({'error': 'Missing new_config in request body'}), 400
    try:
        repo.update_machine_config(machine_id, new_config)
        return jsonify({'status': 'success', 'message': f'Machine {machine_id} config updated successfully'})
    except ValueError as e:
        return jsonify({'error': str(e)}), 404
    except Exception as e:
        app.logger.exception("Blad zapisu konfiguracji")
        return jsonify({'error': 'Unexpected error', 'details': str(e)}), 500


# ------------------ ERRORS / ALARMY ------------------
@app.route('/api/get_errors_by_company_id/<int:company_id>', methods=['GET'])
def get_errors_by_company_id(company_id):
    result = repo.get_all_errors_by_company_id(company_id)
    return jsonify([e.__dict__ for e in result])


@app.route('/api/get_errors_by_machine_id/<int:machine_id>', methods=['GET'])
def get_errors_by_machine_id(machine_id):
    result = repo.get_error_by_machine_id(machine_id)
    return jsonify([e.__dict__ for e in result])


@app.route('/api/get_machine_parts_by_machine_id/<int:machine_id>', methods=['GET'])
def api_get_machine_parts_by_machine_id(machine_id):
    result = repo.get_machine_parts_by_machine_id(machine_id)
    return jsonify([p.__dict__ for p in result])


@app.route('/api/get_part_errors/<int:part_id>', methods=['GET'])
def api_get_part_errors(part_id):
    result = repo.get_errors_for_part(part_id)
    return jsonify([e.__dict__ for e in result])


@app.route('/api/get_occurrences_by_machine_id/<int:machine_id>', methods=['GET'])
def api_get_occurrences_by_machine_id(machine_id):
    result = repo.get_occurrences_by_machine_id(machine_id)
    return jsonify([o.__dict__ for o in result])


@app.route('/api/get_all_occurrences', methods=['GET'])
def api_get_all_occurrences():
    result = repo.get_all_occurrences()
    return jsonify([o.__dict__ for o in result])


@app.route('/api/get_error_ids', methods=['GET'])
def api_get_error_ids():
    """?part_id=..&date_from=ISO -> lista error_id."""
    try:
        part_id = int(request.args.get("part_id"))
        date_from = parse_date_from(request.args.get("date_from"))
    except (TypeError, ValueError) as e:
        return jsonify({"error": f"Invalid input: {str(e)}"}), 400
    return jsonify(repo.get_error_ids_for_part_in_date_range(part_id, date_from))


@app.route('/api/get_error_str', methods=['GET'])
def api_get_error_str():
    """?part_id=..&date_from=ISO -> lista unikalnych kodow alarmow, np. ["A305"]."""
    try:
        part_id = int(request.args.get("part_id"))
        date_from = parse_date_from(request.args.get("date_from"))
    except (TypeError, ValueError) as e:
        return jsonify({"error": f"Invalid input: {str(e)}"}), 400
    return jsonify(repo.get_error_code_for_part_in_date_range(part_id, date_from))


@app.route('/api/get_error_for_parts', methods=['GET'])
def api_get_error():
    """?part_id=..&date_from=ISO -> pelne wystapienia alarmow czesci."""
    try:
        part_id = int(request.args.get("part_id"))
        date_from = parse_date_from(request.args.get("date_from"))
    except (TypeError, ValueError) as e:
        return jsonify({"error": f"Invalid input: {str(e)}"}), 400
    return jsonify(repo.get_occurrences_by_part_id_and_date(part_id, date_from))


@app.route('/api/get_last_errors/<int:machine_id>', methods=['GET'])
def api_get_last_errors(machine_id):
    """Maks. 4 ostatnie alarmy maszyny z unikalnym kodem (z 10 ostatnich wystapien)."""
    errors = repo.get_last_errors(machine_id)

    unique_errors = []
    seen_codes = set()
    for error in errors:
        if error.error_code not in seen_codes:
            unique_errors.append(error)
            seen_codes.add(error.error_code)
        if len(unique_errors) == 4:
            break

    return jsonify([e.__dict__ for e in unique_errors]), 200


@app.route('/api/get_error_for_machine', methods=['GET'])
def api_get_error_mahine_and_time():
    """?machine_id=..&date_from=ISO -> wystapienia alarmow calej maszyny."""
    try:
        machine_id = int(request.args.get("machine_id"))
        date_from = parse_date_from(request.args.get("date_from"))
    except (TypeError, ValueError) as e:
        return jsonify({"error": f"Invalid input: {str(e)}"}), 400
    result = repo.get_error_code_for_machine_in_date_range(machine_id, date_from)
    return jsonify([e.__dict__ for e in result]), 200


# ------------------ STATS / LICZNIKI ------------------
@app.route('/api/get_prts_counters', methods=['GET'])
def api_get_stats():
    """?machine_id=.. -> liczniki czesci (machine_part_stats)."""
    try:
        machine_id = int(request.args.get("machine_id"))
    except (TypeError, ValueError) as e:
        return jsonify({"error": f"Invalid input: {str(e)}"}), 400
    return jsonify(repo.get_stats_for_machine(machine_id))


# ------------------ LOGIN ------------------
@app.route("/api/login", methods=["POST"])
def login():
    """Body: {"username": "...", "password": "..."} -> {"access_token": "..."}."""
    data = request.get_json(silent=True)
    if not isinstance(data, dict):
        return jsonify(msg="Brak loginu lub hasla"), 400

    username = data.get("username")
    password = data.get("password")
    if not username or not password:
        return jsonify(msg="Brak loginu lub hasla"), 400

    company = repo.get_company_with_login(username)
    if not company or company.password != password:
        return jsonify(msg="Bledny login lub haslo"), 401

    # identity MUSI byc napisem (flask_jwt_extended 4.7 / PyJWT odrzuca inne typy
    # przy weryfikacji tokena), dodatkowe dane ida w additional_claims.
    access_token = create_access_token(
        identity=str(company.id),
        additional_claims={"company_id": company.id, "login": company.login},
    )
    return jsonify(access_token=access_token), 200


# ------------------ ZAPIS DANYCH (POST) ------------------
def _parse_stat_item(item) -> tuple[int, int, bool]:
    """Wyciaga (part_id, counter, is_empty) z obiektu JSON. Rzuca KeyError/ValueError/TypeError."""
    return int(item["part_id"]), int(item["counter"]), parse_bool(item["is_empty"])


@app.route('/api/update_machine_part_stat', methods=['POST'])
def api_update_machine_part_stat():
    """
    Aktualizuje statystyki czesci maszyny.
    Body: {"part_id": 1, "counter": 10, "is_empty": false} lub lista takich obiektow.
    """
    data = request.get_json(force=True, silent=True)
    if not data:
        return jsonify({"error": "Brak danych JSON"}), 400

    # --- lista obiektow ---
    if isinstance(data, list):
        updated = 0
        for item in data:
            try:
                part_id, counter, is_empty = _parse_stat_item(item)
            except (KeyError, ValueError, TypeError):
                continue  # pomijamy niepoprawne pozycje
            if repo.update_machine_part_stat(part_id, counter, is_empty):
                updated += 1
        if updated:
            notify_sse()
        return jsonify({"status": "ok", "updated": updated, "received": len(data)}), 200

    # --- pojedynczy obiekt ---
    if isinstance(data, dict):
        try:
            part_id, counter, is_empty = _parse_stat_item(data)
        except (KeyError, ValueError, TypeError):
            return jsonify({"error": "Nieprawidłowe dane wejściowe"}), 400

        if repo.update_machine_part_stat(part_id, counter, is_empty):
            notify_sse()
            return jsonify({"status": "ok", "message": f"part_id={part_id} zaktualizowany"}), 200
        return jsonify({"error": f"Nie znaleziono części o part_id={part_id}"}), 404

    return jsonify({"error": "Nieprawidłowy format JSON"}), 400


@app.route("/api/add_occurrences", methods=["POST"])
def api_add_occurrences():
    """Dodaje wystapienia alarmow. Body: {"alarms": [305, 312, ...]} (ID ze slownika)."""
    data = request.get_json(silent=True)
    if not isinstance(data, dict) or "alarms" not in data:
        return jsonify({"error": "Brak pola 'alarms' w JSON"}), 400

    alarms = data["alarms"]
    if not isinstance(alarms, list):
        return jsonify({"error": "Pole 'alarms' musi byc lista"}), 400
    try:
        alarms = [int(a) for a in alarms]
    except (TypeError, ValueError):
        return jsonify({"error": "Pole 'alarms' musi zawierac liczby"}), 400

    try:
        success = repo.insert_part_error_occurrences(alarms)
    except Exception:
        app.logger.exception("Blad zapisu alarmow")
        return jsonify({"error": "Blad serwera"}), 500

    if success:
        notify_sse()
        return jsonify({"status": "OK", "added": len(alarms)})
    return jsonify({"status": "FAIL"}), 500


# ------------------ STRUMIEN SSE ------------------
@app.route("/api/stream")
def sse_stream():
    """
    Server-Sent Events: /api/stream?machine_id=1
    Wysyla snapshot (get_payload) od razu po zmianie danych (POST-y wyzej)
    albo co 5 sekund, jesli nic sie nie zmienilo.
    """
    try:
        req_machine_id = int(request.args.get("machine_id") or 1)
    except ValueError:
        req_machine_id = 1

    client_queue: Queue = Queue()
    with _sse_lock:
        _sse_clients.append(client_queue)

    def generate():
        try:
            while True:
                try:
                    client_queue.get(timeout=5)
                except Empty:
                    pass  # brak zmian – i tak wysylamy aktualny snapshot

                payload = get_payload(machine_id=req_machine_id)
                yield f"data: {json.dumps(payload)}\n\n"
        finally:
            # klient sie rozlaczyl – usuwamy jego kolejke
            with _sse_lock:
                if client_queue in _sse_clients:
                    _sse_clients.remove(client_queue)

    return Response(stream_with_context(generate()), mimetype="text/event-stream")


# ------------------ RUN ------------------
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    debug = os.environ.get("FLASK_DEBUG", "0") == "1"
    # threaded=True – SSE trzyma polaczenie otwarte, wiec inne zapytania
    # musza byc obslugiwane w osobnych watkach
    app.run(host="0.0.0.0", port=port, debug=debug, use_reloader=False, threaded=True)
