<#
 .Synopsis
 Removing a user account as an example for removing something with DSC
#>

configuration RemoveLocalUser
{
    param([String]$Computername = "localhost")

    Import-DSCResource -ModuleName PSDesiredStateConfiguration

    Node $Computername
    {
        user user1
        {
            Ensure = "Absent"
            Username = "Poshuser"
        }
    }
}

RemoveLocalUser

Start-DscConfiguration -Path .\RemoveLocaluser -Verbose -Wait