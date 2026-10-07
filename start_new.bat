
@echo off

REM ===========================
REM   POSTGRES
REM ===========================
echo Usuwanie starego kontenera PostgreSQL...
docker rm -f lokalny-postgres 2>nul

echo Pobieranie obrazu PostgreSQL...
docker pull theduro/lokalny-postgres:v2

echo Uruchamianie PostgreSQL...
docker run -d --name lokalny-postgres ^
  -e POSTGRES_USER=postgres ^
  -e POSTGRES_PASSWORD=Test1234! ^
  -e POSTGRES_DB=postgres ^
  -p 5432:5432 ^
  --restart always ^
  theduro/lokalny-postgres:v2

echo Odczekaj 5 sekund...
timeout /t 5 > nul


REM ===========================
REM   FLASK APP
REM ===========================
echo Usuwanie starego kontenera Flask...
docker rm -f flask_app 2>nul

echo Uruchamianie Flask API na porcie 5000...
docker run -d --name flask_app -p 5000:5000 theduro/flask-app:latest

echo Flask działa na http://localhost:5000

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
docker run -d --name autosoft_front -p 8080:8080 theduro/new-front-21.04:latest
echo Frontend działa na http://localhost:8080

REM ===========================
REM   PYTHON SCRIPT
REM ===========================
echo Uruchamianie skryptu Python add_to_base.py...
python "C:\Users\dawid\Desktop\scripts\add_to_base.py"
python "C:\Users\dawid\Desktop\scripts\WMS_BRIDGE.py"


pause
