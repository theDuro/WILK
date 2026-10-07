@echo off
REM Uruchamia palety.py (liczniki czesci z PLC, port TCP 4200) – np. z autostartu Windows.
REM Okno musi pozostac otwarte, dopoki skrypt ma dzialac.

set "SCRIPTS_DIR=C:\Users\dawid\Desktop\scripts"

python "%SCRIPTS_DIR%\palety.py"

exit
