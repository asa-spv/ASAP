
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ZLBUtilSurChargement 
		
	: ($evt=Sur clic:K2:4)
		[XUtilisateurs:2]Initiales:4:=[XUtilisateurs:2]Initiales:4
		
		
	: ($evt=Sur validation:K2:3)
		ZLBUtilSurValidation 
		
	: ($evt=Sur libération:K2:2)
		CLEAR VARIABLE:C89(PUMUtilAdresses)
		ZAmnistiePartielle (->[XLocalisations:8])
		
End case 
