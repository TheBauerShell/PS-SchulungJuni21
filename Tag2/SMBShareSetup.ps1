<#
 .Synopsis
 Einrichten einer SMB-Freigabe
 .Notes
 Wichtig: xSmbShare muss per Install-Module von der PS-Gallery installiert werden
 Ansonsten gibt es eine Fehlermeldung bei Import-DSCResource und xSMBShare
 Außerdem muss cNtfsAccessControl installiert werden
#>

Configuration DSCSmbShare
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xSmbShare
    Import-DscResource -ModuleName cNtfsAccessControl

    Node localhost
    {

        File CreateDSCFolder
        {
            Ensure = "Present"
            DestinationPath = "C:\DscShare"
            Type = "Directory"
        }

        xSMBShare CreateShare
        {
            Ensure = "Present"
            Name = "DscShare"
            Path = "C:\DscShare"
            FullAccess = "PoshAdmin"
            # ReadAccess = "PoshUser"
            FolderEnumerationMode = "AccessBased"
            DependsOn = "[File]CreateDSCFolder"
        }

        cNtfsPermissionEntry PermissionSet1
        {
            Ensure = "Present"
            Path = "C:\DscShare"
            Principal = "PoshAdmin"
            AccessControlInformation = @(
                cNtfsAccessControlInformation
                {
                    AccessControlType = "Allow"
                    FileSystemRights = "ReadAndExecute"
                    Inheritance = "ThisFolderSubfoldersAndFiles"
                    NoPropagateInherit = $False
                }
            )
            DependsOn = "[File]CreateDSCFolder"
        }
    }
}