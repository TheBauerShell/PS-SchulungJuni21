<#
 .Synopsis
 Beispiel Nr. 3 - Die Berechnung als Function mit der offziellen Parameterschreibweise
#>

# Variablen, die nicht belegt wurden, sollen einen Fehler auslösen (praktisch)
Set-StrictMode -Version Latest
    
<#
 .Synopsis
 Berechnen der Speicherkosten
 .Description
 Die Speicherkosten für ein Verzeichnis berechnen
 .Example
 Get-Speicherkosten -Pfad //server1/share2 -Faktor 0.3
#>
function Get-Speicherkosten
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String]$Pfad, [ValidateScript({$_ -gt 0})][Double]$Faktor=0.5)
    
    # Das Initialisieren einer Variablen ist optional
    $SummeBytes = 0
    
    Get-ChildItem -Path $Pfad -File -Recurse | ForEach-Object {
        $SummeBytes += $_.Length
    }
    
    $SummeMB = $SummeBytes / 1MB
    $KostenMB = $SummeMB * $Faktor
    
    # Eine Ausgabe sollte immer ein Objekt sein - Genau dafür ist der Typ PSCustomObject da
    [PSCustomObject]@{
        Verzeichnis = $Pfad
        KostenMB = [Math]::Round($KostenMB,3)
        Kosten = "{0:C}" -f [Math]::Round($KostenMB,3)
    }
}

# "Falscher" Aufruf
Get-Speicherkosten -Pfad $env:userprofile\Pictures -Faktor -1

# "Richtiger" Aufruf
Get-Speicherkosten -Pfad $env:userprofile\Pictures -Faktor 1