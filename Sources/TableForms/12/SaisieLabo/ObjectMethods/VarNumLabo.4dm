
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		$L:=Find in array:C230(TbPerNum;VarNumLabo)
		If ($L<0)
			ALERT:C41("Désolé, le laboratoire "+String:C10(VarNumLabo)+" n'est pas présent dans la liste")
			VarNumLabo:=TbPerNum{TbPerNum}
		Else 
			TbPerNum:=$L
			ZGereClicBoutonNavigationSaisie ("BouPrec";->TbPerNum)
			OBJECT SET SCROLL POSITION:C906(*;"ListBoxNumLabo";TbPerNum)
			
		End if 
		
End case 
