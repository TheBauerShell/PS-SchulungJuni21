<#
 .Synopsis
 Tests für die cPs1Profile-Ressource
 .Notes
 Tipp: Aufruf von Invoke-Pester mit dem Passthru-Parameter
 Wichtig: Eine Psm1-Datei mit Klassendefinitionen kann nur per using module geladen werdens
#>

#requires -modules @{modulename="Pester";moduleversion="5.2.2"}
using module "C:\Program Files\WindowsPowerShell\Modules\cPs1Profile\0.0.0.1\cPs1Profile.psm1"

describe "a basic test of the cPs1Profile ressource" {

    # $Psm1Pfad = "C:\Program Files\WindowsPowerShell\Modules\cPs1Profile\0.0.0.1\cPs1Profile.psm1"
    # Import-Module -Name $Psm1Pfad

    it "tests not existing profile file" -Skip  {
        $resource = [xPSProfileResource]::new()
        $resource.username = "pemo"
        $resource.hostname = "test1234"
        $resource.profileType = "CurrentUserAllHost"
        $resource.test() | Should -be $false
    }

    it "tests existing user profile file" -Skip  {
        $resource = [xPSProfileResource]::new()
        $resource.username = "Poshadmin"
        $resource.profileType = "CurrentUserAllHost"
        New-Item -Path "C:\Users\Poshadmin\Documents\WindowsPowershell\Profile.ps1" -itemtype File -ErrorAction Ignore
        $resource.test() | Should -be $true
    }

    it "tests existing host profile file" -Skip  {
        $resource = [xPSProfileResource]::new()
        $resource.hostname = "test1234"
        #$resource.username = "poshadmin"
        $resource.profileType = "CurrentUserCurrentHost"
        New-Item -Path "C:\Users\Poshadmin\Documents\WindowsPowershell\test1234_Profile.ps1" -itemtype File -ErrorAction Ignore
        $resource.test() | Should -be $true
    }

    it "tests creating a profile script" {
        $resource = [xPSProfileResource]::new()
        $resource.hostname = "test1234"
        $resource.username = "poshadmin"
        $resource.profileType = "CurrentUserCurrentHost"
        $resource.set()
        Test-Path -Path "C:\Users\Poshadmin\Documents\WindowsPowershell\test1234_Profile.ps1" | Should -BeTrue

    }

}