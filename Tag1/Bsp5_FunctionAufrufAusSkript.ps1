<#
 .Synopsis
 Beispiel Nr. 5 - Ausführen einer Function, die in einer Ps1-Datei enthalten ist
#>

# Variablen, die nicht belegt wurden, sollen einen Fehler auslösen (praktisch)
Set-StrictMode -Version Latest

# Ps1-Datei dotsourced ausführen

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath Bsp4_FunctionMitParameten_Pipeline.ps1

."$Ps1Pfad"

# Jetzt kann die Function ausgeführt werden
Get-ChildItem -Path $env:userprofile -Directory | Get-Speicherkosten -Faktor 0.5