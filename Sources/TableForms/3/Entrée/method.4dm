
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ZLBFonctionSurChargement 
		
	: ($evt=Sur données modifiées:K2:15)
		[XFonctions:3]UUID:1:=[XFonctions:3]UUID:1
		
	: ($evt=Sur libération:K2:2)
		ZLBFonctionSurValidation 
		
End case 
