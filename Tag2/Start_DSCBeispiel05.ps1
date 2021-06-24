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
            Username = "poshadminx"
            PS1Content = "Alles klar mit Configdaten für Win10A"
        },
        @{
            NodeName = "Win10B"
            Username = "poshadmin"
            PS1Content = "Alles klar mit Configdaten für Win10B"
        }
    )
}

# Ausführen der Configuration
CreateProfileSkript -Verbose -ConfigurationData $ConfigData

# Übertragen im Push-Modus an den Node Win10A

$XmlPfad = join-Path -Path $PSScriptRoot -ChildPath "PoshadminCreds.xml"
$PSCred = Import-CliXml -Path $XmlPfad

Set-Location -Path $PSScriptRoot

# Sollte ein LCM für den Pull-Modus konfiguriert sein, ist der Force-Parameter für einen Push erforderlich
Start-DscConfiguration -ComputerName Win10A, Win10B -Credential $PSCred -Path .\CreateProfileSkript -Wait -Verbose -Force