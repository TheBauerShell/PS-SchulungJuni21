<#
 .Synopsis
 F�hrt die Configuration von DSC-Beispiel Nr. 3 aus
#>

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "DSCBeispiel03.ps1"

.$Ps1Pfad

Set-Location -Path $PSScriptRoot

# Zur Kontrolle - die Configuration CreateProfileSkript ist mitdabei
Get-Command -CommandType Configuration

# Ausf�hren der Configuration
CreateProfileSkript -Verbose -PSComputername Win10A

# Das Ergebnis ist die Mof-Datei Win10A-Mof

# �bertragen im Push-Modus an den Node Win10A

$Pw = ConvertTo-SecureString -String "demo+12345678" -AsPlainText -Force
$Username = "poshadmin"
$PSCred = [PSCredential]::New($Username, $Pw)

# Sollte ein LCM f�r den Pull-Modus konfiguriert sein, ist der Force-Parameter f�r einen Push erforderlich
Start-DscConfiguration -ComputerName Win10A -Credential $PSCred -Path .\CreateProfileSkript -Wait -Verbose -Force