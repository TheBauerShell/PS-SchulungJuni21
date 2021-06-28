<#
 .Synopis
 Konfigurationsdaten zuordnen
 #>

 configuration PsProfileSetup
 {

        Import-DscResource -ModuleName PSDesiredStateConfiguration

        node ($AllNodes.Where{$_.Gruppe -eq "GruppeA"}).NodeName
        {
            File Ps1Profile
            {
                DestinationPath = "C:\Users\Administrator\Documents\WindowsPowerShell"
            }
        }


 }

 $Psd1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "DSCConfigDaten.psd1"
 $ConfigDaten = Import-PowerShellDataFile $Psd1Pfad

<#
 $ConfigDaten = @{

     AllNodes = @(

         @{
             NodeName = "Win10A"
             Gruppe="GruppeA"
         },
         @{
             NodeName = "Win10B"
             Gruppe="GruppeB"
         },
         @{
             NodeName = "Win10C"
             Gruppe="GruppeA"
         }

     )
 }
 #>

 PsProfileSetup -ConfigurationData $ConfigDaten

