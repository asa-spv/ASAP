//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/01/19, 06:47:42
  // ----------------------------------------------------
  // Paramètre $1 = numéro de labo RAEMA (numérique)
  // ----------------------------------------------------
  // Méthode : ASAPTrouveUUIDLaboParNumero
  // Description
  // Retouve [Personnes]UUID à partir du numéro de labo RAEMA (numérique) 

C_TEXT:C284($0)
C_LONGINT:C283($L;$1)
$L:=Find in array:C230(<>TbPerNumLaboRAEMA;$1)
If ($L>0)
	$0:=<>TbPerUUID{$L}
Else 
	$0:=""
End if 