<#
 .Synopsis
 Führt die Configuration von DSC-Beispiel Nr. 4 aus - dieses Mal für mehrere Nodes über die Konfigurationsdaten
#>

$Ps1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "DSCBeispiel04.ps1"

.$Ps1Pfad

$ConfigData = @{

    AllNodes = @(
        @{
            NodeName = "Win10A"
            PS1Content = "Alles klar mit Configdaten für Win10A"
        },
        @{
            NodeName = "Win10B"
            PS1Content = "Alles klar mit Configdaten für Win10B"
        }
    )
}

# Ausführen der Configuration
CreateProfileSkript -Verbose -ConfigurationData $ConfigData

# Übertragen im Push-Modus an den Node Win10A

$Pw = ConvertTo-SecureString -String "demo+1234" -AsPlainText -Force
$Username = "pmhub\Administrator"
$PSCred = [PSCredential]::New($Username, $Pw)

Set-Location -Path $PSScriptRoot

# Sollte ein LCM für den Pull-Modus konfiguriert sein, ist der Force-Parameter für einen Push erforderlich
Start-DscConfiguration -ComputerName Win10A, Win10B -Credential $PSCred -Path .\CreateProfileSkript -Wait -Verbose -Force