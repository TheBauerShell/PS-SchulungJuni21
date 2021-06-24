<#
 .Synopsis
 Explizite Bestäigung per Confirm für "eigene Aktionen" und Wirkung von WhatIf
 .Description
 Erklärung: Für eigene Aktionen, bei denen kein Cmdlet im Spiel ist, gibt es keinen Confirm-Automatismus
 Hier muss man selber aktiv werden und abfragen: Wurden Confirm und/oder Whatif gesetzt?
 In beiden Fällen geschieht dies über den Aufruf von $PSCmdlet.ShouldProcess
#>

using namespace System.Collections.Generic

class Server
{
    [String]$Name
    Server([String]$Servername)
    {
        $this.Name = $Servername
    }
}

<#
 .Synopsis
 Entfernt ein Serverobjekt aus der Liste
#>
function Remove-Server
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param([Server]$Server)
    if ($PSCmdlet.ShouldProcess("Server $($Server.Name) löschen?"))
    {
        [Void]$Serverliste.Remove($Server)
    }
}

# Schritt 1: Es werden zwei Server-Objekte angelegt und zur Liste hinzugefügt
$S1 = [Server]::new("Server1")
$S2 = [Server]::new("Server2")
$S3 = [Server]::new("Server3")
$ServerListe = [List[Server]]::new()

$ServerListe.Add($S1)
$ServerListe.Add($S2)
$ServerListe.Add($S3)

# Schritt 2: Server $S1 wird ohne Rückfrage entfernt
Remove-Server $S1

# Schritt 3: Server $S2 wird dank WhatIf nicht entfernt
Remove-Server $S2 -WhatIf

# Schritt 4: Server $S2 wird nur nach Rückfrage entfernt
Remove-Server $S2 -Confirm

# Schritt 5: Ausgabe der aktuellen Liste
$ServerListe