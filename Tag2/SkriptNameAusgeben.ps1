<#
 .Synopsis
 Abfrage des Skriptnamens
#>

[CmdletBinding()]
param()

"Das Skript hei�t: $(Split-Path $PSCmdlet.MyInvocation.InvocationName -leaf)"
# "Das Skript hei�t: $(Split-Path $MyInvocation.InvocationName -leaf)"
