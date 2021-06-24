<#
 .Synopsis
 Bereitstellen der xPSProfileResource-Ressource für Pull-Server
#>

$DSCModulesPfad = "C:\Program Files\WindowsPowerShell\Modules"
$DSCServicePfad = "C:\Program Files\WindowsPowerShell\DSCService\Modules"
$ModuleVersion = "0.0.0.1"
$ResourcePfad = Join-Path -Path $PSScriptRoot -ChildPath "xPS1ProfileResource"
$Psm1Pfad = Join-Path -Path $ResourcePfad -ChildPath "cPs1Profile.psm1"
$ModuleName =  [System.IO.Path]::GetFileNameWithoutExtension($Psm1Pfad)

$TmpPfad = Join-Path -Path $env:Temp -ChildPath $ModuleName
if (!(Test-Path -Path $TmpPfad))
{
    mkdir $TmpPfad | Out-Null
}

Copy-Item -Path $ResourcePfad\* -Destination $TmpPfad -Verbose -Force

# Module-Verzeichnis anlegen
$ModulePfad = Join-Path -Path $DSCModulesPfad -ChildPath $ModuleName
$ModulePfad = Join-Path -Path $ModulePfad -ChildPath $ModuleVersion

if (!(Test-Path -Path $ModulePfad))
{
    mkdir $ModulePfad | Out-Null
}

Copy-Item -Path $ResourcePfad\* -Destination $ModulePfad -Verbose -Force

$DestDSCPfad = Join-Path -Path $DSCServicePfad -ChildPath $ModuleName

if (!(Test-Path -Path $DestDSCPfad))
{
    mkdir $DestDSCPfad | Out-Null
}

$ZipPfad = Join-Path -Path $DestDSCPfad -ChildPath "$($ModuleName)_$($ModuleVersion).zip"

Compress-Archive -Path $TmpPfad\* -DestinationPath $ZipPfad -Force

New-DSCChecksum -Path $DestDSCPfad -Force -Verbose