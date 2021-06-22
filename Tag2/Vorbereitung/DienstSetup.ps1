<#
 .Synopsis
 Registrieren eines Systemdienstes am Beispiel von PoshService.exeeeee
 .Notes
 Der Dienst wird auf "manuell" starten gesetzt - eine Alternative ist "Automatic"
 Aufruf mit
 .\DienstSetup.ps1 -ServiceName ZitateDienst -DisplayName "Der Posh-Zitatedienst" -Description "Gibt über TCP-Port 17 ein Zitat des Tages zurück" -ExePath .\ZitateDienst.exe
#>

[CmdletBinding()]
param([String]$ServiceName, [String]$DisplayName, [String]$Description, [String]$ExePath, [String]$Username, [String]$Password)

$Params = @{
	Name = $Servicename
	DisplayName = $DisplayName
	Description = $Description
	BinaryPath = $ExePath
	StartupType = "Manual"
}

# Den Systemdienst registrieren
New-Service @params

# Sollen die Konteninformationen aktuelisiert werden
if ($Username -and $Password)
{
	# Das angegebene Benutzerkonto per WMI festlegen
	$service = Get-WmiObject Win32_Service -Filter "Name='$ServiceName'"
	$ret = $service.change($null,$null,$null,$null,$null,$null,$Username,$Password,$null,$null,$null)
	if ($ret.ReturnValue -eq 0)
	{
		Write-Verbose "*** Die Kontoinformation wurde erfolgreich aktualisiert."
	}
	else
	{
		Write-Warning "!!! Die Kontoinformation konnte nicht aktualisiert werden - ReturnValue=$($ret.ReturnValue)"
		exit
	}
}

# Den Dienst einfach einmal starten
Start-Service -Name $ServiceName
if ($?)
{
	Write-Verbose "*** Der Dienst wurde gestartet."
}
else
{
	Write-Warning "!!! Der Dienst konnte nicht gestartet werden $($Error[0])"
}
