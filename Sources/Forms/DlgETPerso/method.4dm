$evt:=Form event code:C388

Case of 
		
	: ($evt=Sur chargement:K2:1)
		
		C_LONGINT:C283($Salé;$FT)
		
		
		  // Page 1 des tables sensibles
		ARRAY LONGINT:C221(TbNumTable;0)
		ARRAY BOOLEAN:C223(TbSensible;0)
		QUERY:C277([XData:1];[XData:1]XType:3="Tables sensibles")
		C_OBJECT:C1216($Ob)
		$ob:=OB Copy:C1225([XData:1]XObjet:18)
		OB GET ARRAY:C1229($Ob;"Sensible";TbSensible)
		OB GET ARRAY:C1229($Ob;"NumTable";TbNumTable)
		
		  //ZBlobVersVariable (->[XData]XBlob;->TbSensible;->TbNumTable)
		$FT:=Size of array:C274(TbSensible)
		ARRAY TEXT:C222(TbNomTable;$FT)
		ARRAY LONGINT:C221($TbLigneADetruire;0)
		For ($Salé;1;$FT)
			If (Is table number valid:C999(TbNumTable{$Salé}))
				TbNomTable{$Salé}:=Table name:C256(TbNumTable{$Salé})
			Else 
				APPEND TO ARRAY:C911($TbLigneADetruire;$Salé)
			End if 
		End for 
		$TT:=Size of array:C274($TbLigneADetruire)
		If ($TT>0)
			For ($Sec;1;$TT)
				$Rang:=$TT-$Sec+1
				DELETE FROM ARRAY:C228(TbSensible;$TbLigneADetruire{$Rang})
				DELETE FROM ARRAY:C228(TbNumTable;$TbLigneADetruire{$Rang})
			End for 
			ZVerrouAttendre (->[XData:1])
			OB SET ARRAY:C1227($Ob;"Sensible";TbSensible)
			OB SET ARRAY:C1227($Ob;"NumTable";TbNumTable)
			[XData:1]XObjet:18:=OB Copy:C1225($Ob)
			SAVE RECORD:C53([XData:1])
			ZAmnistiePartielle (->[XData:1])
		End if 
		  // gestion des éventuelles modifications
		  // conservons l'état premier
		ARRAY BOOLEAN:C223(AncTbSensible;0)
		ARRAY LONGINT:C221(AncTbNumTable;0)
		COPY ARRAY:C226(TbSensible;AncTbSensible)
		COPY ARRAY:C226(TbNumTable;AncTbNumTable)
		
		ModificationTS:=False:C215  // Permet de savoir si on a modifié les tables sensibles
		
		
		  // page 2 des ET de colonnes des listes
		C_OBJECT:C1216(ObjetET;AncObjetET)
		QUERY:C277([XData:1];[XData:1]XType:3="NomChampAfficheLB";*)
		QUERY:C277([XData:1]; & [XData:1]XNom:2="Nom des ET des ListBox pour "+<>ZQuiCode;*)
		QUERY:C277([XData:1]; & [XData:1]XAlpha:8=<>ZQuiCode)
		ObjetET:=OB Copy:C1225([XData:1]XObjet:18)
		AncObjetET:=OB Copy:C1225(ObjetET)
		TbNomTable:=1
		$L:=Find in array:C230(<>TbNomTableBase;TbNomTable{TbNomTable})
		$Propriété:="ET"+String:C10(<>TbNumTableBase{$L})
		OB GET ARRAY:C1229(ObjetET;$Propriété;TbNomAffiche)
		
		$Propriété:="NC"+String:C10(<>TbNumTableBase{$L})
		OB GET ARRAY:C1229(ObjetET;$Propriété;TbNomStructure)
		
		$TT:=Size of array:C274(TbNomAffiche)
		ARRAY LONGINT:C221(TbNumChampAffiche;$TT)
		For ($Salé;1;$TT)
			$L:=Find in array:C230(<>TbNomChampBase;TbNomStructure{$Salé})
			TbNumChampAffiche{$Salé}:=<>TbNumChampBase{$l}
		End for 
		
		
		
End case 