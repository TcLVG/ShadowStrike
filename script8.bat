@echo off

rem URL de l'image sur GitHub
set "image_url=https://github.com/TcLVG/ShadowStrike/blob/main/shrek.jpg"

rem Chemin où sauvegarder temporairement l'image
set "temp_image=C:\temp\image.jpg"

rem Téléchargement de l'image depuis GitHub
curl -o "%temp_image%" "%image_url%"

rem Commande pour changer le fond d'écran
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%temp_image%" /f

rem Actualisation du fond d'écran
rundll32.exe user32.dll, UpdatePerUserSystemParameters

echo Fond d'écran changé avec succès.

rem Suppression de l'image temporaire
del "%temp_image%"
