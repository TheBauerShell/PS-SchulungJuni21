<#
 .Synopsis
 Geschwindigkeitsunterschiede beim Einlesen einer Textdatei
 .Description
 Get-Content versus StreamReader
 .Notes
 Grunds‰§tzliche ‹berlegungen:
 >Auch Get-Content wurde bei Version 5.1 inzwischen optimiert
 >Die Unterschiede fallen unterschiedlich aus
 >Es ist generell wichtig zu wissen, welche Alternativen es gibt, wenn grˆﬂere Datenmengen verarbeitet werden m¸ssen
#>

using namespace System.IO
using namespace System.Text

# Schritt 1: Eine gro√üe Textdatei anlegen
$TxtPfad = [Path]::GetTempFileName()

$Txt = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
$Limit = 2MB
$Sb = [StringBuilder]::new()
while($Sb.Length -lt $Limit)
{
    [void]$Sb.Append($Txt)
}

# Jetzt in eine Datei speichern
$Sw = [StreamWriter]::new($TxtPfad)
$Sw.Write($Sb)
$Sw.Close()
Write-Verbose ("{0} Bytes wurden in $TxtPfad geschrieben." -f $Sb.Length) -Verbose

# Variante A: Get-Content
$Ts1 = (Measure-Command -Expression {
    [void](Get-Content -Path $TxtPfad)
}).TotalSeconds

# Variante B: StreamReader
$Ts2 = (Measure-Command -Expression {
    $Sr = [StreamReader]::New($TxtPfad)
    [void]($Sr.ReadToEnd())
}).TotalSeconds

Write-Verbose ("Variante A (Get-Content): {0:n2}s" -f $Ts1) -Verbose
Write-Verbose ("Variante B (StreamReader): {0:n2}s" -f $Ts2) -Verbose
