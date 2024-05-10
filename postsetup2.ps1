# flame's Windows 10 post-install script.

# 9p7knl5rwt25 = sysinternals, 9N0DX20HK701 = windows terminal
$wingetPackages = "Microsoft.PowerToys", "Discord.Discord", "Google.Chrome", "9p7knl5rwt25", "ShareX.ShareX", "9N0DX20HK701", "VSCodium.VSCodium", "Guru3D.Afterburner", "Oracle.VirtualBox", "Librewolf.Librewolf", "RARLab.WinRAR", "Valve.Steam", "CrystalDewWorld.CrystalDiskInfo", "RealVNC.VNCViewer", "Git.Git", "Notepad++.Notepad++", "Python.Python.3.11", "Microsoft.DotNet.SDK.8", "EpicGames.EpicGamesLauncher", "dotPDNLLC.paintdotnet", "OBSProject.OBSStudio", "Spotify.Spotify", "Nvidia.GeForceExperience", "qBittorrent.qBittorrent", "Microsoft.PowerShell", "StartIsBack.StartIsBack", "Mojang.MinecraftLauncher", "CodecGuide.KLiteCodecPack.Mega", "yt-dlp.yt-dlp", "cURL.cURL", "GNU.Wget2"
$chocolateyPackages = "tenacity", "photogimp", "handbreak", "inkscape", "blender", "winscp", "etcher", "imgburn", "lghub", "razer-synapse-3", "teracopy", "spotify", "handbrake"

$elevated = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match 'S-1-5-32-544'
if (-not $elevated) {
	Write-Host "This script requires administrative privileges. Please run it again in an elevated command prompt." -ForegroundColor Red
	exit
}

Write-Host "The following packages will be installed:"
foreach ($package in $wingetPackages) {
	Write-Host "Winget: $package" -ForegroundColor Yellow
}
foreach ($package in $chocolateyPackages) {
	Write-Host "Chocolatey: $package" -ForegroundColor Yellow
}

Read-Host -Prompt "Press any key to continue"

Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

foreach ($package in $wingetPackages) {
	winget install $package --accept-package-agreements
}
foreach ($package in $chocolateyPackages) {
	choco install $package -y # "-y" probably isn't needed, but oh well.
}

[console]::beep(500,500)		# Beep when complete; a self reminder
[console]::beep(500,500)
[console]::beep(500,500)

Read-Host -Prompt "Done, press any key to exit"