# Script PowerShell pour récupérer des informations sur le système Windows

# Récupérer le nom de l'hôte
$hostName = hostname

# Récupérer le système d'exploitation
$osInfo = (Get-CimInstance Win32_OperatingSystem).Caption

# Récupérer la version du noyau
$kernelVersion = (Get-CimInstance Win32_OperatingSystem).Version

# Récupérer les informations sur le processeur
$cpuInfo = (Get-CimInstance Win32_Processor).Name

# Récupérer la quantité de mémoire RAM disponible
$ramInfo = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory * 1GB


# Afficher les informations récupérées
Write-Host Informations système pour $hostName 
Write-Host Système d'exploitation  $osInfo
Write-Host Version du noyau  $kernelVersion
Write-Host Processeur  $cpuInfo
Write-Host Mémoire RAM (en Go)  $ramInfo
