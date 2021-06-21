<#
 .Synopsis
 Verwenden benutzerdefinierter Mof-Klassen - Teil 1
 .Notes
Das Beispiel besitzt nur einen geringen praktischen Nutzen, es soll in erster Linie deutlich machen, dass der Umgang mit Mof-Dateien grundsätzlich nichts Besonderes ist
 #>

$MofPfad = Join-Path -Path $PSScriptRoot -ChildPath "..\Material\PSDocument.mof"

$MofCompfad = "C:\Windows\System32\wbem\mofcomp.exe"

 # Die Mof-Datei wird in das lokale WMI Repository kompiliert
.$MofCompfad $MofPfad

 # Die neue Klasse wird geholt
Get-CIMClass -ClassName PSDocument -Namespace root\MOFTest | Select-Object -ExpandProperty CimCLassProperties