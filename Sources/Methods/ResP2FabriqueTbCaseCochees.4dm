//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/07/18, 07:12:02
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP2FabriqueTBCaseCochees
  // Description
  // // Création du tableau TbNCBC = Tb du nom des cases réellement cochées
  // CB1 à CB11 pour un RAEMA poudre et rgcb1 à rgcbn pour le RAEMA gel
  // TbNCBC sera testé dans ResP2ConditionsFavorables appelée par ResP2FabriqueRaemaRestreint
ARRAY TEXT:C222(TbNCBC;0)  // les noms des cases cochées récoltés sur le formulaire Web
$FT:=Size of array:C274(TbNomsP2)
$Test:=(Num:C11(RaemaPoudre)*"CB@")+(Num:C11(Not:C34(RaemaPoudre))*"rgcb@")
$L:=0
For ($Salé;1;$FT)
	$L:=Find in array:C230(TbNomsP2;$Test;($L+1))  // test séquentiel
	If ($L=-1)  // il n'y a plus de Cases à cocher notées
		$Salé:=$FT
	Else   // on repéré une case à cocher
		APPEND TO ARRAY:C911(TbNCBC;TbNomsP2{$L})  //Ajout dans TbNCBC
	End if 
End for 

