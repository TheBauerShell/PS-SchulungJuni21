<#
 .Synopsis
 Bereitstellen der xPSProfileResource-Ressource für Pull-Server
#>

$DSCModulesPfad = "C:\Program Files\WindowsPowerShell\DSCService\Modules"
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

$DestPfad = Join-Path -Path $DSCModulesPfad -ChildPath $ModuleName

if (!(Test-Path -Path $DestPfad))
{
    mkdir $DestPfad | Out-Null
}

$ZipPfad = Join-Path -Path $DestPfad -ChildPath "$($ModuleName)_$($ModuleVersion).zip"

Compress-Archive -Path $TmpPfad\* -DestinationPath $ZipPfad -Force

New-DSCChecksum -Path $DestPfad -Force -Verbose