<#
 .Synopsis
 Registieren eines Dienstes an einem Beispiel
#>

# Das Skriptverzeichnis zum aktuellen Verzeichnis machen
Set-Location -path $PSScriptRoot

$Dienstname = "ZitateDienstV3"
$Beschreibung = "Liefert ein Zitat des Tages"
$Anzeigename = "Posh-Zitatedienst"
$ExePfad = Join-Path -Path $PSScriptRoot -ChildPath "..\Material\ZitatedienstV3.exe"
# .\DienstSetup.ps1  -Servicename $Dienstname -DisplayName $Anzeigename -Description $Beschreibung -ExePath $ExePfad
.\DienstSetup.ps1  -Servicename $Dienstname -DisplayName $Anzeigename -Description $Beschreibung -ExePath $ExePfad # -Username ".\Administrator" -Password "demo+123"