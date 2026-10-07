@echo off
REM Uruchamia blendy.py (alarmy z PLC, port TCP 4000) – np. z autostartu Windows.
REM Okno musi pozostac otwarte, dopoki skrypt ma dzialac.

set "SCRIPTS_DIR=C:\Users\dawid\Desktop\scripts"

python "%SCRIPTS_DIR%\blendy.py"

exit
