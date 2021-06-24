<#
 .Synopsis
 Anwenden der cPs1ProfileRessource
#>

configuration CreatePs1Profile
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName cPs1Profile -ModuleVersion 0.0.0.1

    node localhost
    {
        xPSProfileResource Test
        {
            Ensure = "Present"
            ProfileType = "CurrentUserAllHosts"
            Username = "poshadmin"
            Hostname = "test1234"
            ErrorBackgroundColor = "yellow"
        }
    }

}


# Anlegen der Mof-Datei
CreatePs1Profile

# Anwenden der Mof-Datei

Start-DscConfiguration -Path .\CreatePs1Profile -Verbose -Wait -Force