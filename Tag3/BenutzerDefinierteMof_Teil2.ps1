<#
 .Synopsis
 Verwenden benutzerdefinierter Mof-Klassen - Teil 2
 .Notes
Die in Teil1 erstellte CIM-Kalsse PSDocument wird verwendet
 #>

# Es wird eine Instanz der neuen Klasse gebildet
New-CIMInstance -ClassName PSDocument -Namespace root\MOFTest -Property @{DocumentId=[Uint32]1000;Title="Nur ein Test";IsValid=$true}

# Die Instanz wird abgefragt
Get-CimInstance -ClassName PSDocument -Namespace root\MOFTest 

# Eine Instanz wird wieder entfernt
Remove-CIMInstance -Query "Select * From PSDocument Where DocumentId=1000" -Namespace  root\moftest