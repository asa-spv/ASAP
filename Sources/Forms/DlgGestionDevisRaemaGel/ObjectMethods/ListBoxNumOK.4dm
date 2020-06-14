
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		RaemaDevisClicDansListe ("ListBoxNumOK";->TbNumEnrOK)
		OBJECT SET VISIBLE:C603(*;"BouValideDevis";False:C215)
		OBJECT SET VISIBLE:C603(*;"BouAnnuleDevis";False:C215)
		OBJECT SET VISIBLE:C603(*;"BouRetour";True:C214)
End case 
