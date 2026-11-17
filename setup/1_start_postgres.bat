@echo off
rem 1_start_postgres.bat: starts PostgreSQL from the kit, with no installation and no service.
rem First run: creates the database folder and the database thara, then loads Day 1's
rem registration system. Every later run only starts the server and checks the same steps.
setlocal
call "%~dp0env.bat"
title DWBI PostgreSQL
set "OUT=%TEMP%\dwbi_pg.txt"

if not exist "%PGBIN%\pg_ctl.exe" (
    echo FAIL  PostgreSQL not found in tools\pgsql.
    echo       Copy the tools folder from the lab USB, or follow the Build your own tools folder page.
    echo       Then run 0_check_setup.
    goto :end
)

rem ---- First run: create the database folder ----------------------------------------
if exist "%PGDATA%\PG_VERSION" goto :start
echo Creating the database folder. This happens once.
if not exist "%DATA%" mkdir "%DATA%"
rem UTF8 with the C locale sorts and reports errors the way the lab sheets show them.
"%PGBIN%\initdb.exe" -D "%PGDATA%" -U postgres -A trust -E UTF8 --locale=C > "%DATA%\initdb.log" 2>&1
if errorlevel 1 (
    echo FAIL  The database folder could not be created. The details are in:
    echo       "%DATA%\initdb.log"
    goto :end
)
echo PASS  Database folder created.

rem ---- Start the server ---------------------------------------------------------------
:start
"%PGBIN%\pg_ctl.exe" status -D "%PGDATA%" >nul 2>&1
if not errorlevel 1 (
    echo PASS  PostgreSQL is already running on port %PGPORT%.
    goto :database
)
rem A lock file left by a server that is no longer running would stop the start.
if exist "%PGDATA%\postmaster.pid" del "%PGDATA%\postmaster.pid"
rem listen_addresses=localhost: only this computer can connect, so Windows asks no firewall question.
"%PGBIN%\pg_ctl.exe" start -D "%PGDATA%" -l "%PGLOG%" -w -o "-p %PGPORT% -c listen_addresses=localhost"
if errorlevel 1 (
    echo FAIL  PostgreSQL did not start. Run 0_check_setup: it shows whether the port is in use.
    echo       The server's own messages are in:
    echo       "%PGLOG%"
    goto :end
)
echo PASS  PostgreSQL is running on port %PGPORT%.

rem ---- The database thara and Day 1's registration system -----------------------------
:database
"%PGBIN%\psql.exe" -X -tA -d postgres -c "SELECT count(*) FROM pg_database WHERE datname = 'thara'" -o "%OUT%"
set "N="
set /p N=<"%OUT%"
if not "%N%"=="1" (
    "%PGBIN%\createdb.exe" thara
    if errorlevel 1 (
        echo FAIL  The database thara could not be created.
        goto :end
    )
    echo PASS  Database thara created.
)
"%PGBIN%\psql.exe" -X -tA -d thara -c "SELECT count(*) FROM pg_namespace WHERE nspname = 'registration'" -o "%OUT%"
set "N="
set /p N=<"%OUT%"
if "%N%"=="1" (
    echo PASS  Database thara holds the registration system.
    goto :ready
)
if not exist "%D1SQL%" (
    echo Day 1's file is not in the kit yet. When Day 1 is posted, copy in the module
    echo files and run this launcher again. It loads the file then.
    goto :ready
)
echo Loading Day 1's registration system into thara.
"%PGBIN%\psql.exe" -X -q -v ON_ERROR_STOP=1 -d thara -f "%D1SQL%"
if errorlevel 1 (
    echo FAIL  Day 1's file did not load. Run 0_check_setup to check the file.
    goto :end
)
echo PASS  Day 1's registration system is loaded: schema registration, and an empty schema warehouse.

:ready
echo.
echo Keep this window open while you work. Run stop_all when you finish.
echo Connect with: host localhost, port %PGPORT%, database thara, user postgres, no password.

:end
if exist "%OUT%" del "%OUT%"
echo.
pause
endlocal
