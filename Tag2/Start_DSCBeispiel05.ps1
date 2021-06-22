<#
 .Synopsis
 F�hrt die Configuration von DSC-Beispiel Nr. 4 aus - dieses Mal f�r mehrere Nodes �ber die Konfigurationsdaten
#>

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "DSCBeispiel04.ps1"

.$Ps1Pfad

$ConfigData = @{

    AllNodes = @(
        @{
            NodeName = "Win10A"
            PS1Content = "Alles klar mit Configdaten f�r Win10A"
        },
        @{
            NodeName = "Win10B"
            PS1Content = "Alles klar mit Configdaten f�r Win10B"
        }
    )
}

# Ausf�hren der Configuration
CreateProfileSkript -Verbose -ConfigurationData $ConfigData

# �bertragen im Push-Modus an den Node Win10A

$Pw = ConvertTo-SecureString -String "demo+1234" -AsPlainText -Force
$Username = "pmhub\Administrator"
$PSCred = [PSCredential]::New($Username, $Pw)

Set-Location -Path $PSScriptRoot

# Sollte ein LCM f�r den Pull-Modus konfiguriert sein, ist der Force-Parameter f�r einen Push erforderlich
Start-DscConfiguration -ComputerName Win10A, Win10B -Credential $PSCred -Path .\CreateProfileSkript -Wait -Verbose -Force