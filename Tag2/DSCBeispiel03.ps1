<#
 .Synopsis
 DSC-Beispiel Nr. 3 - Node-Name wird als Parameter übergeben
#>

Configuration CreateProfileSkript
{
    param([String]$PSComputername)
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    node $PSComputername
    {
        File ProfileDir
        {
          Ensure = "Present"
          DestinationPath = "C:\Users\Administrator\Documents\WindowsPowerShell\ProfileNeu"
          Type = "Directory"
        }
        File ProfileSkript
        {
          Ensure = "Present"
          DestinationPath = "C:\Users\Administrator\Documents\WindowsPowerShell\ProfileNeu\Profile.ps1"
          Type = "File"
          Contents = "# Angelegt per DSC (Teil 2)"
          DependsOn = "[File]ProfileDir"
        }

    }
}