<#
 .Synopsis
 Speichert die PSCredentials für Remoting in eine Xml-Datei
#>

$Pw = ConvertTo-SecureString -String "demo+12345678" -AsPlainText -Force
$Username = "poshadmin"
$PSCred = [PSCredential]::New($Username, $Pw)

$XmlPfad = join-Path -Path $PSScriptRoot -ChildPath "PoshadminCreds.xml"

$PSCred | Export-CliXml -Path $XmlPfad