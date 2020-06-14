//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/07/19, 13:23:20
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : ASAPCompareObjetDescriptifLabo
  // Description
  // Méthode qui établit la différence entre les objets 
  //   VarObjetDescriptifInitial et VarObjetDescriptifFinal 
  //   et le traduit en un texte simple

C_BOOLEAN:C305($RapportChange)
ARRAY TEXT:C222($TbNomXI;0)
ARRAY TEXT:C222($TbNomXF;0)
C_TEXT:C284($ValeurCourante)
C_LONGINT:C283($ValeurCouranteN;$ValeurFinaleN)
C_BOOLEAN:C305($ValeurCouranteB;$ValeurFinaleB)
  // C_OBJET(VarObjetDescriptifInitial;VarObjetDescriptifFinal)


OB GET PROPERTY NAMES:C1232(VarObjetDescriptifInitial;$TbNomXI;$TabType)
OB GET PROPERTY NAMES:C1232(VarObjetDescriptifFinal;$TbNomXF)
$FT:=Size of array:C274($TbNomXI)
VarRapportComparaison:=""
$RapportChange:=False:C215
For ($Salé;1;$FT)
	$XCouranteInitiale:=$TbNomXI{$Salé}
	
	If (True:C214)
		$ValeurCouranteInitiale:=String:C10(OB Get:C1224(VarObjetDescriptifInitial;$XCouranteInitiale))
		$ValeurCouranteFinale:=String:C10(OB Get:C1224(VarObjetDescriptifFinal;$XCouranteInitiale))
	Else 
		$ValeurCouranteInitiale:=OB Get:C1224(VarObjetDescriptifInitial;$XCouranteInitiale)
		$ValeurCouranteFinale:=OB Get:C1224(VarObjetDescriptifFinal;$XCouranteInitiale)
		Case of 
			: ($TabType{$Salé}=Est un booléen:K8:9)
				$ValeurCouranteB:=OB Get:C1224([Personnes:12]Arguments:7;$XCouranteInitiale;Est un booléen:K8:9)
				$ValeurCouranteInitiale:=String:C10($ValeurCouranteB)
				$ValeurFinaleB:=OB Get:C1224(VarObjetDescriptifInitial;$XCouranteInitiale;Est un booléen:K8:9)
				$ValeurCouranteFinale:=String:C10($ValeurFinaleB)
				
			: ($TabType{$Salé}=Est un entier long:K8:6)
				$ValeurCouranteN:=OB Get:C1224([Personnes:12]Arguments:7;$XCouranteInitiale;Est un entier long:K8:6)
				$ValeurCouranteInitiale:=String:C10($ValeurCouranteN)
				$ValeurFinaleN:=OB Get:C1224(VarObjetDescriptifInitial;$XCouranteInitiale;Est un entier long:K8:6)
				$ValeurCouranteFinale:=String:C10($ValeurFinaleN)
			Else 
				$ValeurCourante:=OB Get:C1224([Personnes:12]Arguments:7;$XCouranteInitiale)
				$ValeurCouranteInitiale:=$ValeurCourante
				$ValeurCourante:=OB Get:C1224(VarObjetDescriptifInitial;$XCouranteInitiale)
				$ValeurCouranteFinale:=$ValeurCourante
		End case 
	End if 
	
	$L:=Find in array:C230($TbNomXF;$XCouranteInitiale)
	If ($L<0)  // Propriété supprimée
		VarRapportComparaison:=VarRapportComparaison+<>ZCR+$XCouranteInitiale+" valeur initale : "+$ValeurCouranteInitiale+"   SUPPRIMEE"
		$RapportChange:=True:C214
	Else 
		If ($ValeurCouranteInitiale=$ValeurCouranteFinale)
			VarRapportComparaison:=VarRapportComparaison+<>ZCR+$XCouranteInitiale+" valeur initale : "+$ValeurCouranteFinale+"   INCHANGEE"
		Else 
			VarRapportComparaison:=VarRapportComparaison+<>ZCR+$XCouranteInitiale+" valeur initale : "+$ValeurCouranteInitiale+"   MODIFIEE en "
			VarRapportComparaison:=VarRapportComparaison+String:C10($ValeurCouranteFinale)
			$RapportChange:=True:C214
		End if 
	End if 
End for 

$FT:=Size of array:C274($TbNomXF)
For ($Salé;1;$FT)
	$L:=Find in array:C230($TbNomXI;$TbNomXF{$Salé})
	If ($L<0)  // Propriété ajoutée
		$ValeurCourante:=String:C10(OB Get:C1224(VarObjetDescriptifFinal;$TbNomXF{$Salé}))
		VarRapportComparaison:=VarRapportComparaison+<>ZCR+$TbNomXF{$Salé}+" : "+$ValeurCourante+"   AJOUTEE "
		$RapportChange:=True:C214
	End if 
End for 

$0:=$RapportChange