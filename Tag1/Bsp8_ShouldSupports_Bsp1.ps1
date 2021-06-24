<#
 .Synopsis
 Beispiel für SupportsShouldProcess mit Remove-Item
 .Description
 Durch SupportShouldProcess erhält die Function einen Confirm-Parameter, der automatisch an die beiden Cmdlets weitergereicht wird
 Frage: Wie oft muss die Ausführung der Function bestätigt werden?
#>

function Test-Confirm
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()
    New-Item -Name Test.dat -ItemType File | Out-Null
    "Test.dat" | Remove-item
}


Test-Confirm -Confirm