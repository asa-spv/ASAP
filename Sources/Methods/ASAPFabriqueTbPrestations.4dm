//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 25/12/18, 05:16:16
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbPrestations
  // Description
  // // Méthode qui met, dans des tableaux, la table des prestations

C_LONGINT:C283($Salé;$FT)
$MCE:=Macintosh command down:C546
$MOE:=Macintosh option down:C545
$NomMéthodeCourante:=Current method name:C684
$NomMéthodeMAJ:=$NomMéthodeCourante+"MAJ"
If (<>ZClient) & (Count parameters:C259=0)
	$Prc:=Execute on server:C373($NomMéthodeCourante;0)
Else 
	ASAPInitTbGenerauxPrestations 
	
	ALL RECORDS:C47([Prestations:26])
	SELECTION TO ARRAY:C260([Prestations:26]AnneePrestation:6;<>TbAnneePrestation\
		;[Prestations:26]CodePrestation:2;<>TbCodePrestation\
		;[Prestations:26]NomPrestation:3;<>TbNomPrestation\
		;[Prestations:26]PrixPrestation:4;<>TbPrixPrestation\
		;[Prestations:26]RAEMAPrestation:7;<>TbRAEMAPrestation\
		;[Prestations:26]TauxTVAPrestation:5;<>TbTauxTVAPrestation\
		;[Prestations:26]UUID:1;<>TbUUID)
	LONGINT ARRAY FROM SELECTION:C647([Prestations:26];<>TbNumEnrPrestation)
	$FT:=Size of array:C274(<>TbAnneePrestation)
	ARRAY TEXT:C222(<>TbCombinePrestation;$FT)
	$Rapport:=""
	For ($Salé;1;$FT)
		<>TbCombinePrestation{$Salé}:=String:C10(<>TbAnneePrestation{$Salé})+<>TbCodePrestation{$Salé}+<>TbNomPrestation{$Salé}
	End for 
	
	  // détermination de l'année du RAEMA gel tarifé
	$AnCourantN:=Year of:C25(Current date:C33)
	$AnProchainN:=$AnCourantN+1
	$AnCourantA:=String:C10($AnCourantN)
	$AnProchainA:=String:C10($AnProchainN)
	$Test:=$AnProchainA+"G11@"  // "G11" = [Prestations]CodePrestation GEL
	$L:=Find in array:C230(<>TbCombinePrestation;$Test)
	<>AnCourantDevisRGN:=$AnCourantN+Num:C11($L>0)
	<>AnCourantDevisRGA:=String:C10(<>AnCourantDevisRGN)
	<>CampagneDevisRGMai:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN;2)
	<>CampagneDevisRGDec:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN;4)
	
	  // Fabrication des tableaux RAEMA gel facturables
	ARRAY TEXT:C222(<>TbNomGermeMai;0)
	ARRAY TEXT:C222(<>TbOrdreGelMai;0)
	ARRAY BOOLEAN:C223(<>TbCofracGermeMai;0)
	ARRAY BOOLEAN:C223(<>TbExperimentalGermeMai;0)
	
	ARRAY TEXT:C222(<>TbNomGermeDec;0)
	ARRAY TEXT:C222(<>TbOrdreGelDec;0)
	ARRAY BOOLEAN:C223(<>TbCofracGermeDec;0)
	ARRAY BOOLEAN:C223(<>TbExperimentalGermeDec;0)
	
	ARRAY OBJECT:C1221($TbArguments;0)
	  // Mai
	$CampagneMai:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN;2)
	$L:=Find in array:C230(<>TbCampagnesNumCampagne;$CampagneMai)
	$UUIDCampagne:=""
	If ($L>0)
		$UUIDCampagne:=<>TbCampagnesUUID{$L}
	Else 
		$CampagneMai:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN-1;2)
		$L:=Find in array:C230(<>TbCampagnesNumCampagne;$CampagneMai)
		If ($L>0)
			$UUIDCampagne:=<>TbCampagnesUUID{$L}
		End if 
	End if 
	QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]UUIDCampagne:2=$UUIDCampagne)
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;<>TbNomGermeMai;[RAEMAGermes:21]Identifiant:3;<>TbOrdreGelMai;[RAEMAGermes:21]Arguments:6;$TbArguments)
	$FT:=Size of array:C274(<>TbNomGermeMai)
	ARRAY BOOLEAN:C223(<>TbCofracGermeMai;$FT)
	ARRAY BOOLEAN:C223(<>TbExperimentalGermeMai;$FT)
	For ($Salé;1;$FT)
		<>TbCofracGermeMai{$Salé}:=OB Get:C1224($TbArguments{$Salé};"COFRAC";Est un booléen:K8:9)
		<>TbExperimentalGermeMai{$Salé}:=OB Get:C1224($TbArguments{$Salé};"Experimental";Est un booléen:K8:9)
	End for 
	SORT ARRAY:C229(<>TbOrdreGelMai;<>TbNomGermeMai;<>TbCofracGermeMai;<>TbExperimentalGermeMai;>)
	If (Size of array:C274(<>TbNomGermeMai)>0)
		DELETE FROM ARRAY:C228(<>TbNomGermeMai;1)  // suppression du 1er = Conditions d'examen
		DELETE FROM ARRAY:C228(<>TbOrdreGelMai;1)  // 
		DELETE FROM ARRAY:C228(<>TbCofracGermeMai;1)
		DELETE FROM ARRAY:C228(<>TbExperimentalGermeMai;1)
	End if 
	  // Décembre
	$CampagneDécembre:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN;4)
	$L:=Find in array:C230(<>TbCampagnesNumCampagne;$CampagneDécembre)
	If ($L>0)
		$UUIDCampagne:=<>TbCampagnesUUID{$L}
	Else 
		$CampagneDécembre:=RaemaTrouveNumCampagneParAn (<>AnCourantDevisRGN-1;4)
		$L:=Find in array:C230(<>TbCampagnesNumCampagne;$CampagneDécembre)
		If ($L>0)
			$UUIDCampagne:=<>TbCampagnesUUID{$L}
		Else 
			$UUIDCampagne:=""
		End if 
	End if 
	QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]UUIDCampagne:2=$UUIDCampagne)
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;<>TbNomGermeDec;[RAEMAGermes:21]Identifiant:3;<>TbOrdreGelDec;[RAEMAGermes:21]Arguments:6;$TbArguments)
	$FT:=Size of array:C274(<>TbNomGermeDec)
	ARRAY BOOLEAN:C223(<>TbCofracGermeDec;$FT)
	ARRAY BOOLEAN:C223(<>TbExperimentalGermeDec;$FT)
	For ($Salé;1;$FT)
		<>TbCofracGermeDec{$Salé}:=OB Get:C1224($TbArguments{$Salé};"COFRAC";Est un booléen:K8:9)
		<>TbExperimentalGermeDec{$Salé}:=OB Get:C1224($TbArguments{$Salé};"Experimental";Est un booléen:K8:9)
	End for 
	SORT ARRAY:C229(<>TbOrdreGelDec;<>TbNomGermeDec;<>TbCofracGermeDec;<>TbExperimentalGermeDec;>)
	If (Size of array:C274(<>TbNomGermeMai)>0)
		DELETE FROM ARRAY:C228(<>TbNomGermeDec;1)  // suppression du 1er = Conditions d'examen
		DELETE FROM ARRAY:C228(<>TbOrdreGelDec;1)
		DELETE FROM ARRAY:C228(<>TbCofracGermeDec;1)
		DELETE FROM ARRAY:C228(<>TbExperimentalGermeDec;1)
	End if 
	
	If ($MCE)
		$Rapport:=$Rapport+"Année"+<>ZTab+"Code"+<>ZTab+"Nom"+<>ZTab+"Prix"+<>ZTab+"TVA"+<>ZTab+"UUID"+<>ZTab+"Combinaison"+<>ZCR
		$FT:=Size of array:C274(<>TbAnneePrestation)
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+String:C10(<>TbAnneePrestation{$Salé})+<>ZTab+<>TbCodePrestation{$Salé}+<>ZTab
			$Rapport:=$Rapport+<>TbNomPrestation{$Salé}+<>ZTab+String:C10(<>TbPrixPrestation{$Salé})+<>ZTab
			$Rapport:=$Rapport+String:C10(<>TbTauxTVAPrestation{$Salé})+<>ZTab+<>TbUUID{$Salé}+<>ZTab+<>TbCombinePrestation{$Salé}+<>ZCR
		End for 
		SET TEXT TO PASTEBOARD:C523($Rapport)
	End if 
	If ($MOE)
		$Rapport:=$Rapport+"Nom germe mai"+<>ZTab+"Cofrac mai"+<>ZTab+"Ordre mai"+<>ZTab+"expérimental mai"+<>ZTab
		$Rapport:=$Rapport+"Nom germe Dec"+<>ZTab+"Cofrac Dec"+<>ZTab+"Ordre Dec"+<>ZTab+"expérimental Dec"+<>ZCR
		$FT:=Size of array:C274(<>TbNomGermeDec)
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+String:C10(<>TbNomGermeDec{$Salé})+<>ZTab+String:C10(<>TbCofracGermeMai{$Salé})+<>ZTab+String:C10(<>TbOrdreGelMai{$Salé})+<>ZTab+String:C10(<>TbExperimentalGermeMai{$Salé})+<>ZTab
			$Rapport:=$Rapport+String:C10(<>TbNomGermeDec{$Salé})+<>ZTab+String:C10(<>TbCofracGermeDec{$Salé})+<>ZTab+String:C10(<>TbOrdreGelDec{$Salé})+<>ZTab+String:C10(<>TbExperimentalGermeDec{$Salé})+<>ZCR
		End for 
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
	End if 
End if 
If (Application type:C494=4D Server:K5:6)  // MAJ des clients inscrits
	EXECUTE ON CLIENT:C651("@";$NomMéthodeMAJ)
End if 
