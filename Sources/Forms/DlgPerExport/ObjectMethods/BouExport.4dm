  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 14/08/19, 06:38:22
  // ----------------------------------------------------
  // Méthode : DlgPerExport.BouExport
  // Description
  // Méthpode qui exporte au codage souhaité 
  //   les données chosies de la sélection de [Personnes]
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$L;$FT;$Fumé;$TT;$Sec;$PT)
C_OBJECT:C1216($Objet)

Case of 
	: (PUMCodage=1)  // Windows
		USE CHARACTER SET:C205("iso-8859-1";0)
		
	: (PUMCodage=2)  // Mac
		USE CHARACTER SET:C205("Macintosh";0)
		
End case 
$Export:=""
$FT:=Size of array:C274(TbChampsExport)

  // Les ET des colonnes
For ($Salé;1;$FT)
	$L:=Find in array:C230(TbChampsPossibles;TbChampsExport{$Salé})
	$Objet:=OB Get:C1224(ObjetExport;TbChampsPossibles{$L};Est un objet:K8:27)
	OB GET PROPERTY NAMES:C1232($Objet;$TbProprio;$TbType)
	$TT:=Size of array:C274($TbProprio)
	For ($Fumé;1;$TT)
		$Export:=$Export+<>ZTab+$TbProprio{$Fumé}
	End for 
End for 
$Export:=Substring:C12($Export;2)+<>ZCR

  // Passons aux données
SELECTION TO ARRAY:C260([Personnes:12]Identificateur:4;$TbIdentificateur)
$PT:=Size of array:C274($TbIdentificateur)
For ($Sec;1;$PT)
	$LignePerso:=Find in array:C230(<>TbPerIdentificateur;$TbIdentificateur{$sec})
	$Ligne:=""
	For ($Salé;1;$FT)
		$L:=Find in array:C230(TbChampsPossibles;TbChampsExport{$Salé})
		$Objet:=OB Get:C1224(ObjetExport;TbChampsPossibles{$L};Est un objet:K8:27)
		OB GET PROPERTY NAMES:C1232($Objet;$TbProprio;$TbType)
		$TT:=Size of array:C274($TbProprio)
		For ($Fumé;1;$TT)
			Case of 
				: ($TbType=Est un tableau entierlong:K8:19)
					ARRAY LONGINT:C221($TbGeneralN;0)
					OB GET ARRAY:C1229($Objet;$TbProprio{$Fumé};$TbGeneralN)
					$Ligne:=$Ligne+<>ZTab+String:C10($TbGeneralN{$LignePerso})
					
				: ($TbType=Est un tableau booléen:K8:21)
					ARRAY BOOLEAN:C223($TbGeneralB;0)
					OB GET ARRAY:C1229($Objet;$TbProprio{$Fumé};$TbGeneralB)
					$Ligne:=$Ligne+<>ZTab+String:C10($TbGeneralB{$LignePerso})
					
				Else 
					ARRAY TEXT:C222($TbGeneralA;0)
					OB GET ARRAY:C1229($Objet;$TbProprio{$Fumé};$TbGeneralA)
					$Ligne:=$Ligne+<>ZTab+$TbGeneralA{$LignePerso}
					
			End case 
		End for 
	End for 
	$Export:=$Export+Substring:C12($Ligne;2)+<>ZCR
	
End for 
SET TEXT TO PASTEBOARD:C523($Export)
ALERT:C41("L'export est dans le presse papier...")
USE CHARACTER SET:C205(*;0)