If (TbPerNum=1)
	ALERT:C41("Désolé, je ne peux remonter dans la liste car je suis sur le premier laboratoire...")
Else 
	ZGereClicBoutonNavigationSaisie ("BouPrec")
	LISTBOX SELECT ROW:C912(*;"ListBoxNumLabo";TbPerNum-1)
	OBJECT SET SCROLL POSITION:C906(*;"ListBoxNumLabo";TbPerNum-1)
	VarNumLabo:=TbPerNum{TbPerNum}
End if 