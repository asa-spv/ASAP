If (PUMTypeImpression=1)
	FORM GOTO PAGE:C247(2)
Else 
	FORM GOTO PAGE:C247(1)
	BouImageImpListe:=0
	BouImageImpFiche:=0
	BouImageImpEtiquette:=0
	BouImageImpEtat:=0
	Case of 
		: (PUMTypeImpression=2)
			BouImageImpFiche:=1
			
		: (PUMTypeImpression=3)
			BouImageImpEtiquette:=1
			
		: (PUMTypeImpression=4)
			BouImageImpEtat:=1
			
	End case 
End if 