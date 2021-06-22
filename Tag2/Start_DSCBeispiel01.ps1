<#
 .Synopsis
 F�hrt die Configuration von DSC-Beispiel Nr. 1 aus
#>

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "DSCBeispiel01.ps1"

.$Ps1Pfad

# Zur Kontrolle - die Configuration CreateProfileDir ist mit dabei
Get-Command -CommandType Configuration

# Ausf�hren der Configuration
CreateProfileDir -Verbose

# Das Ergebnis ist die Mof-Datei Win10A-Mof

# �bertragen im Push-Modus an den Node Win10A

$Pw = ConvertTo-SecureString -String "demo+1234" -AsPlainText -Force
$Username = "pmhub\Administrator"
$PSCred = [PSCredential]::New($Username, $Pw)

Set-Location -Path $PSScriptRoot

# Sollte ein LCM f�r den Pull-Modus konfiguriert sein, ist der Force-Parameter f�r einen Push erforderlich
Start-DscConfiguration -ComputerName Win10A -Credential $PSCred -Path .\CreateProfileDir -Wait -Verbose -Force