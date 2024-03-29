<#
 .Synopsis
 Beispiel Nr. 1 - Berechnen der Speichernkosten f�r ein Verzeichnis
#>

[CmdletBinding()]
param([String]$Pfad, [Double]$Faktor=0.5)

# Variablen, die nicht belegt wurden, sollen einen Fehler ausl�sen (praktisch)
Set-StrictMode -Version Latest

# Zum Testen praktisch
if (!$Pfad)
{
    $Pfad = Get-Location
}
# Das Initialisieren einer Variablen ist optional
$SummeBytes = 0

Get-ChildItem -Path $Pfad -File -Recurse | ForEach-Object {
    $SummeBytes += $_.Length
}

$SummeMB = $SummeBytes / 1MB
$KostenMB = $SummeMB * $Faktor

# Eine Ausgabe sollte immer ein Objekt sein - Genau daf�r ist der Typ PSCustomObject da
[PSCustomObject]@{
    Verzeichnis = $Pfad
    KostenMB = [Math]::Round($KostenMB,3)
    Kosten = "{0:C}" -f [Math]::Round($KostenMB,3)
}



