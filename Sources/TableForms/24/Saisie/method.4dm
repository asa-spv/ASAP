
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ASAPRetourSurChargement 
		
		
		
	: ($evt=Sur validation:K2:3)
		ASAPRetourSurValidation 
		
	: (BouAnnuleFiche=1) | ($evt=Sur libération:K2:2)  // clic sur le bouton "Sans Changement)
		CANCEL TRANSACTION:C241
		
		
End case 

[RetoursFiches:24]UUID:1:=[RetoursFiches:24]UUID:1