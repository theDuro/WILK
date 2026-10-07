"""
=============================================================================
ADD_TO_BASE – dane startowe / konfiguracja linii Niverplast w bazie
=============================================================================

Skrypt mozna uruchamiac wielokrotnie (jest idempotentny):
  * machine_parts       – czesci 38–42 (insert lub nadpisanie pozycji),
  * machine_part_stats  – liczniki (dodawane tylko, jesli nie istnieja),
  * machine_part_errors – slownik alarmow (insert lub nadpisanie opisu).

Wymaga istniejacych tabel (tworzy je backend przy starcie albo import
baza_dump.sql) oraz maszyny o id = 1.

ID w machine_part_errors MUSZA odpowiadac numerom alarmow wysylanym przez PLC
na port 4000 (blendy.py).

Konfiguracja bazy: zmienne srodowiskowe DB_HOST, DB_PORT, DB_NAME, DB_USER,
DB_PASSWORD (domyslnie lokalny Postgres z start_new.bat).
=============================================================================
"""

import os
import traceback

import psycopg2

DB_CONFIG = {
    "dbname":   os.environ.get("DB_NAME", "postgres"),
    "user":     os.environ.get("DB_USER", "postgres"),
    "password": os.environ.get("DB_PASSWORD", "Test1234!"),
    "host":     os.environ.get("DB_HOST", "localhost"),
    "port":     int(os.environ.get("DB_PORT", 5432)),
    "sslmode":  "disable",
}

# ===== CZESCI (id, machine_id, nazwa, x[%], y[%], aktywna) =====
PARTS_QUERY = """
INSERT INTO public.machine_parts (id, machine_id, name, x, y, its_working)
VALUES
    (41, 1, 'Part 41', 60, 60, true),
    (42, 1, 'Part 42', 80, 40, true),
    (38, 1, 'Part 38', 70, 40, true),
    (40, 1, 'Part 40', 50, 45, true)
ON CONFLICT (id)
DO UPDATE SET
    machine_id  = EXCLUDED.machine_id,
    name        = EXCLUDED.name,
    x           = EXCLUDED.x,
    y           = EXCLUDED.y,
    its_working = EXCLUDED.its_working;
"""

# ===== LICZNIKI (id, nazwa, licznik, pusty, part_id) – tylko gdy nie istnieja =====
STATS_QUERY = """
INSERT INTO public.machine_part_stats (id, name, counter, is_empty, part_id)
SELECT id, name, counter, is_empty, part_id
FROM (VALUES
    (9,  'kartony do kartoniarki', 0, false, 21),
    (10, 'kartony do kartoniarki', 0, false, 22),
    (11, 'kartony do kartoniarki', 0, false, 23),
    (12, 'kartony do kartoniarki', 0, false, 29),
    (13, '', 0, false, 39),
    (14, '', 0, false, 30),
    (15, '', 0, false, 31),
    (16, '', 0, false, 32),
    (17, '', 0, false, 33),
    (18, '', 0, false, 34),
    (19, '', 0, false, 35),
    (20, '', 0, false, 36),
    (21, '', 0, false, 37)
) AS v(id, name, counter, is_empty, part_id)
WHERE NOT EXISTS (
    SELECT 1 FROM public.machine_part_stats m
    WHERE m.id = v.id
);
"""

# ===== SLOWNIK ALARMOW (id = numer alarmu z PLC, part_id, kod, opis) =====
# Uwaga: alarm 307 ma kod 'A376' – tak bylo w oryginale; jesli to literowka,
# zmien na 'A307' (kod wyswietla sie na ekranie).
ERRORS_QUERY = """
INSERT INTO public.machine_part_errors (id, part_id, error_code, description)
VALUES
    (305, 40, 'A305', 'Błąd Lini Niverplast Case Erector'),
    (306, 42, 'A306', 'Alarm Lini Niverplst - Crappe Tiper'),
    (307, 42, 'A376', 'Błąd Lini Niverplast - Crappe Tiper'),
    (308, 39, 'A308', 'Alarm Lini Niverplst - Easy Plast'),
    (309, 39, 'A309', 'Błąd Lini Niverplst - Easy Plast'),
    (310, 41, 'A310', 'Alarm Lini Niverplast - Transport System'),
    (311, 41, 'A311', 'Błąd Lini Niverplst - Transport System'),
    (312, 40, 'A312', 'Niski stan kartonów - uzupełnij'),
    (313, 40, 'A313', 'Pusty stan kartonów – uzupełnij !!!'),
    (314, 40, 'A314', 'Niski stan taśmy kartoniarki'),
    (315, 39, 'A315', 'Jedna strona magazynu worków pusta'),
    (316, 39, 'A316', 'Pusty magazyn worków Niverplast'),
    (187, 40, 'A187', 'Otwarta Bramka Bezpieczeństwa '),
    (188, 40, 'A188', 'Nieryglowany zamek bramki bezpieszeństwa'),
    (317, 40, 'A317', 'Alarm lini Niverplast'),
    (318, 40, 'A318', 'Błąd lini Niverplast'),
    (106, 2,  'A106', 'Błąd pudełko zostało odrzucone'),
    (225, 8,  'A225', 'Otwarta Bramka Bezpieczeństwa'),
    (226, 9,  'A226', 'Niezaryglowany zamek bramki bezpieczenstwa '),
    (261, 40, 'A261', 'Błąd napendu - przenośnik buforowy wyjazd gotowej palety'),
    (262, 40, 'A262', 'Błąd napendu - przenośnik paletyzacji kartonów')
ON CONFLICT (id)
DO UPDATE SET
    part_id     = EXCLUDED.part_id,
    error_code  = EXCLUDED.error_code,
    description = EXCLUDED.description;
"""

# Po wstawieniu rekordow z recznie podanym id trzeba przesunac sekwencje
# autoinkrementacji – inaczej nastepny INSERT bez id dostalby zajete id
# i skonczyl sie bledem "duplicate key".
SYNC_SEQUENCES = [
    """SELECT setval(pg_get_serial_sequence('public.{t}', 'id'),
                     GREATEST((SELECT COALESCE(MAX(id), 0) FROM public.{t}), 1))""".format(t=t)
    for t in ("machine_parts", "machine_part_stats", "machine_part_errors")
]


def insert_machine_part_stats():
    """Dodaje / aktualizuje dane w bazie (wszystko w jednej transakcji)."""
    conn = None
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        with conn:                      # commit na koniec, rollback przy bledzie
            with conn.cursor() as cur:
                cur.execute(PARTS_QUERY)
                cur.execute(STATS_QUERY)
                cur.execute(ERRORS_QUERY)
                for q in SYNC_SEQUENCES:
                    cur.execute(q)
        print("✅ Dane zapisane: czesci, liczniki i slownik alarmow zaktualizowane.")

    except Exception as e:
        print("❌ Błąd zapisu do bazy:", e)
        traceback.print_exc()

    finally:
        if conn:
            conn.close()


if __name__ == "__main__":
    insert_machine_part_stats()
