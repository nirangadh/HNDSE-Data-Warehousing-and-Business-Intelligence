@echo off
rem open_psql.bat: opens a command window where psql connects to the kit's database.
rem Type the lab sheet's commands exactly as written, for example: psql -d thara
call "%~dp0env.bat"
title DWBI psql
rem The standard Windows code page, so psql prints no code page warning when it starts.
chcp 1252 >nul
if not exist "%WORK%" mkdir "%WORK%"
cd /d "%WORK%"
echo This window is ready for psql. It starts in the work folder:
echo     "%WORK%"
echo To run a file, first change to the folder that holds it, for example: cd day4
echo psql connects to host localhost, port %PGPORT%, database thara, user postgres.
echo Type exit to close this window.
echo.
cmd /k
