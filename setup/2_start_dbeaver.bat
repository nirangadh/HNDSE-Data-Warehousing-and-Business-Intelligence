@echo off
rem 2_start_dbeaver.bat: starts DBeaver with its workspace inside the kit, and a connection
rem called "thara (DWBI kit)" that uses the same settings as psql and Metabase.
setlocal
call "%~dp0env.bat"
title DWBI DBeaver

if not exist "%DBEAVER%\dbeaver.exe" (
    echo FAIL  DBeaver not found in tools\dbeaver.
    echo       Copy the tools folder from the lab USB, or follow the Build your own tools folder page.
    echo       Then run 0_check_setup.
    goto :end
)

rem The connection file is written again on every start, from env.bat, so it always
rem matches the port PostgreSQL uses. DBeaver keeps your own connections in other files.
set "DSDIR=%DBEAVER_WS%\General\.dbeaver"
if not exist "%DSDIR%" mkdir "%DSDIR%"
set "DS=%DSDIR%\data-sources-thara.json"
> "%DS%" echo {
>> "%DS%" echo   "folders": {},
>> "%DS%" echo   "connections": {
>> "%DS%" echo     "postgres-jdbc-dwbi-thara": {
>> "%DS%" echo       "provider": "postgresql",
>> "%DS%" echo       "driver": "postgres-jdbc",
>> "%DS%" echo       "name": "thara (DWBI kit)",
>> "%DS%" echo       "save-password": true,
>> "%DS%" echo       "configuration": {
>> "%DS%" echo         "host": "%PGHOST%",
>> "%DS%" echo         "port": "%PGPORT%",
>> "%DS%" echo         "database": "%PGDATABASE%",
>> "%DS%" echo         "user": "%PGUSER%",
>> "%DS%" echo         "url": "jdbc:postgresql://%PGHOST%:%PGPORT%/%PGDATABASE%",
>> "%DS%" echo         "type": "dev",
>> "%DS%" echo         "auth-model": "native"
>> "%DS%" echo       }
>> "%DS%" echo     }
>> "%DS%" echo   }
>> "%DS%" echo }

"%PGBIN%\pg_ctl.exe" status -D "%PGDATA%" >nul 2>&1
if errorlevel 1 echo Note: PostgreSQL is not running yet. Run 1_start_postgres before you connect.

echo Starting DBeaver. Open the connection "thara (DWBI kit)" in the Database Navigator.
echo User postgres, no password. If DBeaver asks to download a driver and cannot, use the
echo driver file in tools\jdbc: the getting-started page shows how.
start "" "%DBEAVER%\dbeaver.exe" -data "%DBEAVER_WS%"
echo You can close this window. DBeaver keeps running.

:end
echo.
pause
endlocal
