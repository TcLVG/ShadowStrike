@echo off
setlocal

rem Spécifiez le chemin du navigateur web (Chrome) sur votre système
set "navigateur=C:\Program Files\Google\Chrome\Application\chrome.exe"

rem Lien vers la vidéo YouTube
set "lien_video=https://www.youtube.com/watch?v=gagePw3QA3U"

rem Lance le navigateur avec le lien vidéo
"%navigateur%" "%lien_video%"

endlocal

