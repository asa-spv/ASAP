//%attributes = {}
  // Nom utilisateur (OS) : cgm   Date et heure : 06/10/13, 07:44:28
  // Méthode : WebTrouveValeurParNom
  // ----------------------------------------------------
  // Paramètres : $1=nom de la variable,  $2=Pt sur tableau des noms 
  //  $3=Pt sur tableau des valeurs 
  // ----------------------------------------------------
  // Description : permet de retrouver une valeur du tableau $3
  // d'après son nom $1 inscrit dans le tableau $2

C_TEXT:C284($1)
C_LONGINT:C283($L)
C_POINTER:C301($2;$3)
$L:=Find in array:C230($2->;$1)
If ($L>0)
	$0:=$3->{$L}
Else 
	$0:=""
End if 