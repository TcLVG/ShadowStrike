@echo off

rem URL de la vidéo YouTube
set "video_url=https://youtu.be/dQw4w9WgXcQ"

rem Téléchargement de la vidéo avec youtube-dl
youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -o video.mp4 %video_url%

rem Lecture de la vidéo avec mpv
mpv video.mp4

rem Suppression de la vidéo après la lecture
del video.mp4
