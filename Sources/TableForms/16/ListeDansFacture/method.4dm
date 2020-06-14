$Evt:=Form event code:C388
Case of 
	: ($Evt=Sur impression corps:K2:18)
		OBJECT SET FORMAT:C236([Ventes:16]PrixUHT:5;"### ### ##0.00 €")
End case 
