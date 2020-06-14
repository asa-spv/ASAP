//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 29/09/16, 14:57:00
  // ----------------------------------------------------
  // Méthode : RetourCocheCampagneTb
  // Description
  // 
  //
  // Paramètres : $1 = Pt Tbleau des mots cles ($TbMot)
  //  $2 = Pt sur Tb de n° de la campagne)
  //  $3 = Pt sur le Tableau de booléen (case à cocher)
  // $4 = rang du Tb 
  // ----------------------------------------------------
$L:=Find in array:C230($1->;$2->{$4})
$3->{$4}:=($L>0)