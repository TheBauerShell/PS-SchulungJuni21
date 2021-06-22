<#
 .Synopsis
 F�hrt die Configuration von DSC-Beispiel Nr. 1 aus
#>

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "DSCBeispiel01.ps1"

.$Ps1Pfad

Set-Location -Path $PSScriptRoot

# Zur Kontrolle - die Configuration CreateProfileDir ist mit dabei
Get-Command -CommandType Configuration

# Ausf�hren der Configuration
CreateProfileDir -Verbose

# Das Ergebnis ist die Mof-Datei Win10A-Mof

# �bertragen im Push-Modus an den Node Win10A

# $Pw = ConvertTo-SecureString -String "demo+12345678" -AsPlainText -Force
# $Username = "poshadmin"
# $PSCred = [PSCredential]::New($Username, $Pw)

# Alternativ, wenn zuvor das Skript SacePsCredentials.ps1 einmal ausgef�hrt wurde
$XmlPfad = join-Path -Path $PSScriptRoot -ChildPath "PoshadminCreds.xml"
$PSCred = Import-CliXml -Path $XmlPfad

# Sollte ein LCM f�r den Pull-Modus konfiguriert sein, ist der Force-Parameter f�r einen Push erforderlich
Start-DscConfiguration -ComputerName Win10A -Credential $PSCred -Path .\CreateProfileDir -Wait -Verbose -Force