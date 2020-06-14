
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		<>AnCourantRGA:=<>CampagneDevisRGMai
		GA13RaemaGelGrilleInit 
		GA15FabriqueTbDevisRAEMAGel 
		LISTBOX SELECT ROW:C912(ListBoxNumLabo;0;lk supprimer de sélection:K53:3)  // Devis à valider
		LISTBOX SELECT ROW:C912(ListBoxNumOK;0;lk supprimer de sélection:K53:3)  // Devis validés
		LISTBOX SELECT ROW:C912(ListBoxNumAdilva;0;lk supprimer de sélection:K53:3)  // Devis ADILVA
		OBJECT SET VISIBLE:C603(*;"BouValideDevis";False:C215)
		OBJECT SET VISIBLE:C603(*;"BouAnnuleDevis";False:C215)
		OBJECT SET VISIBLE:C603(*;"BouRetour";False:C215)
End case 
