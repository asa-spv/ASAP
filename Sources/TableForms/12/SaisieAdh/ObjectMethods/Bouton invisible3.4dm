If (TbPerNum=Size of array:C274(TbPerNum))
	ALERT:C41("Désolé, je suis DEJA sur le dernier laboratoire...")
Else 
	ZGereClicBoutonNavigationSaisie ("BouDernier")
	LISTBOX SELECT ROW:C912(*;"ListBoxNumLabo";Size of array:C274(TbPerNum))
	OBJECT SET SCROLL POSITION:C906(*;"ListBoxNumLabo";TbPerNum)
	VarNumLabo:=TbPerNum{TbPerNum}
End if 