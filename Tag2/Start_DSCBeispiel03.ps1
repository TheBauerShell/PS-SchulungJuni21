<#
 .Synopsis
 Führt die Configuration von DSC-Beispiel Nr. 3 aus
#>

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "DSCBeispiel03.ps1"

.$Ps1Pfad

# Zur Kontrolle - die Configuration CreateProfileSkript ist mitdabei
Get-Command -CommandType Configuration

# Ausführen der Configuration
CreateProfileSkript -Verbose -PSComputername Win10A

# Das Ergebnis ist die Mof-Datei Win10A-Mof

# Übertragen im Push-Modus an den Node Win10A

$Pw = ConvertTo-SecureString -String "demo+1234" -AsPlainText -Force
$Username = "pmhub\Administrator"
$PSCred = [PSCredential]::New($Username, $Pw)

Set-Location -Path $PSScriptRoot

# Sollte ein LCM für den Pull-Modus konfiguriert sein, ist der Force-Parameter für einen Push erforderlich
Start-DscConfiguration -ComputerName Win10A -Credential $PSCred -Path .\CreateProfileSkript -Wait -Verbose -Force