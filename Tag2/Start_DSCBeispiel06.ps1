<#
 .Synopsis
 Auswerten von DSC-Log-Meldungen
#>
configuration PoshUser
{
    node localhost
    {
        Log Log1
        {
            Message = "PoshUser-Konfiguration wird umgesetzt."
        }
        user poshUser
        {
            UserName = "Poshuser3"
            FullName = "Peter M"
        }
    
    }
}

# $PwSec = "demo+123" | ConvertTo-SecureString -AsPlainText -Force
# $PSCred = [PSCredential]::new("Administrator", $PwSec)

Start-DscConfiguration -Path .\PoshUser -Wait -Verbose