<#
 .Synopsis
 Eigene DSC-Ressource für das Anlegen eines Profilskripts
#>

enum ProfileType
{
    CurrentUserAllHosts
    CurrentUserCurrentHost
    AllUsersAllHosts
    AllUsersCurrentHost
}

enum Ensure
{
    Present
    Absent
}

[DSCResource()]
class xPSProfileResource
{
    [DSCProperty(Key)]
    [ProfileType]$ProfileType

    [DSCProperty()]
    [String]$Username

    [DSCProperty()]
    [String]$Hostname

    [DSCProperty(Mandatory)]
    [String]$ErrorBackgroundColor

    [DSCProperty()]
    [Ensure]$Ensure

    # ========================================
    # Test
    # ========================================
    [bool]Test()
    {
        $Result = $False
        switch($this.ProfileType)
        {
            CurrentUserAllHosts { $Result = Test-Path -Path "C:\Users\$($this.Username)\Documents\WindowsPowershell\Profile.ps1" }
            CurrentUserCurrentHost { $Result = Test-Path -Path "C:\Users\$($this.Username)\Documents\WindowsPowershell\$($this.Hostname)_Profile.ps1" }
        }
        Return $Result
    }

    # ========================================
    # Get
    # ========================================
    [xPSProfileResource]Get()
    {
        $Result = $Null
        if ($this.Ensure -eq "Present")
        {
            switch($this.ProfileType)
            {
                CurrentUserAllHosts { if (Test-Path -Path "C:\Users\$($this.Username)\Documents\WindowsPowershell\Profile.ps1") {$Result = $this} }
                CurrentUserCurrentHost { if (Test-Path -Path "C:\Users\$($this.Username)\Documents\WindowsPowershell\$($this.hostname)_Profile.ps1") {$Result = $this} }
            }

        }
        return $Result

    }

    # ========================================
    # Set
    # ========================================
    [void]Set()
    {
        switch($this.ProfileType)
        {
            CurrentUserAllHosts { 
                Add-Content -Path "C:\Users\$($this.Username)\Documents\WindowsPowershell\Profile.ps1" -Value ("`$Host.PrivateData.ErrorBackgroundColor = " + "`"White`"")
            }
            CurrentUserCurrentHost {
                Add-Content -Path "C:\Users\$($this.Username)\Documents\WindowsPowershell\$($this.hostname)_Profile.ps1" -Value ("`$Host.PrivateData.ErrorBackgroundColor = " + "`"White`"")
            }
        }
    }

}
