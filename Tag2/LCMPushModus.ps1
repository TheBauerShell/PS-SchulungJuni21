<#
 .Synopsis
 Setzt einen LCM auf Pull-Modus mit SMB-Share
#>

[DSCLocalConfigurationManager()]
configuration LCMPushSetup
{
    Node $AllNodes.NodeName
    {
        Settings
        {
            RefreshMode = "Push"
        }

    }
}


LCMPushSetup

Set-DscLocalConfigurationManager -Path .\LCMPushSetup  -Verbose
