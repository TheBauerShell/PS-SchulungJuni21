<#
 .Synopsis
 Beispiel Nr. 2 - Die Berechnung als Function
#>

# Variablen, die nicht belegt wurden, sollen einen Fehler auslösen (praktisch)
Set-StrictMode -Version Latest
    
# Alternativ:
# function Get-Speicherkosten($Pfad, $Faktor)

function Get-Speicherkosten
{
    param($Pfad, $Faktor=0.5)
    
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

# Probeaufruf 
Get-Speicherkosten -Pfad $env:userprofile\Pictures -Faktor 2