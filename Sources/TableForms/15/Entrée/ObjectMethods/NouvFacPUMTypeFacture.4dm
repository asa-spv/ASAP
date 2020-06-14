If (Form event code:C388=Sur données modifiées:K2:15)
	
	Case of 
		: (PUMTypeFacture=1)  // Cotisation individuelle
			[Factures:15]NumFacture:3:=<>ZPermMille+"/C"+String:C10(ProchNumIndexFactureC;"0000")
			
		: (PUMTypeFacture=2)  // RAEMA poudre
			[Factures:15]NumFacture:3:=<>ZPermMille+"/RT"+String:C10(ProchNumIndexFactureRT;"0000")
			
		: (PUMTypeFacture=3)  // RAEMA gel
			[Factures:15]NumFacture:3:=<>ZPermMille+"/RC"+String:C10(ProchNumIndexFactureRC;"0000")
			
		: (PUMTypeFacture=4)  // Autres
			[Factures:15]NumFacture:3:=<>ZPermMille+"/X"+String:C10(ProchNumIndexFactureX;"0000")
			
		Else 
			ALERT:C41("Merci de désigner un type de facture")
	End case 
End if 
