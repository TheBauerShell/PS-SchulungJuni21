<#
 .Synopsis
 DSC-Beispiel Nr. 2 - Anlegen eines WindowsPowerShell-Verzeichnisses und einer Ps1-Datei
#>

Configuration CreateProfileSkript
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    node Win10A 
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
          Contents = "# Angelegt per DSC"
          DependsOn = "[File]ProfileDir"
        }

    }
}