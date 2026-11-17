@echo off
rem 0_check_setup.bat: checks every tool and every file a posted day needs.
rem Each line says PASS or FAIL. A FAIL line says what to do next.
setlocal
call "%~dp0env.bat"
title DWBI check setup
set "NPASS=0"
set "NFAIL=0"
set "OUT=%TEMP%\dwbi_check.txt"

echo.
echo Data Warehousing and Business Intelligence: setup check
echo Kit folder:
echo     "%KIT%"
echo.

rem ---- The kit folder ---------------------------------------------------------
echo "%KIT%"| find "!" >nul
if not errorlevel 1 call :fail "Kit folder name" "Rename the folder: remove the ! character from its name."
echo "%KIT%"| find "%%" >nul
if not errorlevel 1 call :fail "Kit folder name" "Rename the folder: remove the percent character from its name."
echo "%KIT%"| find /i "OneDrive" >nul
if not errorlevel 1 call :fail "Kit folder place" "Move the kit out of OneDrive. Syncing breaks the database files."
if not exist "%DATA%" mkdir "%DATA%" 2>nul
type nul > "%DATA%\write_test.txt" 2>nul
if exist "%DATA%\write_test.txt" (
    del "%DATA%\write_test.txt"
    call :pass "Kit folder can be written to"
) else (
    call :fail "Kit folder cannot be written to" "Copy the kit to a folder you can write to, such as one in Documents."
)

rem ---- PostgreSQL ---------------------------------------------------------------
if not exist "%PGBIN%\psql.exe" (
    call :fail "PostgreSQL not found in tools\pgsql" "Follow section 1, step 3 of the Build your own tools folder page."
    goto :after_pg
)
"%PGBIN%\psql.exe" --version > "%OUT%" 2>&1
set "PGV="
for /f "usebackq tokens=3" %%V in ("%OUT%") do if not defined PGV set "PGV=%%V"
set "PGMAJ="
set "PGMIN="
for /f "tokens=1,2 delims=." %%A in ("%PGV%") do (
    set "PGMAJ=%%A"
    set "PGMIN=%%B"
)
if not defined PGMIN set "PGMIN=0"
if "%PGMAJ%"=="16" if %PGMIN% GEQ 10 (
    call :pass "PostgreSQL %PGV%"
    goto :pg_version_done
)
call :fail "PostgreSQL %PGV%: the kit needs 16.10 or later in the 16 line" "Follow section 1, step 1 of the Build your own tools folder page."
:pg_version_done

"%PGBIN%\pg_ctl.exe" status -D "%PGDATA%" >nul 2>&1
if not errorlevel 1 (
    call :pass "PostgreSQL is running on port %PGPORT%"
    goto :pg_running
)
netstat -an | find ":%PGPORT% " | find "LISTENING" >nul
if not errorlevel 1 (
    call :fail "Port %PGPORT% is used by another program" "Change PGPORT in env.bat to another number, such as 15433."
) else (
    call :pass "Port %PGPORT% is free for PostgreSQL"
)
if exist "%PGDATA%\postmaster.pid" call :fail "A lock file was left behind" "Run 1_start_postgres. It removes the old lock file and starts the server."
if exist "%PGDATA%\PG_VERSION" (
    call :pass "Database folder exists"
) else (
    call :pass "Database folder not created yet: 1_start_postgres creates it"
)
goto :after_pg

:pg_running
"%PGBIN%\psql.exe" -X -tA -d postgres -c "SELECT count(*) FROM pg_database WHERE datname = 'thara'" -o "%OUT%" 2>nul
set "N="
set /p N=<"%OUT%"
if "%N%"=="1" (
    call :pass "Database thara exists"
) else (
    call :fail "Database thara does not exist yet" "Run 1_start_postgres. It creates the database."
)
:after_pg

rem ---- DBeaver --------------------------------------------------------------------
if exist "%DBEAVER%\dbeaver.exe" (
    call :pass "DBeaver found"
) else (
    call :fail "DBeaver not found in tools\dbeaver" "Follow section 3, step 4 of the Build your own tools folder page."
)
if exist "%JDBC%\postgresql-*.jar" (
    call :pass "PostgreSQL driver for DBeaver found"
) else (
    call :fail "PostgreSQL driver not found in tools\jdbc" "Follow section 2, step 3 of the Build your own tools folder page."
)

rem ---- WinPython, pandas and Jupyter ----------------------------------------------
if not defined PY (
    call :fail "WinPython not found in tools" "Follow section 4, step 4 of the Build your own tools folder page."
    goto :after_py
)
"%PY%" -c "import pandas; print(pandas.__version__)" > "%OUT%" 2>nul
set "PDV="
set /p PDV=<"%OUT%"
if not defined PDV set "PDV=none"
set "PDOK="
if "%PDV:~0,4%"=="3.0." set "PDOK=1"
if "%PDV:~0,4%"=="3.1." set "PDOK=1"
if defined PDOK (
    call :pass "pandas %PDV%"
) else (
    call :fail "pandas %PDV%: the labs need pandas 3.0 or 3.1" "Follow section 4, step 1 of the Build your own tools folder page."
)
"%PY%" -c "import jupyterlab" >nul 2>&1
if not errorlevel 1 (
    call :pass "Jupyter found"
) else (
    call :fail "Jupyter not found in WinPython" "Follow section 4, step 1 of the Build your own tools folder page."
)
:after_py

rem ---- Java and Metabase ------------------------------------------------------------
rem Needed once Day 6 is posted, for every tools folder, and tested earlier if present.
set "NEEDJM="
if exist "%DAYS%\day-%JAVA_FROM_DAY%\lab.md" set "NEEDJM=1"
if not exist "%JAVA_HOME%\bin\java.exe" (
    if defined NEEDJM (
        call :fail "Java not found in tools" "Follow section 5 of the Build your own tools folder page."
    ) else (
        call :pass "Java: not needed until Day %JAVA_FROM_DAY%"
    )
    goto :java_done
)
"%JAVA_HOME%\bin\java.exe" -version 2> "%OUT%"
set "JV="
for /f "usebackq tokens=3" %%V in ("%OUT%") do if not defined JV set "JV=%%~V"
set "JMAJ="
for /f "tokens=1 delims=." %%M in ("%JV%") do set "JMAJ=%%M"
if not defined JMAJ set "JMAJ=0"
if %JMAJ% GEQ %JAVA_NEEDED% (
    call :pass "Java %JV%"
) else (
    call :fail "Java %JV%: Metabase needs Java %JAVA_NEEDED%" "Follow section 5 of the Build your own tools folder page."
)
:java_done
if exist "%MB_JAR%" (
    call :pass "Metabase found"
) else if defined NEEDJM (
    call :fail "Metabase not found in tools\metabase" "Follow section 5 of the Build your own tools folder page."
) else (
    call :pass "Metabase: not needed until Day %JAVA_FROM_DAY%"
)
netstat -an | find ":%MB_PORT% " | find "LISTENING" >nul
if errorlevel 1 (
    call :pass "Port %MB_PORT% is free for Metabase"
) else (
    call :pass "Port %MB_PORT% is in use: if Metabase is running, that is right"
)

rem ---- Files a posted day needs -----------------------------------------------------
rem Each line: the day that needs the file, the file inside the days folder, then its
rem SHA-256 checksum as published and with the other kind of line ending.
echo.
echo Files the posted days need:
call :need 1 "day-1\sql\d1_registration.sql" b5f4a123ace5548a04d28e6d68ca3ec41045a549ce447a54c79d0a834ec9db52 fe8232ac7962e3a843fbab72a53b7a5d60ee94ef06efc7216bac9aaec80855f5
call :need 3 "day-3\data\enrollments_raw.csv" 6a508263843298c6e970054ce5e403627f7996972356390a9a3007271d04f3bf 26a0380cb8f713efe6da52c540920e6bf8856914afc075f97e611117beebcfba
call :need 3 "day-3\data\student_registry.csv" cb4446f045b9f4eeb0852bb1ee881c286624af6aa6534e3ad2478b0e215bf44c aeee369e35289e266f20791ee7b77631468b02fc368dffa0deb18a3d1a27242e
call :need 4 "day-3\reference\enrollments_conformed.csv" a9e1e4a058462f22f7b2cbdff9c08fd0df956c0bdf4a2ab2761b24b21a8e64c7 446c5c9aa868ba8c2617b2f5e2ecc4ef01dca8c122711c3340ea24d87a9083a5
call :need 4 "day-4\reference\dw_complete.sql" b0ed3e5b7d7efebf59c3fd3a1bc60bebcd74066ce90f25048862192fc73271a4 468642cf275eec1c5f499357b0b70a4490e32b28ea9f00518d60a34af84c5302
call :need 5 "day-4\reference\dw_complete.sql" b0ed3e5b7d7efebf59c3fd3a1bc60bebcd74066ce90f25048862192fc73271a4 468642cf275eec1c5f499357b0b70a4490e32b28ea9f00518d60a34af84c5302
call :need 6 "day-4\reference\dw_complete.sql" b0ed3e5b7d7efebf59c3fd3a1bc60bebcd74066ce90f25048862192fc73271a4 468642cf275eec1c5f499357b0b70a4490e32b28ea9f00518d60a34af84c5302
call :need review "day-4\reference\dw_complete.sql" b0ed3e5b7d7efebf59c3fd3a1bc60bebcd74066ce90f25048862192fc73271a4 468642cf275eec1c5f499357b0b70a4490e32b28ea9f00518d60a34af84c5302

echo.
echo Result: %NPASS% PASS, %NFAIL% FAIL
if "%NFAIL%"=="0" (
    echo Everything is ready. Next, run 1_start_postgres.
) else (
    echo Fix each FAIL line from the top, then run this check again.
)
if exist "%OUT%" del "%OUT%"
echo.
pause
endlocal
exit /b 0

rem ---- Subroutines. Arguments never carry a folder path, so no path can break them. ----
:pass
set /a NPASS+=1
echo PASS  %~1
exit /b 0

:fail
set /a NFAIL+=1
echo FAIL  %~1
echo       %~2
exit /b 0

:need
rem %1 = the day that needs the file, %2 = the file inside the days folder, %3 and %4 = its checksums.
rem A day counts as posted once its lab sheet is there (the review: its notes).
if "%~1"=="review" (
    set "POSTED=%DAYS%\review\notes.md"
    set "WHO=The review session"
) else (
    set "POSTED=%DAYS%\day-%~1\lab.md"
    set "WHO=Day %~1"
)
if not exist "%POSTED%" exit /b 0
set "F=%DAYS%\%~2"
if not exist "%F%" (
    call :fail "%WHO% needs days\%~2, which is missing" "Download the module files again and copy them into the kit folder."
    exit /b 0
)
set "GOT="
certutil -hashfile "%F%" SHA256 > "%OUT%" 2>nul
for /f "usebackq skip=1 delims=" %%H in ("%OUT%") do if not defined GOT set "GOT=%%H"
if defined GOT set "GOT=%GOT: =%"
if not defined GOT (
    call :pass "%WHO%: days\%~2 is there (its checksum could not be computed)"
    exit /b 0
)
if /i "%GOT%"=="%~3" (
    call :pass "%WHO%: days\%~2"
    exit /b 0
)
if /i "%GOT%"=="%~4" (
    call :pass "%WHO%: days\%~2"
    exit /b 0
)
call :fail "%WHO%: days\%~2 has been changed" "Copy it again from the reference folder of the module files."
exit /b 0
