
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		$NomFemme:=Num:C11([XUtilisateurs:2]NomJeuneFille:8#"")*(" née "+[XUtilisateurs:2]NomJeuneFille:8)
		VarNP:=[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]Nom:2+$NomFemme
End case 
