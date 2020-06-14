//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/01/16, 21:40:14
  // ----------------------------------------------------
  // Méthode : ZTexteVersTableau
  // Description
  // 
  //
  // Paramètres : $1 = texte; $2= Pt vers tableau;  {$3}=séparateur
  // ----------------------------------------------------

C_TEXT:C284($1)
C_POINTER:C301($2)

$T:=$1
If (Count parameters:C259=3)
	$Séparateur:=$3
Else 
	$Séparateur:=<>ZCR
End if 
$Pos:=Position:C15($Séparateur;$T)

While ($Pos>0)
	APPEND TO ARRAY:C911($2->;Substring:C12($T;1;($Pos-1)))
	$T:=Substring:C12($T;($Pos+1))
	$Pos:=Position:C15($Séparateur;$T)
End while 
If (Length:C16($T)>0)
	APPEND TO ARRAY:C911($2->;$T)
End if 