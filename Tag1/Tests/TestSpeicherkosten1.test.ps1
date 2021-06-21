<#
 .Synopsis
 Pester-Test für das Modul Speicherkosten.psm1
#>

#Requires -Module Pester

Describe "Speicherkostentests" {
    $Psm1Pfad = Join-Path -Path $PSScriptRoot -ChildPath ..\Speicherkosten.psm1
    Import-Module -Name $Psm1Pfad -Force -DisableNameChecking

    BeforeEach  {
        New-Item -Path Kostentest -ItemType Directory
        fsutil.exe file createnew Kostentest\Datei.dat 1048576
    }

    AfterEach {
        Remove-Item Kostentest -Recurse -Force
    }

    it "Returns Kosten bei Faktor 1" {
        $Kosten = Get-Speicherkosten -Pfad Kostentest -Faktor 1
        $Kosten.KostenMB | Should be 1
    }

    it "Returns Kosten bei Faktor 2" {
        $Kosten = Get-Speicherkosten -Pfad Kostentest -Faktor 2
        $Kosten.KostenMB | Should be 2
    }
}
