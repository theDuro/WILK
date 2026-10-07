#!/bin/bash
# -----------------------------------------------------------------------------
# Import zrzutu bazy (baza_dump.sql) przy PIERWSZYM starcie kontenera Postgresa.
#
# Obraz postgres uruchamia skrypty z /docker-entrypoint-initdb.d/ tylko wtedy,
# gdy katalog danych jest pusty (nowy wolumen). Kolejne starty nic nie importuja.
#
# Zrzut pochodzi z pg_dumpall, wiec zawiera tez CREATE/ALTER ROLE postgres.
# Te linie pomijamy: rola juz istnieje, a jej haslo ustawia POSTGRES_PASSWORD.
# -----------------------------------------------------------------------------
set -euo pipefail

DUMP=/baza_dump.sql

if [ ! -f "$DUMP" ]; then
    echo "Brak $DUMP – pomijam import (baza bedzie pusta, tabele utworzy backend)."
    exit 0
fi

echo "Import $DUMP ..."
sed -e '/^CREATE ROLE postgres;$/d' -e '/^ALTER ROLE postgres /d' "$DUMP" \
    | psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname postgres --quiet
echo "Import zakonczony."
