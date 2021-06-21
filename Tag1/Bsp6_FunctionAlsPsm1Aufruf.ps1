<#
 .Synopsis
 Beispiel Nr. 6 - Ausf�hren einer Function, die in einer Psm1-Datei enthalten ist
#>

# Variablen, die nicht belegt wurden, sollen einen Fehler ausl�sen (praktisch)
Set-StrictMode -Version Latest

# Pfad derPsm1-Datei bilden
# Das ist aber nur eine Ausnahme - normalerweise ist die Psm1-Datei Teil eines Modulverzeichnises
$Psm1Pfad = Join-Path -Path $PSScriptRoot -ChildPath Speicherkosten.psm1

Import-Module -Name $Psm1Pfad -Verbose

# Jetzt kann die Function ausgef�hrt werden
Get-ChildItem -Path $env:userprofile -Directory | Get-Speicherkosten -Faktor 0.5