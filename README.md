# WILK – monitoring linii paletyzacji (WILK / Niverplast) + most PLC ↔ WMS

System działa na komputerze z Windows podłączonym do sterownika PLC linii. Robi trzy rzeczy:

1. **Dashboard (HMI) w przeglądarce.** Pokazuje schemat maszyny WILK i linii Niverplast, alarmy części, stany materiałów (kartony, taśma, worki) i historię błędów.
2. **Zbiera dane z PLC** przez TCP: alarmy oraz liczniki i stany materiałów, i zapisuje je w PostgreSQL.
3. **Łączy PLC z systemem magazynowym WMS.** Po skompletowaniu palety zakłada zlecenie w WMS i odsyła do PLC numer SSCC, wagę i nazwę produktu do etykiety.

---

## Spis treści

1. [Architektura](#architektura)
2. [Struktura repozytorium](#struktura-repozytorium)
3. [Wymagania](#wymagania)
4. [Uruchomienie produkcyjne (Windows)](#uruchomienie-produkcyjne-windows)
5. [Uruchomienie przez docker compose (test / nowa instalacja)](#uruchomienie-przez-docker-compose)
6. [Uruchomienie backendu bez Dockera](#uruchomienie-backendu-bez-dockera)
7. [Budowanie i publikacja obrazów Docker](#budowanie-i-publikacja-obrazów-docker)
8. [Testowanie](#testowanie)
9. [Konfiguracja (zmienne środowiskowe)](#konfiguracja-zmienne-środowiskowe)
10. [Protokoły komunikacji z PLC](#protokoły-komunikacji-z-plc)
11. [API REST](#api-rest)
12. [Baza danych](#baza-danych)
13. [Logi i rozwiązywanie problemów](#logi-i-rozwiązywanie-problemów)
14. [Znane ograniczenia](#znane-ograniczenia)

---

## Architektura

```
                       Sterownik PLC (192.168.20.3)
          │ TCP 4000            │ TCP 4200            │ TCP 4300 / 4301
          ▼                     ▼                     ▼
     blendy.py             palety.py            WMS_BRIDGE.py ──HTTP──► WMS
     (alarmy)              (liczniki)           (zlecenia, SSCC)        192.168.1.34:8080
          │                     │
          └──────────┬──────────┘   psycopg2
                     ▼
          PostgreSQL :5432            ← kontener "lokalny-postgres"
                     ▲ SQLAlchemy
          API Flask :5000             ← kontener "flask_app"     (katalog backend/)
                     ▲ HTTP (odpytywanie co kilka sekund)
          Frontend React :8080        ← kontener "autosoft_front" (katalog front/)
                     ▲
          Przeglądarka / panel operatora:  http://<adres-komputera>:8080
```

| Port | Usługa | Kto się łączy |
|------|--------|---------------|
| 4000 | `blendy.py`: alarmy z PLC (TCP) | PLC |
| 4100 | `blendy.py`: pomocniczy serwer HTTP (`/state`, `/test`) | ręczny test |
| 4200 | `palety.py`: liczniki i stany części (TCP) | PLC |
| 4300 | `WMS_BRIDGE.py`: INPUT, dane palety (TCP) | PLC |
| 4301 | `WMS_BRIDGE.py`: OUTPUT, odpowiedź z SSCC (TCP) | PLC |
| 4400 | `finish_bridge.py`: INPUT, SSCC do zamknięcia (TCP) | PLC |
| 4401 | `finish_bridge.py`: OUTPUT, odpowiedź OK/NOK (TCP) | PLC |
| 5000 | API Flask | frontend |
| 5432 | PostgreSQL | API i skrypty |
| 8080 | Frontend | przeglądarka |

Frontend łączy się z API pod adresem `http://<ten sam host co strona>:5000`, więc API i frontend muszą działać na tym samym komputerze.

---

## Struktura repozytorium

```
WILK/
├── README.md               ← ten plik
├── docker-compose.yml      ← cały system (baza + API + front) jednym poleceniem
├── requirements.txt        ← zależności skryptów z głównego katalogu
│
├── WMS_BRIDGE.py           ← most PLC ↔ WMS (porty 4300/4301)
├── finish_bridge.py        ← zamknięcie palety w WMS (porty 4400/4401)
├── blendy.py               ← odbiór alarmów z PLC (port 4000) + alarm na ekran
├── palety.py               ← odbiór liczników części z PLC (port 4200)
├── add_to_base.py          ← dane startowe: części 38–42, liczniki, słownik alarmów
├── test.py                 ← symulator PLC do testowania WMS_BRIDGE.py
├── mock_wms.py             ← atrapa serwera WMS do testów (port 8081)
│
├── start_new.bat           ← start całego systemu na Windows
├── doOdpaleniaBlendy.bat   ← start blendy.py (autostart)
├── doOdpaleniaPalety.bat   ← start palety.py (autostart)
│
├── baza_dump.sql           ← zrzut bazy (pg_dumpall, PostgreSQL 15)
├── *.log                   ← archiwalne logi mostu WMS z produkcji
├── gcapi.dll               ← biblioteka Windows (nieużywana przez kod w repo)
│
├── backend/                ← API Flask
│   ├── controller/application.py   ← endpointy HTTP
│   ├── repository/autosoftrep.py   ← zapytania do bazy (SQLAlchemy)
│   ├── model/models.py             ← modele tabel (ORM)
│   ├── dto/                        ← obiekty zwracane przez API
│   ├── servis/                     ← (pusta warstwa serwisowa)
│   ├── requirements.txt
│   ├── dockerfile                  ← obraz theduro/flask-app
│   └── docker-compose.yml          ← sam backend
│
├── front/
│   ├── build/              ← zbudowany frontend React (to jest serwowane)
│   ├── app/build/          ← kopia build/ (identyczna, nieużywana)
│   └── Dockerfile          ← obraz frontu (serve na porcie 8080)
│
└── docker/
    ├── initdb/01-restore-dump.sh   ← import baza_dump.sql przy 1. starcie bazy
    └── *_inspect.json, *_history.txt ← zrzuty konfiguracji kontenerów z produkcji
```

---

## Wymagania

- **Windows 10/11** z **Docker Desktop** (na produkcji). Do testów wystarczy dowolny system z Dockerem.
- **Python 3.11 lub nowszy**, bo `WMS_BRIDGE.py` używa `datetime.UTC`. Przy instalacji na Windows zaznacz „Add python.exe to PATH”.
- Zależności skryptów:
  ```bat
  pip install -r requirements.txt
  ```
  Instaluje `psycopg2-binary` i `requests`.
- Dostęp sieciowy:
  - do PLC: PLC musi móc łączyć się na porty 4000, 4200, 4300 i 4301 tego komputera. **Odblokuj je w Zaporze Windows**,
  - do WMS: `http://192.168.1.34:8080`.

Odblokowanie portów w zaporze (PowerShell uruchomiony jako administrator):

```powershell
New-NetFirewallRule -DisplayName "WILK PLC" -Direction Inbound -Protocol TCP -LocalPort 4000,4200,4300,4301 -Action Allow
New-NetFirewallRule -DisplayName "WILK HMI" -Direction Inbound -Protocol TCP -LocalPort 5000,8080 -Action Allow
```

---

## Uruchomienie produkcyjne (Windows)

Tak system działa na komputerze przy linii.

1. Zainstaluj Docker Desktop i Pythona (patrz [Wymagania](#wymagania)).
2. Skopiuj skrypty Pythona z głównego katalogu repo (`*.py` i `requirements.txt`) do katalogu, np. `C:\Users\dawid\Desktop\scripts`, i zainstaluj zależności:
   ```bat
   cd C:\Users\dawid\Desktop\scripts
   pip install -r requirements.txt
   ```
3. Jeśli skrypty leżą w innym katalogu, zmień linię `set "SCRIPTS_DIR=..."` na początku plików `start_new.bat`, `doOdpaleniaBlendy.bat` i `doOdpaleniaPalety.bat`.
4. Uruchom **`start_new.bat`**. Skrypt:
   - pobiera i uruchamia bazę `theduro/lokalny-postgres:v2` (port 5432, dane w wolumenie `wilk_pgdata`),
   - uruchamia API `theduro/flask-app:latest` (port 5000). Obraz musi być dostępny lokalnie, patrz [Budowanie](#budowanie-i-publikacja-obrazów-docker),
   - pobiera i uruchamia frontend `theduro/new-front-21.04:latest` (port 8080),
   - wykonuje `add_to_base.py` (dane startowe),
   - uruchamia `WMS_BRIDGE.py`. **Okno musi zostać otwarte**, bo zamknięcie zatrzymuje most do WMS.
5. Uruchom `doOdpaleniaBlendy.bat` i `doOdpaleniaPalety.bat`. Najlepiej dodać je do autostartu: `Win+R`, wpisz `shell:startup` i wklej tam skróty do obu plików.
6. Otwórz dashboard: **http://localhost:8080**, a z innego komputera lub panelu: `http://<IP-komputera>:8080`.

> **Uwaga o danych bazy.** Od tej wersji `start_new.bat` trzyma dane Postgresa w nazwanym wolumenie `wilk_pgdata`. Historia alarmów i liczniki przetrwają ponowne uruchomienie skryptu. Wcześniej każde uruchomienie zaczynało od pustej bazy z obrazu. Pełny reset bazy:
> ```bat
> docker rm -f lokalny-postgres
> docker volume rm wilk_pgdata
> ```

Kontenery mają ustawiony restart automatyczny, więc po restarcie komputera uruchomią się same, gdy wystartuje Docker Desktop. Skrypty Pythona trzeba uruchomić ponownie (autostart z punktu 5 albo `start_new.bat`).

---

## Uruchomienie przez docker compose

Najprostszy sposób na postawienie całości od zera, np. na nowym komputerze albo do testów. Obrazy budują się z kodu w repo, a baza przy pierwszym starcie importuje `baza_dump.sql`.

```bash
docker compose up -d --build     # start
docker compose ps                # status
docker compose logs -f backend   # logi API
docker compose down              # stop (dane bazy zostają w wolumenie)
docker compose down -v           # stop + usunięcie danych bazy (następny start znów zaimportuje zrzut)
```

Po starcie:
- frontend: http://localhost:8080
- API: http://localhost:5000/ping, które odpowiada `{"message":"pong"}`
- baza: `localhost:5432`, użytkownik `postgres`, hasło `Test1234!`

Kontenery mają te same nazwy co w `start_new.bat`. **Nie uruchamiaj obu wariantów naraz**, bo konflikt nazw i portów to uniemożliwi.

Skrypty komunikacji z PLC uruchamia się na komputerze, poza Dockerem:

```bat
pip install -r requirements.txt
python add_to_base.py
python blendy.py
python palety.py
python WMS_BRIDGE.py
```

Każdy z tych trzech serwerów uruchom w osobnym oknie.

---

## Uruchomienie backendu bez Dockera

Przydatne przy programowaniu API.

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate            # Linux/Mac: source .venv/bin/activate
pip install -r requirements.txt

# baza dziala lokalnie na porcie 5432 (np. "docker compose up -d db")
set DATABASE_URL=postgresql+psycopg2://postgres:Test1234!@localhost:5432/postgres
#   Linux/Mac: export DATABASE_URL=...
python -m controller.application
```

Polecenie trzeba uruchomić **z katalogu `backend/`** jako moduł (`-m`), żeby działały importy `repository`, `model` i `dto`.

Na Linuksie zamiast `psycopg2` łatwiej zainstalować `psycopg2-binary` (ta sama wersja), bo nie wymaga kompilatora ani `libpq-dev`.

---

## Budowanie i publikacja obrazów Docker

```bash
# API
docker build -t theduro/flask-app:latest backend
docker push theduro/flask-app:latest          # opcjonalnie

# Frontend (serwuje gotowy katalog front/build)
docker build -t theduro/new-front-21.04:latest front
docker push theduro/new-front-21.04:latest
```

`start_new.bat` **nie pobiera** obrazu API z Docker Hub. Używa wersji lokalnej, więc po zmianach w `backend/` zbuduj go ponownie poleceniem wyżej i uruchom `start_new.bat`.

---

## Testowanie

### Most WMS bez prawdziwego WMS

```bat
REM okno 1 – atrapa WMS na porcie 8081
python mock_wms.py

REM okno 2 – bridge skierowany na atrape: w KOPII pliku WMS_BRIDGE.py zmien
REM WMS_BASE na "http://127.0.0.1:8081/WilkRestServer/Wilk" (w finish_bridge.py:
REM WMS_URL na ".../Wilk/SprFinishApl") i uruchom kopie
python WMS_BRIDGE.py

REM okno 3 – symulator PLC (6 scenariuszy: 1–3 partie, pusta lista, zly JSON, padding)
REM (finish_bridge.py testuje sie tak samo – atrapa obsluguje tez /SprFinishApl)
python test.py
```

> **Uwaga:** `test.py` uruchomiony przeciwko **prawdziwemu** WMS zakłada w nim prawdziwe zlecenia.

### Liczniki (`palety.py`) i alarmy (`blendy.py`)

Ręczne wysłanie danych tak, jak robi to PLC:

```bat
python -c "import socket;s=socket.create_connection(('127.0.0.1',4200));s.sendall(b'{\"part_id\":21,\"counter\":-1,\"is_empty\":false}');print(s.recv(100))"
python -c "import socket;s=socket.create_connection(('127.0.0.1',4000));s.sendall(b'{\"alarms\":[305,312]}');print(s.recv(100))"
```

Po chwili kafelek części 21 na dashboardzie powinien pokazać „MAŁO”, a na liście alarmów pojawią się A305 i A312.

Test komunikatu alarmu 440: otwórz w przeglądarce http://localhost:4100/test.

### API

```bash
curl http://localhost:5000/ping
curl "http://localhost:5000/api/get_prts_counters?machine_id=1"
curl "http://localhost:5000/api/get_last_errors/1"
```

---

## Konfiguracja (zmienne środowiskowe)

Każda zmienna ma wartość domyślną równą dotychczasowej konfiguracji, więc bez ustawiania czegokolwiek wszystko działa jak wcześniej.

**Backend (API Flask)**

| Zmienna | Domyślnie | Opis |
|---------|-----------|------|
| `DATABASE_URL` | `postgresql+psycopg2://postgres:Test1234!@host.docker.internal:5432/postgres` | adres bazy |
| `PORT` | `5000` | port API |
| `JWT_SECRET_KEY` | `tajny_klucz` | klucz podpisu tokenów `/api/login` |
| `FLASK_DEBUG` | `0` | `1` włącza tryb debug (nie używać na produkcji) |

**Skrypty `blendy.py`, `palety.py`, `add_to_base.py`**

| Zmienna | Domyślnie | Opis |
|---------|-----------|------|
| `DB_HOST` / `DB_PORT` | `localhost` / `5432` | adres bazy |
| `DB_NAME` / `DB_USER` / `DB_PASSWORD` | `postgres` / `postgres` / `Test1234!` | dane logowania |
| `BLEDY_PORT` | `4000` | port alarmów (`blendy.py`) |
| `ALARM_HTTP_PORT` | `4100` | port testowy HTTP (`blendy.py`) |
| `FRONT_CONTAINER` | `autosoft_front` | kontener, do którego trafia `alarm.json` |
| `PALETY_PORT` | `4200` | port liczników (`palety.py`) |

**`WMS_BRIDGE.py` i `finish_bridge.py`** nie używają zmiennych środowiskowych. Adres WMS, porty i dane firmy (`MAGH`) są stałymi na początku każdego pliku.

Ustawienie zmiennej na Windows przed uruchomieniem skryptu: `set NAZWA=wartosc` w tym samym oknie. Na stałe: `setx NAZWA wartosc`, a potem trzeba otworzyć nowe okno.

---

## Protokoły komunikacji z PLC

Wszystkie wiadomości to JSON w UTF-8. Skrypty doczytują dane do końca JSON-a, więc długie wiadomości mogą przyjść w kilku pakietach, a padding (spacje, `\x00`) po JSON-ie jest ignorowany. PLC nie musi zamykać połączenia po wysłaniu danych.

### Alarmy: port 4000 (`blendy.py`)

```json
{"alarms": [305, 312]}
```

Liczby to ID z tabeli `machine_part_errors`, czyli słownika alarmów w `add_to_base.py`. Odpowiedź tekstowa: `OK` albo `Blad danych` / `Blad serwera`. Jeśli w danych pojawi się liczba 440, skrypt zapisuje stan alarmu do pliku `alarm.json` we froncie.

### Liczniki: port 4200 (`palety.py`)

```json
{"part_id": 21, "counter": 5, "is_empty": false}
```

albo lista takich obiektów. Dashboard pokazuje: `is_empty: true` jako **BRAK**, `counter: -1` jako **MAŁO**, pozostałe wartości jako **OK**. Odpowiedź tekstowa, np. `OK - zaktualizowano 2/2 rekordów`.

### Paleta, czyli WMS: porty 4300 i 4301 (`WMS_BRIDGE.py`)

1. PLC łączy się na **4301 (OUTPUT)** i czeka.
2. PLC wysyła na **4300 (INPUT)** listę pozycji:
   ```json
   [{"POSITION_NR": "0", "PRODUCT_NR": "0100000039", "PROD_SERIAL_NR": "Partia", "BU_QUANTITY": "2"}]
   ```
3. Bridge zakłada zlecenie w WMS (`POST /Spr`) i pobiera dane etykiety (`POST /SprLabelPrint`).
4. Na połączenie OUTPUT wraca odpowiedź, po czym bridge je zamyka:
   ```json
   {"status": "OK", "sscc": "020012340000738354", "picking_date": "2026-05-06",
    "gross_weight_kg": 25.0054, "product_name": "..."}
   ```
   albo przy błędzie WMS:
   ```json
   {"status": "ERR", "error": "ACTIVATE_ORDER_ERROR", "message": "..."}
   ```
   Przy niepoprawnym JSON-ie z PLC bridge tylko loguje błąd i nic nie odsyła.

### Zamknięcie palety: porty 4400 i 4401 (`finish_bridge.py`)

1. PLC łączy się na **4401 (OUTPUT)** i czeka.
2. PLC wysyła na **4400 (INPUT)** SSCC palety: `{"sscc": "020012340000738569"}`.
3. Bridge wysyła `POST /SprFinishApl` do WMS.
4. Na OUTPUT wraca tekst `OK` albo `NOK`. Puste body z WMS jest traktowane jako `OK`.

### Poprawka „WinError 10054” (oba bridge)

Odpowiedź dostaje zawsze **najnowsze** połączenie OUTPUT od PLC. Bridge zamyka połączenie, które PLC zamknął albo zastąpił nowym, zamiast trzymać je i wysłać na nie odpowiedź. Wcześniej takie porzucone połączenie potrafiło „zjeść” wynik. PLC go nie odbierał, a w logu pojawiał się `WinError 10054`, mimo że zlecenie w WMS było już założone. Poza tym działanie obu bridge'ów jest takie jak w wersji z produkcji.

---

## API REST

Wszystkie odpowiedzi to JSON. Daty w polach `occurred_at` / `created_at` mają format Flaska (`Mon, 05 Oct 2026 05:23:02 GMT`, czas UTC). Parametr `date_from` przyjmuje ISO 8601, np. `2026-10-05T08:00:00.000Z`.

| Metoda | Ścieżka | Opis |
|--------|---------|------|
| GET | `/ping`, `/test` | test działania |
| GET | `/api/get_machine_parts_by_machine_id/<machine_id>` | części maszyny (pozycje x/y na schemacie) |
| GET | `/api/get_prts_counters?machine_id=` | liczniki i stany części |
| GET | `/api/get_error_str?part_id=&date_from=` | unikalne kody alarmów części od daty |
| GET | `/api/get_error_for_parts?part_id=&date_from=` | wystąpienia alarmów części od daty |
| GET | `/api/get_error_ids?part_id=&date_from=` | ID alarmów części od daty |
| GET | `/api/get_error_for_machine?machine_id=&date_from=` | wystąpienia alarmów całej maszyny od daty |
| GET | `/api/get_last_errors/<machine_id>` | maks. 4 ostatnie alarmy (unikalne kody) |
| GET | `/api/get_part_errors/<part_id>` | słownik alarmów części |
| GET | `/api/get_occurrences_by_machine_id/<machine_id>` | wszystkie wystąpienia alarmów maszyny |
| GET | `/api/get_all_occurrences` | wszystkie wystąpienia alarmów |
| GET | `/api/get_conf_by_machine_id/<machine_id>` | konfiguracja maszyny (JSON) |
| POST | `/api/update_conf_by_machine_id/<machine_id>` | zapis konfiguracji, body `{"new_config": {...}}` |
| POST | `/api/update_machine_part_stat` | zapis liczników, body jak na porcie 4200 |
| POST | `/api/add_occurrences` | zapis alarmów, body `{"alarms": [305]}` |
| POST | `/api/login` | `{"username","password"}` zwraca `{"access_token"}` |
| GET | `/api/stream?machine_id=` | strumień SSE ze stanem maszyny (co 5 s lub po zmianie) |
| GET | `/api/get_machines_by_company_id/<id>`, `/api/get_machine_data_by_*`, `/api/get_errors_by_*` | starsze endpointy (tabele `machines`, `machine_data`, `errors`) |

---

## Baza danych

PostgreSQL 15, baza `postgres`, schemat `public`.

| Tabela | Zawartość |
|--------|-----------|
| `companies` | firmy (login i hasło do `/api/login`) |
| `machines` | maszyny; `config` to JSON z ustawieniami tagów |
| `machine_parts` | części maszyny i ich pozycje na schemacie (x, y w %) |
| `machine_part_errors` | **słownik alarmów**: ID z PLC zamienione na część, kod (`A305`) i opis |
| `machine_part_error_occurrences` | historia wystąpień alarmów |
| `machine_part_stats` | liczniki i stany materiałów przy częściach |
| `machine_data`, `errors` | starsze tabele, obecnie nieużywane przez front |

Tabele tworzy backend przy starcie (`create_all`), jeśli ich nie ma. Nowy alarm dodaje się, dopisując wiersz w `ERRORS_QUERY` w `add_to_base.py` (ID musi być równe numerowi alarmu z PLC) i uruchamiając skrypt.

Kopia zapasowa i odtworzenie:

```bat
docker exec lokalny-postgres pg_dumpall -U postgres > baza_dump.sql
```

Odtworzenie na nowej instalacji robi `docker compose` (patrz wyżej), które importuje plik `baza_dump.sql` przy pierwszym starcie.

---

## Logi i rozwiązywanie problemów

- `WMS_BRIDGE.py` pisze do `wms_bridge_simple.log`, a `finish_bridge.py` do `finish_bridge.log`. Oba pliki powstają w katalogu, z którego uruchomiono skrypt, a logi trafiają też na konsolę.
- `blendy.py` i `palety.py` piszą tylko na konsolę.
- API: `docker logs -f flask_app`. Baza: `docker logs -f lokalny-postgres`.

| Objaw | Co sprawdzić |
|-------|--------------|
| Dashboard pusty / „Failed to fetch” | czy działa API: http://localhost:5000/ping; czy port 5000 jest otwarty w zaporze |
| API nie startuje, błąd połączenia z bazą | czy działa kontener `lokalny-postgres`; czy `DATABASE_URL` wskazuje dobry host (w Docker Desktop `host.docker.internal`, w compose `db`) |
| PLC nie może się połączyć | zapora Windows (porty 4000/4200/4300/4301); czy skrypt działa (okno otwarte) |
| `OSError: [WinError 10048]` przy starcie skryptu | skrypt już działa w innym oknie (port zajęty) |
| Most zwraca `WMS_ERROR` | dostęp do `http://192.168.1.34:8080` z tego komputera |
| `[FRONT] blad docker cp` w `blendy.py` | nie działa kontener `autosoft_front` (nie blokuje zapisu alarmów do bazy) |
| `docker compose up` kończy się błędem portu | działają kontenery ze `start_new.bat`; zatrzymaj je: `docker rm -f lokalny-postgres flask_app autosoft_front` |

---

## Znane ograniczenia

- **Brak źródeł frontendu.** W repo jest tylko zbudowany React (`front/build`). Kod źródłowy komponentów da się odczytać z `front/build/static/js/main.*.js.map` (pole `sourcesContent`). Żeby zmienić front, trzeba odtworzyć projekt (np. Create React App) z tych źródeł i zbudować go ponownie.
- `front/app/build` jest identyczną kopią `front/build` i nie jest używany.
- Bezpieczeństwo jest na poziomie sieci wewnętrznej zakładu: hasła mają wartości domyślne w kodzie (można je nadpisać zmiennymi środowiskowymi), endpointy zapisu nie wymagają logowania, a hasła firm są w bazie jawnym tekstem. **Nie wystawiaj portów 5000, 4000–4301 ani 5432 do internetu.**
- Alarm o ID 307 ma w słowniku kod `A376`. To prawdopodobnie literówka (powinno być `A307`), ale zostawiono ją bez zmian (patrz `add_to_base.py`).
- Workflowy GitHub Actions w `backend/.github/workflows` (deploy na Azure) nie są uruchamiane, bo GitHub czyta workflowy tylko z `.github/` w głównym katalogu repo.
