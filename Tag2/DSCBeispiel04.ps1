<#
 .Synopsis
 DSC-Beispiel Nr. 4 - Node-Name stammt aus den Konfigurationsdaten
#>

Configuration CreateProfileSkript
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    node $AllNodes.NodeName
    {
      
        File ProfileDir
        {
          Ensure = "Present"
          DestinationPath = "C:\Users\$($Node.Username)\Documents\WindowsPowerShell\ProfileNeu"
          Type = "Directory"
        }
        File ProfileSkript
        {
          Ensure = "Present"
          DestinationPath = "C:\Users\$($Node.Username)\Documents\WindowsPowerShell\ProfileNeu\Profile.ps1"
          Type = "File"
          Contents = $Node.Ps1Content
          DependsOn = "[File]ProfileDir"
        }

    }
}

