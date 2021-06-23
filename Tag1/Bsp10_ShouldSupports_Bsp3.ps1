<#
 .Synopsis
 Beispiel für das Zusammenspiel von ConfirmImpact und ConfirmPreference
 .Description
 Über die CmdletBindung-Property ConfirmImpact und die globale Variable ConfirmPreference kann die Wirkung des Confirm-Parameters gesteuert werden
 Das bedeutet konkret, dass Confirm einmal eine Wirkung hat und einmal nicht
 Der Autor der Function legt per ConfirmImpact fest, wie schwerwiegend die Auswirkung von Aktionen ist, die seine Function ausführt
 Durch die Variable ConfirmPreference wird allgemein festlegt, wie sicherheitssensibel eine Function ausgeführt wird
#>

function Remove-Number
{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact="Medium")]
    param([Int[]]$BaseArray, [Int[]]$RemoveArray)
    foreach($z in $RemoveArray)
    {
        if ($PSCmdlet.ShouldProcess("Element $z löschen?"))
        {
            $BaseArray = $BaseArray -ne $z
        }
    }
    $BaseArray
}

$z1 = 1..10
$z2 = 3,5,7

# Bei ConfirmPreference=High passiert nichts
#$ConfirmPreference = "High"
#Remove-Number $z1 $z2

$ConfirmPreference = "Low"
Remove-Number $z1 $z2

