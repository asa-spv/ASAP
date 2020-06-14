[PersonnesAdresses:11]Pays:8:=YSaisieAssiste (-><>TbNomPays;1;False:C215)
$L:=Find in array:C230(<>TbNomPays;[PersonnesAdresses:11]Pays:8)
If ($L>0)
	VarCodePays:=<>TbCodeIsoASA{$L}
Else 
	VarCodePays:=""
End if 