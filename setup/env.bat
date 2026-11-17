@echo off
rem ============================================================================
rem  env.bat: the settings every launcher reads. This is the only file you edit.
rem  You do not run it yourself. Each launcher in this folder runs it first.
rem ============================================================================

rem The kit folder is the folder that holds this setup folder. It is worked out
rem from where this file sits, so a new drive letter or folder name changes nothing.
for %%I in ("%~dp0..") do set "KIT=%%~fI"

rem ---- You may change these lines --------------------------------------------
rem Where the tools from the lab USB are, where your databases live, and where
rem Jupyter and psql start. Keep each value inside its quotes.
set "TOOLS=%KIT%\tools"
set "DATA=%KIT%\data"
set "WORK=%KIT%\work"

rem The port PostgreSQL listens on. Change it only if 0_check_setup says the
rem port is used by another program, then run every launcher again.
set "PGPORT=15432"

rem The port Metabase listens on. Open http://localhost:3300 in your browser.
set "MB_PORT=3300"

rem The Java version the Metabase on your lab USB needs. Your lecturer sets it.
set "JAVA_NEEDED=25"
rem ---- Do not change anything below this line --------------------------------

rem PostgreSQL. psql, DBeaver and Metabase all connect with these settings.
set "PGBIN=%TOOLS%\pgsql\bin"
set "PGDATA=%DATA%\pgdata"
set "PGLOG=%DATA%\postgres.log"
set "PGHOST=localhost"
set "PGUSER=postgres"
set "PGDATABASE=thara"

rem The files a day needs, inside the module folder.
set "DAYS=%KIT%\days"
set "D1SQL=%DAYS%\day-1\sql\d1_registration.sql"
set "DWDUMP=%DAYS%\day-4\reference\dw_complete.sql"

rem DBeaver keeps its workspace inside the kit, so it moves with the kit.
set "DBEAVER=%TOOLS%\dbeaver"
set "DBEAVER_WS=%DATA%\dbeaver-workspace"
set "JDBC=%TOOLS%\jdbc"

rem Metabase, on its own Java. Its settings database lives inside the kit.
set "JAVA_HOME=%TOOLS%\java"
set "MB_JAR=%TOOLS%\metabase\metabase.jar"
set "MB_HOME=%DATA%\metabase"
set "MB_DB_FILE=%MB_HOME%\metabase.db"
set "MB_JETTY_PORT=%MB_PORT%"
set "MB_JETTY_HOST=localhost"
set "MB_ANON_TRACKING_ENABLED=false"
set "MB_CHECK_FOR_UPDATES=false"

rem WinPython. Its folder name carries the Python version and differs between
rem builds, so the launchers find it here instead of asking you to type it.
set "WINPY="
for /f "delims=" %%W in ('dir /b /ad "%TOOLS%\WPy64-*" 2^>nul') do set "WINPY=%TOOLS%\%%W"
set "PY="
if defined WINPY for /f "delims=" %%P in ('dir /b /ad "%WINPY%\python*" 2^>nul') do if exist "%WINPY%\%%P\python.exe" set "PY=%WINPY%\%%P\python.exe"

rem The kit's own psql comes first, before any other PostgreSQL on this computer.
set "PATH=%PGBIN%;%PATH%"
