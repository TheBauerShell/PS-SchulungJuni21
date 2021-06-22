<#
 .Synopsis
 DSC-Beispiel Nr1 - Anlegen eines WindowsPowerShell-Verzeichnisses
#>

Configuration CreateProfileDir
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
    }
}