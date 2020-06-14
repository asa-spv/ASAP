$evt:=Form event code:C388
If ($evt=Sur chargement:K2:1)
	$FT:=Records in selection:C76([Personnes:12])
	  //TABLEAU TEXTE(TbNomLaboratoire;$FT)
	  //TABLEAU TEXTE(TbPoidsColis;$FT)
	  //TABLEAU TEXTE(TbDimensionColis;$FT)
	  //SÉLECTION VERS TABLEAU([Personnes]NomLong;TbNomLaboratoire)
End if 