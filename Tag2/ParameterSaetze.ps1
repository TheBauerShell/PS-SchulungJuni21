<#
 .Synopsis
 Skript mit mehreren Parameters�tzen
#>

[CmdletBinding(DefaultParameterSetName="")]
param([Parameter(ParameterSetName="Ps1")]$P1,
      [Parameter(ParameterSetName="Ps1")]$P11,
      [Parameter(ParameterSetName="Ps2")]$P2,
      [String]$Pfad,
      [Switch]$HtmlOutput)