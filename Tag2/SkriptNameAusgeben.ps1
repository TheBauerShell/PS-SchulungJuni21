<#
 .Synopsis
 Abfrage des Skriptnamens
#>

[CmdletBinding()]
param()

"Das Skript heiﬂt: $(Split-Path $PSCmdlet.MyInvocation.InvocationName -leaf)"
# "Das Skript heiﬂt: $(Split-Path $MyInvocation.InvocationName -leaf)"
