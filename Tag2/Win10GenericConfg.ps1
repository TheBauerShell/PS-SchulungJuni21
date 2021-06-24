<#
 .Synopsis
 Anlegen einer allgemeinen generischen Win10-Konfiguration
#>

Configuration Win10Generic
{
    Node localhost
    {
        File PoshDir
        {
            Ensure="Present"
            DestinationPath="C:\Users\Public\Documents\WindowsPowerShell\Profile.ps1"
            Type="File"
            Contents = "DSC was here..."
            Force = $true
        }
    }
}


Win10Generic