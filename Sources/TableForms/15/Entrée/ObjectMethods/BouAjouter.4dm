If (PUMTypeFacture=0)
	ALERT:C41("Désignez le type de facture, SVP...")
Else 
	  //Si ([Factures]CodeBénéficiaire="")
	  //ALERTE("Précisez le bénéficiaire SVP...")
	  //ALLER À OBJET([Factures]CodeBénéficiaire)
	  //Sinon 
	AjoutLignefacture:=True:C214
	FORM SET INPUT:C55([Ventes:16];"SaisieVente")
	ADD RECORD:C56([Ventes:16];*)
	QUERY:C277([Ventes:16];[Ventes:16]NumFacture:2=[Factures:15]NumFacture:3)
	CalculTotalFacture 
	AjoutLignefacture:=False:C215
	  //Fin de si 
End if 