//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 11:34:48
  // ----------------------------------------------------
  // Méthode : ZListePyjama
  // Description
  // Permet de présenter des listes de GereListe avec des couleurs alternées
  // Paramètre si $1 existe c'est un Pt sur une variable à colorer
  // ----------------------------------------------------

C_LONGINT:C283($NDS)
If (Count parameters:C259=1)
	$PtV:=$1
Else 
	$PtV:=->VarFonCou
End if 
$NDS:=Selected record number:C246(ZPtTable->)
_O_OBJECT SET COLOR:C271($PtV->;-256*Blanc:K11:1)
If (Displayed line number:C897%2=0)
	OBJECT SET RGB COLORS:C628($PtV->;14680063;14680063)
Else 
	_O_OBJECT SET COLOR:C271($PtV->;-41153)
End if 

$PtV->:=""
