<#
 .Synopsis
 Verwenden einer benutzerdefinierten WMI-Klasse
#>

$MofPfad = Join-Path -Path $PSScriptRoot -ChildPath "../Material/Win32_Product32.mof"

$MofCompfad = "C:\Windows\System32\wbem\mofcomp.exe"

 # Die Mof-Datei wird in das lokale WMI Repository kompiliert
.$MofCompfad $MofPfad

# Die Abfrage der installierten Anwendungen wird jetzt etwas einfacher möglich (cool;)
Get-CimInstance -ClassName Produktliste -Namespace root\default