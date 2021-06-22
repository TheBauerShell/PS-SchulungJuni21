<#
 .Synopsis
 Entfernen eines Systemdienstes
#>

[CmdletBinding()]
param([String]$ServiceName)

$ReturnCodes = @{
    9  = "Die Exe-Dienstdatei exitistiert offenbar nicht"
	16 = "Der Dienst wird bereits entfernt"
}

if ($ServiceName -eq "")
{
	Write-Warning "!!! Falscher Aufruf - richtig z.B. .\DienstEntfernen.ps1 VISEFService !!!"
	exit(-1)
}

# Gibt es denn Dienst überhaupt?
if ($null -eq (Get-Service $ServiceName -ErrorAction Ignore))
{
	Write-Warning "!!! Den Dienst $ServiceName gibt es nicht - er kann daher auch nicht entfernt werden"
	exit(-2)

}

# Den Dienst anhalten
Stop-Service $ServiceName -ErrorAction Ignore -Verbose

$Ret = (Get-WmiObject -Class Win32_Service -Filter "Name='$ServiceName'").Delete()
if ($Ret.ReturnValue -eq 0)
{
	Write-Verbose "*** Der Dienst wurde erfolgreich entfernt."
}
else
{
	$ReturnReason = "Unbekannt"
	if ($ReturnCodes.ContainsKey([Int]$Ret.ReturnValue))
	{
		$ReturnReason = $ReturnCodes[[Int]$Ret.ReturnValue]
	}
	 Write-Warning "!!! Der Dienst konnte nicht entfernt werden - ReturnValue=$($Ret.ReturnValue) - $ReturnReason"
}