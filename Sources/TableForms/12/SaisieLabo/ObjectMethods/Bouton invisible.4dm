If (TbPerNum=Size of array:C274(TbPerNum))
	ALERT:C41("Désolé, je ne peux descendre dans la liste car je suis sur le dernier laboratoire...")
Else 
	ZGereClicBoutonNavigationSaisie ("BouSuiv")
	LISTBOX SELECT ROW:C912(*;"ListBoxNumLabo";TbPerNum+1)
	OBJECT SET SCROLL POSITION:C906(*;"ListBoxNumLabo";TbPerNum+1)
	VarNumLabo:=TbPerNum{TbPerNum}
End if 