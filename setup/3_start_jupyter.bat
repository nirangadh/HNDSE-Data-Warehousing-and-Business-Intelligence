@echo off
rem 3_start_jupyter.bat: starts Jupyter from WinPython, in the work folder.
rem Keep this window open while you work. Closing it, or stop_all, stops Jupyter.
setlocal
call "%~dp0env.bat"
title DWBI Jupyter

if not defined PY (
    echo FAIL  WinPython not found in tools. Its folder name starts with WPy64.
    echo       Copy the tools folder from the lab USB into the kit folder, then run 0_check_setup.
    echo.
    pause
    goto :end
)
if not exist "%WORK%" mkdir "%WORK%"
cd /d "%WORK%"
echo Starting Jupyter in the work folder:
echo     "%WORK%"
echo Put each day's notebook and data files in this folder. Your browser opens Jupyter.
"%PY%" -m jupyter lab
echo.
echo Jupyter has stopped.
pause

:end
endlocal
