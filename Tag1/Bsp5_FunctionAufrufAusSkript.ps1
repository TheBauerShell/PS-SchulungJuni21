<#
 .Synopsis
 Beispiel Nr. 5 - Ausf�hren einer Function, die in einer Ps1-Datei enthalten ist
#>

# Variablen, die nicht belegt wurden, sollen einen Fehler ausl�sen (praktisch)
Set-StrictMode -Version Latest

# Ps1-Datei dotsourced ausf�hren

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath Bsp4_FunctionMitParameten_Pipeline.ps1

."$Ps1Pfad"

# Jetzt kann die Function ausgef�hrt werden
Get-ChildItem -Path $env:userprofile -Directory | Get-Speicherkosten -Faktor 0.5