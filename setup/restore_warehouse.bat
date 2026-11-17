@echo off
rem restore_warehouse.bat: replaces schema warehouse with the known-good warehouse from
rem Day 4's reference folder, then counts its rows. Schema registration is not touched.
rem It does what the lab sheets do with: psql -d thara -f dw_complete.sql
setlocal
call "%~dp0env.bat"
title DWBI restore warehouse
set "OUT=%TEMP%\dwbi_restore.txt"

if not exist "%DWDUMP%" (
    echo FAIL  days\day-4\reference\dw_complete.sql is not in the kit yet.
    echo       Download the module files again and copy them into the kit folder.
    goto :end
)
"%PGBIN%\pg_ctl.exe" status -D "%PGDATA%" >nul 2>&1
if errorlevel 1 (
    echo FAIL  PostgreSQL is not running. Run 1_start_postgres first.
    goto :end
)

echo Restoring the warehouse. Your own tables in schema warehouse are replaced too.
"%PGBIN%\psql.exe" -X -q -d thara -f "%DWDUMP%"
"%PGBIN%\psql.exe" -X -tA -F " " -d thara -o "%OUT%" -c "SELECT (SELECT count(*) FROM warehouse.dim_student), (SELECT count(*) FROM warehouse.dim_course), (SELECT count(*) FROM warehouse.dim_date), (SELECT count(*) FROM warehouse.fact_enrollment)"
set "COUNTS="
set /p COUNTS=<"%OUT%"
echo Rows: dim_student, dim_course, dim_date, fact_enrollment = %COUNTS%
if "%COUNTS%"=="20 7 4 73" (
    echo PASS  The warehouse is restored: 20, 7, 4 and 73 rows.
) else (
    echo FAIL  The counts should be 20, 7, 4 and 73. Run 0_check_setup to check the file.
)

:end
if exist "%OUT%" del "%OUT%"
echo.
pause
endlocal
