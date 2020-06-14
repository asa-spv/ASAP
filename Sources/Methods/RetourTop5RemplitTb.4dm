//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 19/06/17, 14:33:30
  // ----------------------------------------------------
  // Méthode : RetourTop5
  // Description: Permet de créer le texte pour remplir le tableau word du top 5
  // Paramètres : $1=->score $2=->valeurs classification de l'année courante
  //              $3=->score $4=->valeurs classification de l'année précédente

  // ----------------------------------------------------
SORT ARRAY:C229($1->;$2->;<)
SORT ARRAY:C229($3->;$4->;<)
$T:=""
For ($salé;1;5)
	If (Size of array:C274($2->)>=$salé)
		$T:=$T+$2->{$salé}+" ("+String:C10($1->{$salé})+")"+<>ZTab+$4->{$salé}+" ("+String:C10($3->{$salé})+")"+<>ZCR
	Else 
		$T:=$T+<>ZCR
	End if 
End for 
$0:=$T