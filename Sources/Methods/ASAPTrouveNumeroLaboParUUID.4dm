//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/01/19, 06:47:42
  // ----------------------------------------------------
  // Paramètre $1 = UUI du labo 
  // ----------------------------------------------------
  // Méthode : ASAPTrouveNumeroLaboParUUID
  // Description
  // Retouve le numéro de labo RAEMA (alphanumérique) à partir de [Personnes]UUID  

C_TEXT:C284($0;$1)
C_LONGINT:C283($L)
$L:=Find in array:C230(<>TbPerUUID;$1)
If ($L>0)
	$0:=<>TbPerNumLaboRAEMAA{$L}
Else 
	$0:=""
End if 