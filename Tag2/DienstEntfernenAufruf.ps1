<#
 .Synopsis
 Aufruf des Skriptes Dienstenfernen.ps1
#>
# Das Skriptverzeichnis zum aktuellen Verzeichnis machen
Set-Location -path $PSScriptRoot

$Dienstname = "ZitateDienstV1"

.\Dienstentfernen.ps1 -ServiceName $Dienstname -Verbose