//%attributes = {}
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 07/10/18, 08:08:21
  // ----------------------------------------------------
  // Paramètre : $1 = type de tarif
  // ----------------------------------------------------
  // Méthode : PrestationAfficheTarif
  // Description
  // Méthode qui affiche les tarifs pour le RAEMA Poudre
  //  dans le formulaire projet DlgPrestations
  // ----------------------------------------------------
$Type:=$1[[1]]+"@"
QUERY:C277([Prestations:26];[Prestations:26]CodePrestation:2=$Type;*)
QUERY:C277([Prestations:26]; & [Prestations:26]AnneePrestation:6=VarNomAnnee)
SELECTION TO ARRAY:C260([Prestations:26]NomPrestation:3;Colonne1\
;[Prestations:26]PrixPrestation:4;Colonne2N\
;[Prestations:26]TauxTVAPrestation:5;Colonne3N)