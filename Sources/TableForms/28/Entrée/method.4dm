$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ALL RECORDS:C47([Personnes:12])
		ALL RECORDS:C47([Factures:15])
		ASAPCourrielsRenseigneChamps 
		
		ASAPCourrielsSurChargement 
		
		
	: ($evt=Sur validation:K2:3)
		ASAPCourrielsSurValidation 
		
End case 
