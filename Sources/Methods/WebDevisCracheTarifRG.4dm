//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/12/18, 17:29:18
  // ----------------------------------------------------
  // Paramètre : $1 = code de la prestation
  // ----------------------------------------------------
  // Méthode : WebDevisCracheTarifRG
  // Description
  // Méthode qui va chercher le tarif du RAEMA Gel
  // dans les tableaux généraux de la table des prestations
  //  définis dans la méthode ASAPFabriqueTbPrestations
  // où <>AnCourantDevisRGA, <>TbCombinePrestation et <>TbPrixPrestation

$Code:=$1
$Test:=<>AnCourantDevisRGA+$Code+"@"
$L:=Find in array:C230(<>TbCombinePrestation;$Test)
$0:=String:C10(<>TbPrixPrestation{$L})

