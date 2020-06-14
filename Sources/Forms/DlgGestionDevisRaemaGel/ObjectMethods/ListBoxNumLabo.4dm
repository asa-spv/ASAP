
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		RaemaDevisClicDansListe ("ListBoxNumLabo";->Colonne2N)
		OBJECT SET VISIBLE:C603(*;"BouValideDevis";True:C214)
		OBJECT SET VISIBLE:C603(*;"BouAnnuleDevis";True:C214)
		OBJECT SET VISIBLE:C603(*;"BouRetour";False:C215)
End case 
If (False:C215)
	  //numlabo
	  //mdplabo
	  //Nom
	  //adresse
	  //cp
	  //ville
	  //pays
	  //mail
	  //cbmaibacillus
	  //cbmaipseudo
	  //cbmailactiques
	  //cbmailmensemble
	  //cbmailmsepare
	  //nbpotsuparmaibacillus
	  //nbpotsuparmaipseudo
	  //nbpotsuparmailactiques
	  //nbpotsuparmailmensemble
	  //nbpotsuparmailmsepare
	  //nbpotsupsrmaibacillus
	  //nbpotsupsrmaipseudo
	  //nbpotsupsrmailactiques
	  //nbpotsupsrmailmensemble
	  //nbpotsupsrmailmsepare
	  //cbdecbacillus
	  //cbdecpseudo
	  //cbdeclactiques
	  //cbdeclmensemble
	  //cbdeclmsepare
	  //nbpotsupardecbacillus
	  //nbpotsupardecpseudo
	  //nbpotsupardeclactiques
	  //nbpotsupardeclmensemble
	  //nbpotsupardeclmsepare
	  //nbpotsupsrdecbacillus
	  //nbpotsupsrdecpseudo
	  //nbpotsupsrdeclactiques
	  //nbpotsupsrdeclmensemble
	  //nbpotsupsrdeclmsepare
	  //valht
	  //envoyer
	
End if 