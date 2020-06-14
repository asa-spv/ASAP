
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		ASAPSurValidationSaisieAdh 
		SAVE RECORD:C53([Personnes:12])
		GOTO RECORD:C242([Personnes:12];TbNumEnr{TbPerNom})
		ASAPSurChargementSaisieAdh 
		
End case 
