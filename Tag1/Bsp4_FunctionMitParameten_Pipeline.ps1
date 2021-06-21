<#
 .Synopsis
 Beispiel Nr. 4 - Die Function kann auch über die Pipeline ausgeführt werden
#>

# Variablen, die nicht belegt wurden, sollen einen Fehler auslösen (praktisch)
Set-StrictMode -Version Latest
    
<#
 .Synopsis
 Berechnen der Speicherkosten
 .Description
 Die Speicherkosten für ein Verzeichnis berechnen
 .Example
 Get-Childitem -Path //server1/share2 -Directory | Get-Speicherkosten -Faktor 0.3
 .Notes
 Es kommt auf den Alias für den Pfad-Parameter an - Fullname ist eine Property des Objekts, das von Get-Childitem in die Pipeline gelegt wird
 Damit ist eine Parameterbindung über den Propertynamen möglich - PSPath ginge auch, ist aber nicht ganz optimal, da die Providerschreibweise verwendet wird
#>
function Get-Speicherkosten
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)][Alias("Fullname")][String]$Pfad, [ValidateScript({$_ -gt 0})][Double]$Faktor=0.5)
    
    process
    {
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
}

# Pipeline-Aufruf wie bei einem Cmdlet üblich
Get-ChildItem -Path $env:userprofile -Directory | Get-Speicherkosten -Faktor 0.5