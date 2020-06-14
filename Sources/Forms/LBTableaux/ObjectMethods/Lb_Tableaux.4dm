Case of 
		
	: ((Form event code:C388=Sur déplacement colonne:K2:30) | (Form event code:C388=Sur redimensionnement colonne:K2:31))
		
		
	: (Form event code:C388=Sur double clic:K2:5)
		C_LONGINT:C283($C;$L)
		
		LISTBOX GET CELL POSITION:C971(*;ZNomListe;$C;LigneClic)
		GOTO RECORD:C242(ZPtTable->;TbNumEnr{LigneClic})
		If (ZModif)
			MODIFY RECORD:C57(ZPtTable->)  //permet par double-clic de modifier l'enregistrement
		Else 
			GOTO SELECTED RECORD:C245(ZPtTable->;$L)
			DIALOG:C40(ZPtTable->;ZNomForEntrée)  //permet par double-clic de visualiser l'enregistrement
		End if 
End case 