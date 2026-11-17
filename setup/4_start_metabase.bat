@echo off
rem 4_start_metabase.bat: starts Metabase on the kit's own Java. Its settings database
rem lives inside the kit. Keep this window open while you work. stop_all stops Metabase.
setlocal
call "%~dp0env.bat"
title DWBI Metabase

if not exist "%JAVA_HOME%\bin\java.exe" (
    echo FAIL  Java not found in tools.
    echo       Follow section 5 of the Build your own tools folder page.
    echo       Then run 0_check_setup.
    echo.
    pause
    goto :end
)
if not exist "%MB_JAR%" (
    echo FAIL  Metabase not found in tools\metabase.
    echo       Follow section 5 of the Build your own tools folder page.
    echo       Then run 0_check_setup.
    echo.
    pause
    goto :end
)
if not exist "%MB_HOME%" mkdir "%MB_HOME%"
cd /d "%MB_HOME%"

"%PGBIN%\pg_ctl.exe" status -D "%PGDATA%" >nul 2>&1
if errorlevel 1 echo Note: PostgreSQL is not running yet. Run 1_start_postgres before you add the database.

echo Starting Metabase. When this window shows "Metabase Initialization COMPLETE", open
echo     http://localhost:%MB_PORT%
echo in your browser. To add the warehouse, choose PostgreSQL and type:
echo     host localhost, port %PGPORT%, database thara, user postgres, password empty.
echo.
rem Metabase listens on this computer only (MB_JETTY_HOST in env.bat), so Windows asks no firewall question.
"%JAVA_HOME%\bin\java.exe" --add-opens java.base/java.nio=ALL-UNNAMED -jar "%MB_JAR%"
echo.
echo Metabase has stopped.
pause

:end
endlocal
