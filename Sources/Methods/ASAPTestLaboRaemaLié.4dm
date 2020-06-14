//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/02/19, 04:32:16
  // ----------------------------------------------------
  // Paramètres : 
  // $1 = numéro de labo (alphanumérique)
  // ----------------------------------------------------
  // Méthode : ASAPTestLaboRaemaLié
  // Description
  // Méthode qui renvoie la ligne du tableau des personnes 
  //   qui correspond au laboratoire maître 
  //   dans le cas de colis supplémentaires avec rapport
  //   et renvoie la valeur -1 s'il ne le trouve pas

$NumLaboRaemaA:=$1
$test1:=" "+$NumLaboRaemaA
$test2:=$NumLaboRaemaA+" "
$test3:=$NumLaboRaemaA
  // Le laboratoire est-il lié à un laboratoire maître ?
$L:=Find in array:C230(<>TbPANumRAEMALiés;$test1)
If ($L<0)
	$L:=Find in array:C230(<>TbPANumRAEMALiés;$test2)
	If ($L<0)
		$L:=Find in array:C230(<>TbPANumRAEMALiés;$test3)
	End if 
End if 
$0:=$L