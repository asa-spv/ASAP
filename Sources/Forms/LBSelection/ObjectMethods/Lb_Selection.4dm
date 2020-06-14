$evt:=Form event code:C388
Case of 
	: ($evt=Sur double clic:K2:5)
		If (ZModif)
			MODIFY RECORD:C57(ZPtTable->)  //permet par double-clic de modifier l'enregistrement
		Else 
			C_LONGINT:C283($C;$L)
			LISTBOX GET CELL POSITION:C971(*;"Lb_Balance";$C;$L)
			GOTO SELECTED RECORD:C245(ZPtTable->;$L)
			DIALOG:C40(ZPtTable->;ZNomForEntrée)  //permet par double-clic de visualiser l'enregistrement
		End if 
		
End case 