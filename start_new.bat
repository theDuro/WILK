@echo off
REM ===========================================================================
REM  START CALEGO SYSTEMU WILK (Windows, Docker Desktop)
REM
REM  1. PostgreSQL  -> port 5432  (kontener lokalny-postgres)
REM  2. API Flask   -> port 5000  (kontener flask_app)
REM  3. Frontend    -> port 8080  (kontener autosoft_front)
REM  4. add_to_base.py  – dane startowe / slownik alarmow
REM  5. WMS_BRIDGE.py   – most PLC <-> WMS (dziala do zamkniecia okna)
REM
REM  blendy.py i palety.py startuja osobno (doOdpaleniaBlendy.bat,
REM  doOdpaleniaPalety.bat – np. z autostartu Windows).
REM ===========================================================================

REM polskie znaki w konsoli
chcp 65001 > nul

REM Katalog ze skryptami Pythona – zmien, jesli skrypty leza gdzie indziej
set "SCRIPTS_DIR=C:\Users\dawid\Desktop\scripts"

REM ===========================
REM   POSTGRES
REM ===========================
echo Usuwanie starego kontenera PostgreSQL...
docker rm -f lokalny-postgres 2>nul

echo Pobieranie obrazu PostgreSQL...
docker pull theduro/lokalny-postgres:v2

echo Uruchamianie PostgreSQL...
REM Dane bazy sa w NAZWANYM wolumenie wilk_pgdata, wiec przetrwaja
REM "docker rm -f" powyzej i restart komputera. (Wczesniej byl tu wolumen
REM anonimowy – kazde uruchomienie tego pliku zaczynalo z pusta historia.)
REM Reset bazy do stanu z obrazu:  docker rm -f lokalny-postgres
REM                                docker volume rm wilk_pgdata
docker run -d --name lokalny-postgres ^
  -v wilk_pgdata:/var/lib/postgresql/data ^
  -e POSTGRES_USER=postgres ^
  -e POSTGRES_PASSWORD=Test1234! ^
  -e POSTGRES_DB=postgres ^
  -p 5432:5432 ^
  --restart always ^
  theduro/lokalny-postgres:v2

echo Odczekaj 5 sekund...
timeout /t 5 /nobreak > nul


REM ===========================
REM   FLASK APP
REM ===========================
echo Usuwanie starego kontenera Flask...
docker rm -f flask_app 2>nul

REM Obraz z lokalnego dockera (zbudowany: docker build -t theduro/flask-app:latest backend)
echo Uruchamianie Flask API na porcie 5000...
docker run -d --name flask_app -p 5000:5000 --restart unless-stopped theduro/flask-app:latest

echo Flask dziala na http://localhost:5000

echo Odczekaj 10 sekund...
timeout /t 10 /nobreak > nul


REM ===========================
REM   FRONTEND
REM ===========================
echo Usuwanie starego kontenera FRONTEND...
docker rm -f autosoft_front 2>nul
echo Pobieranie najnowszego obrazu FRONTEND...
docker pull theduro/new-front-21.04:latest
echo Uruchamianie FRONTENDU na porcie 8080...
docker run -d --name autosoft_front -p 8080:8080 --restart unless-stopped theduro/new-front-21.04:latest
echo Frontend dziala na http://localhost:8080

REM ===========================
REM   PYTHON SCRIPTS
REM ===========================
echo Uruchamianie skryptu Python add_to_base.py...
python "%SCRIPTS_DIR%\add_to_base.py"

echo Uruchamianie WMS_BRIDGE.py (nie zamykaj tego okna)...
python "%SCRIPTS_DIR%\WMS_BRIDGE.py"


pause
