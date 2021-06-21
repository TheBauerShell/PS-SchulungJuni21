<#
 .Synopsis
 Beispiel Nr. 7 - Ausführen einer Function, die in einer Psd1-Datei enthalten ist
#>

# Variablen, die nicht belegt wurden, sollen einen Fehler auslösen (praktisch)
Set-StrictMode -Version Latest

# Pfad derPsm1-Datei bilden
# Das ist aber nur eine Ausnahme - normalerweise ist die Psm1-Datei Teil eines Modulverzeichnises
$ModulPfad = Join-Path -Path $PSScriptRoot -ChildPath PsKurs

Import-Module -Name $ModulPfad -Verbose

# Jetzt kann die Function ausgeführt werden
Get-ChildItem -Path $env:userprofile -Directory | Get-Speicherkosten -Faktor 0.5