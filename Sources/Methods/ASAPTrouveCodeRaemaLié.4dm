//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/02/19, 05:15:40
  // ----------------------------------------------------
  // Paramètres : 
  // $1 = ligne des tableaux généraux <>TbPANumRAEMALiés 
  // $2 = numéro (alphanumérique) figurant sur le rapport de campagne
  // ----------------------------------------------------
  // Méthode : ASAPTrouveCodeRaemaLié
  // Description
  //  méthode qui trouve le code login
  // dans le cadre d'un RAEMA lié 

C_LONGINT:C283($1;$L;$L2)
C_TEXT:C284($2;$0)

$L:=$1
$NumRapportA:=$2
ARRAY TEXT:C222($TbNumRL;0)
ZTexteVersTableau (<>TbPANumRAEMALiés{$L};->$TbNumRL;" ")
ARRAY TEXT:C222($TbCodeRL;0)
$L2:=Find in array:C230($TbNumRL;$NumRapportA)
ZTexteVersTableau (<>TbPATbCodesRAEMALiés{$L};->$TbCodeRL;";")
$0:=$TbCodeRL{$L2}