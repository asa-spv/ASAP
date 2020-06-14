If (TbPerNum=1)
	ALERT:C41("Désolé, je suis DEJA sur le premier laboratoire...")
Else 
	ZGereClicBoutonNavigationSaisie ("BouPrem")
	LISTBOX SELECT ROW:C912(*;"ListBoxNumLabo";1)
	OBJECT SET SCROLL POSITION:C906(*;"ListBoxNumLabo";TbPerNum)
	VarNumLabo:=TbPerNum{TbPerNum}
End if 