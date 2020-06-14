
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		C_LONGINT:C283($Salé;$FT)
		  // Fabrication des tableaux des LB tuables
		SELECTION TO ARRAY:C260([XData:1]XDate:4;TbDateListe\
			;[XData:1]XEntier:6;TbNbListe\
			;[XData:1]XAlpha:8;TbNomListe)
		LONGINT ARRAY FROM SELECTION:C647([XData:1];TbNumEnrListe)
		LISTBOX SELECT ROW:C912(*;"ListBoxListes";0;lk supprimer de sélection:K53:3)
		
		
End case 
