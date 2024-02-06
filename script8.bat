@echo off

rem URL de la vidéo YouTube
set "video_url=https://youtu.be/dQw4w9WgXcQ"

rem Créer un fichier PowerShell temporaire pour ouvrir l'URL dans le navigateur
echo Start-Process '%video_url%' -Wait > open_video.ps1

rem Exécuter le script PowerShell
powershell -ExecutionPolicy Bypass -File open_video.ps1

rem Supprimer le script PowerShell temporaire
del open_video.ps1
