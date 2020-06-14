//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 08/05/18, 07:23:13
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZLBFabriquePUMListes
  // Description
  // Méthode qui fabrique le PUM de gestion des listes
  //  renvoie le nombre de liste créées par l'utilisateur


  // recherche de toutes les listes de la table
QUERY:C277([XData:1];[XData:1]XType:3="LB"+ZNomTable)
SELECTION TO ARRAY:C260([XData:1]XAlpha:8;$TbPUMFormatPossible;[XData:1]UUID:1;$TbUUIDFormatPossible;[XData:1]XTexte:9;$TbQuiCode)
$TT:=Size of array:C274($TbQuiCode)


  // recherche des listes de la table créées par l'utilisateur
QUERY:C277([XData:1];[XData:1]XNom:2=ZNomListeXData;*)
QUERY:C277([XData:1]; & [XData:1]XType:3="LB"+ZNomTable)
NumEnrPremListe:=Record number:C243([XData:1])  // le premier

  // initialisation des PUM de choix des formats de l'utilisateur
SELECTION TO ARRAY:C260([XData:1]XAlpha:8;TbPUMFormatPossible;[XData:1]UUID:1;TbUUIDFormatPossible)
$FT:=Records in selection:C76([XData:1])
$SFT:=$TT-$FT
ARRAY TEXT:C222(TbPUMFormatInterdit;0)

  // Ajout des listes des autres utilisateurs
If ($SFT>0)
	APPEND TO ARRAY:C911(TbPUMFormatPossible;"-")
	APPEND TO ARRAY:C911(TbUUIDFormatPossible;Generate UUID:C1066)
	ARRAY TEXT:C222(TbPUMFormatInterdit;$SFT)  // Permet d'éviter de modifier la LB du voisin.
	For ($Salé;1;$TT)
		If (Find in array:C230(TbUUIDFormatPossible;$TbUUIDFormatPossible{$Salé})<0)
			$Item:=$TbQuiCode{$Salé}+"-"+$TbPUMFormatPossible{$Salé}
			APPEND TO ARRAY:C911(TbPUMFormatPossible;$Item)
			APPEND TO ARRAY:C911(TbPUMFormatInterdit;$Item)
			APPEND TO ARRAY:C911(TbUUIDFormatPossible;$TbUUIDFormatPossible{$Salé})
		End if 
	End for 
End if 

$0:=$FT