<#
 .Synopsis
 Setzt einen LCM auf Pull-Modus mit SMB-Share
#>

[DSCLocalConfigurationManager()]
configuration LCMPullSetup
{
    Node $AllNodes.NodeName
    {
        Settings
        {
            RefreshMode = "Pull"
            RefreshFrequencyMins = 30
            ConfigurationID  = "16db7357-9083-4806-a80c-ebbaf4acd6c1"
            ConfigurationMode = "Apply"
        }

        ConfigurationRepositoryShare SmbConfigShare
        {
            SourcePath = "\\Server1\DscShare"
            Credential = $Node.Creds
        }

        ResourceRepositoryShare SmbResourceShare
        {
            SourcePath = "\\Server1\DscShare"
            Credential = $Node.Creds
        }
    }
}


$Pw = ConvertTo-SecureString -String "demo+12345678" -AsPlainText -Force
$Username = "poshadmin"
$PSCred = [PSCredential]::New($Username, $Pw)

$ConfigData = @{
    AllNodes = @(
        @{
            NodeName="Win10A"
            PSDscAllowPlainTextPassword = $True
            Creds = $PSCred
        },
        @{
            NodeName="Win10B"
            PSDscAllowPlainTextPassword = $True
            Creds = $PSCred
        })

}
LCMPullSetup -ConfigurationData $ConfigData

Set-DscLocalConfigurationManager -Path .\LCMPullsSetup -Computername Win10A, Win10B -Credential $PSCred -Verbose
