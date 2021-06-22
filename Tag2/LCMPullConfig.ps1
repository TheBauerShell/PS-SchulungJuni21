<#
 .Synopsis
 Setzt einen LCM auf Push-Modus
#>

[DSCLocalConfigurationManager()]
configuration LCMPushSetup
{
    param([String]$Computername)
    node $Computername
    {
        Settings
        {
            RefreshMode = "Push"
        }
    }
}

LCMPushSetup -Computername Win10B 

$Pw = ConvertTo-SecureString -String "demo+1234" -AsPlainText -Force
$Username = "pmhub\Administrator"
$PSCred = [PSCredential]::New($Username, $Pw)

Set-DscLocalConfigurationManager -Path .\LCMPushSetup -Verbose -ComputerName Win10B -Credential $PSCred
