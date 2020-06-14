$evt:=Form event code:C388

Case of 
	: ($evt=Sur chargement:K2:1)
		ASAPFactureSurChargement 
		
		
	: ($evt=Sur validation:K2:3)
		ASAPFactureSurValidation 
		
End case 