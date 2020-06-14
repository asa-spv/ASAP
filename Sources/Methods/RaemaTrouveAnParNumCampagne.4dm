//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 19/06/18, 08:07:34
  // ----------------------------------------------------
  // Méthode : RaemaTrouveAnParNumCampagne
  // Description
  // Fonction qui renvoie l'année (numérique) où s'est produit la campagne
  //  passée en paramètre
  // Paramètre : $1 = n° de la campagne
  // ----------------------------------------------------
C_LONGINT:C283($NCN;$0)
C_TEXT:C284($1)
$NumCampagne:=$1
$NCN:=Int:C8(Num:C11($NumCampagne)/2)
$0:=1985+$NCN