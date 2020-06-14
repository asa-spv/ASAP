
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		RaemaDevisClicDansListe ("ListBoxNumAdilva";->TbNumEnrDevisAdilva)
		OBJECT SET VISIBLE:C603(*;"BouValideDevis";False:C215)
		OBJECT SET VISIBLE:C603(*;"BouAnnuleDevis";False:C215)
		OBJECT SET VISIBLE:C603(*;"BouRetour";False:C215)
End case 
