//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 11:42:25
  // ----------------------------------------------------
  // Méthode : ZTableauVersTexte
  // Description
  // Transforme un tableau et texte
  //  par défaut sous forme d'une liste (séparateur = retour charriot)
  // Paramètres
  // $1 = Pt tableau
  // {$2} = séparateur
  // ----------------------------------------------------  
C_POINTER:C301($1)
C_LONGINT:C283($salé;1;$FT)
$FT:=Size of array:C274($1->)
$Texte:=""
If (Count parameters:C259=1)
	$CR:=<>ZCR
Else 
	$CR:=$2
End if 
For ($salé;1;$FT)
	$Texte:=$Texte+$CR+String:C10($1->{$Salé})
End for 

$L:=Length:C16($CR)+1
$0:=Substring:C12($Texte;$L)