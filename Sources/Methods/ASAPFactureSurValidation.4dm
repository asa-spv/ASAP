//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 24/09/19, 11:22:10
  // ----------------------------------------------------
  // Méthode : ASAPFactureSurValidation
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
If (Is new record:C668([Factures:15]))
	Case of 
		: (PUMTypeFacture=1)  // Cotisation individuelle
			ProchNumIndexFactureC:=ProchNumIndexFactureC+1
			
		: (PUMTypeFacture=2)  // RAEMA poudre
			ProchNumIndexFactureRT:=ProchNumIndexFactureRT+1
			
		: (PUMTypeFacture=3)  // RAEMA gel
			ProchNumIndexFactureRC:=ProchNumIndexFactureRC+1
			
		: (PUMTypeFacture=4)  // Autres
			ProchNumIndexFactureX:=ProchNumIndexFactureX+1
	End case 
End if 