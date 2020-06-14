Case of 
		
	: ((Form event code:C388=Sur déplacement colonne:K2:30) | (Form event code:C388=Sur redimensionnement colonne:K2:31))
		
	: (Form event code:C388=Sur après tri:K2:28)
		C_LONGINT:C283($T;$C)
		$Obj:=OBJECT Get pointer:C1124(Objet courant:K67:2)
		RESOLVE POINTER:C394($Obj;$NomVar;$T;$C)
		If ($NomVar="Entête10")
			SORT ARRAY:C229(TbNumLaboN;TbNumLaboA;TbNomLabo;TbNumCampagne;TbTransporteur;TbProforma;TbNbColisSR;TbNbColisAR;TbSansPatho;TbNumEnr;>)
		End if 
		
	: (Form event code:C388=Sur double clic:K2:5)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(*;ZNomListe;$C;LigneClic)
		
		GOTO RECORD:C242(ZPtTable->;TbNumEnr{LigneClic})
		If (LigneClic=0)
			ALERT:C41("Merci de double-cliquer sur une ligne")
		Else 
			If (ZModif)
				MODIFY RECORD:C57(ZPtTable->)  //permet par double-clic de modifier l'enregistrement
			Else 
				GOTO SELECTED RECORD:C245(ZPtTable->;$L)
				DIALOG:C40(ZPtTable->;ZNomForEntrée)  //permet par double-clic de visualiser l'enregistrement
			End if 
		End if 
End case 
