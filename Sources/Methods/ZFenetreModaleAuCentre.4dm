//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 09:56:50
  // ----------------------------------------------------
  // Méthode : ZFenetreModaleAuCentre
  // Description
  //  Historique : ZFenêtreCeintrée  V11 du 14/08/2010
  //  Méthode qui affiche une fenêtre centrée modale par défaut
  // Paramètres
  //   Taille de la fenêtre: L=$1  x  H=$2
  //  Type de la fenêtre {$3} si non modale  Commentaire ={$4}
  //
  // ----------------------------------------------------

C_LONGINT:C283($Gauche;$Droite;$Haute;$Bas;$TF;$1;$2)

$Gauche:=(Screen width:C187-$1)/2
$Droite:=(Screen width:C187+$1)/2
$Haute:=((Screen height:C188-$2)/2)+21
$Bas:=((Screen height:C188+$2)/2)+21
$TF:=1
$Com:=""
If (Count parameters:C259>2)  // type de la fenêtre
	C_LONGINT:C283($3)
	$TF:=$3
End if 
If (Count parameters:C259=4)
	C_TEXT:C284($Com;$4)
	$Com:=$4
End if 
$F:=Open window:C153($Gauche;$Haute;$Droite;$Bas;$TF;$Com)
