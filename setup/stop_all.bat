@echo off
rem stop_all.bat: stops PostgreSQL, Metabase and Jupyter when you finish.
rem Close DBeaver yourself first, so it can ask you to save your SQL scripts.
setlocal
call "%~dp0env.bat"
title DWBI stop all

rem Metabase and Jupyter run in windows their launchers named, so only those windows stop.
taskkill /FI "WINDOWTITLE eq DWBI Metabase*" /T /F >nul 2>&1
echo Metabase: stopped, or it was not running.
taskkill /FI "WINDOWTITLE eq DWBI Jupyter*" /T /F >nul 2>&1
echo Jupyter: stopped, or it was not running.

if not exist "%PGBIN%\pg_ctl.exe" goto :end
"%PGBIN%\pg_ctl.exe" status -D "%PGDATA%" >nul 2>&1
if errorlevel 1 (
    echo PostgreSQL was not running.
    goto :end
)
"%PGBIN%\pg_ctl.exe" stop -D "%PGDATA%" -m fast -w
if errorlevel 1 (
    echo FAIL  PostgreSQL did not stop. Close DBeaver, then run stop_all again.
) else (
    echo PASS  PostgreSQL stopped. You can now close this window, or move the kit folder.
)

:end
echo Close DBeaver yourself, if it is still open.
echo.
pause
endlocal
