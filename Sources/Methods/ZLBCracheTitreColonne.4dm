//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 09/05/18, 10:32:44
  // ----------------------------------------------------
  // Méthode : ZLBCracheTitreColonne
  // Description
  // Restitue les nom de la colonne
  //
  // Paramètres : $1=num de la table; $2 = num du champ
  // ----------------------------------------------------
$NumTable:=$1
$NumChamp:=$2
ARRAY TEXT:C222($TbNomChamp;0)
OB GET ARRAY:C1229(ObTitreET;"ET"+String:C10($NumTable);$TbNomChamp)
ARRAY LONGINT:C221($TbRangChamp;0)
OB GET ARRAY:C1229(ObTitreET;"RC"+String:C10($NumTable);$TbRangChamp)
$L:=Find in array:C230($TbRangChamp;$NumChamp)
If ($L>0)
	$0:=$TbNomChamp{$l}
Else 
	$0:=""
End if 