//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/08/18, 08:19:08
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbParticipe
  // Description
  // // fabrique le tableau des participations

C_LONGINT:C283($Salé;$FT;$NumLaboN;$NbColisPoudreAR;$NbColisPoudreSR;$BoiteIsotherme)
C_TEXT:C284($Transporteur)
C_BOOLEAN:C305($SansPathogene)
C_OBJECT:C1216($ArgumentCourant)

$Ctrl:=Macintosh option down:C545
$MCE:=Macintosh command down:C546

$H1:=Milliseconds:C459
$NomMéthodeCourante:=Current method name:C684
$NomMéthodeMAJ:=$NomMéthodeCourante+"MAJ"
If (<>ZClient) & (Count parameters:C259=0)
	$Prc:=Execute on server:C373($NomMéthodeCourante;0)
Else 
	  // Initialisation des tableaux
	ASAPInitTbGenerauxParticipation 
	
	ARRAY TEXT:C222($TbPropriétéArgument;0)
	
	
	  //$RaemaInf:=RaemaTrouveNumCampagneParAn (Année de(Date du jour))
	  //$RaemaSup:=Chaîne(Num($RaemaInf)+2)
	$RaemaInf:=RaemaTrouveNumCampagneParAn (2016)
	$Delta:=(Year of:C25(Current date:C33)-2015)*2
	$RaemaSup:=String:C10(Num:C11($RaemaInf)+$Delta)
	
	  // Cas du laboratoire 13 = tests
	$UUID13:=ASAPTrouveUUIDLaboParNumero (13)
	$H1:=Milliseconds:C459
	
	  // Recrutement des campagnes récentes
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2#$UUID13;*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3>=$RaemaInf)
	
	$ToutT:=Records in selection:C76([CampagneParticipations:17])
	DISTINCT VALUES:C339([CampagneParticipations:17]NumCampagne:3;$TbNumeroCampagne)
	
	  // initialisation des tableaux contenant toutes les données récentes
	ARRAY TEXT:C222($TbToutLotoNumCampagne;$ToutT)
	ARRAY OBJECT:C1221($TbToutParticipationArgument;$ToutT)
	ARRAY TEXT:C222($TbToutLotoUUIDParticipation;$ToutT)
	ARRAY TEXT:C222($TbToutLotoUUIDLabo;$ToutT)
	  // renseignements des tableaux contenant toutes les données récentes des participations
	SELECTION TO ARRAY:C260([CampagneParticipations:17]NumCampagne:3;$TbToutLotoNumCampagne\
		;[CampagneParticipations:17]Arguments:5;$TbToutParticipationArgument\
		;[CampagneParticipations:17]UUID:1;$TbToutLotoUUIDParticipation\
		;[CampagneParticipations:17]UUIDPersonne:2;$TbToutLotoUUIDLabo)
	LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17];$TbToutNumEnrParticipation)
	
	  // recrutement de toutes les germes des camapgne Gel
	QUERY WITH ARRAY:C644([CampagneGelGermes:25]NumCampagne:6;$TbNumeroCampagne)
	  // renseignements des tableaux contenant toutes les données récentes des germes des camapgne Gel
	SELECTION TO ARRAY:C260([CampagneGelGermes:25]NomDuGerme:3;$TbToutNomGerme;[CampagneGelGermes:25]UUIDParticipation:2;$TbToutUUIDParticipation;[CampagneGelGermes:25]NumCampagne:6;$TbTousNumCampagne;[CampagneGelGermes:25]NbreColisSupAvecRapport:5;$TbToutNbAR;[CampagneGelGermes:25]NbreColisSupSansRapport:4;$TbToutNbSR)
	
	SORT ARRAY:C229($TbNumeroCampagne;>)  // tri des campagne de la plus ancienne à la plus récente
	
	$TT:=Size of array:C274($TbNumeroCampagne)
	For ($Fumé;1;$TT)  // autant que de campagne
		$NumCampagneCourante:=$TbNumeroCampagne{$Fumé}
		$AnCourant:=RaemaTrouveAnParNumCampagne ($NumCampagneCourante)
		
		$L:=0
		ARRAY TEXT:C222($TbLotoNumCampagne;0)
		ARRAY OBJECT:C1221($TbParticipationArgument;0)
		ARRAY TEXT:C222($TbLotoUUIDParticipation;0)
		ARRAY TEXT:C222($TbLotoUUIDLabo;0)
		ARRAY LONGINT:C221($TbNumEnrParticipation;0)
		Repeat 
			$L:=Find in array:C230($TbToutLotoNumCampagne;$NumCampagneCourante;($L+1))
			If ($L>0)
				APPEND TO ARRAY:C911($TbLotoNumCampagne;$NumCampagneCourante)
				APPEND TO ARRAY:C911($TbParticipationArgument;$TbToutParticipationArgument{$l})
				APPEND TO ARRAY:C911($TbLotoUUIDParticipation;$TbToutLotoUUIDParticipation{$l})
				APPEND TO ARRAY:C911($TbLotoUUIDLabo;$TbToutLotoUUIDLabo{$l})
				APPEND TO ARRAY:C911($TbNumEnrParticipation;$TbToutNumEnrParticipation{$l})
			End if 
		Until ($L<0)
		
		$FT:=Size of array:C274($TbLotoNumCampagne)
		For ($Salé;1;$FT)
			$UUIDCourantePersonne:=$TbLotoUUIDLabo{$Salé}
			APPEND TO ARRAY:C911(<>TbLotoUUIDLabo;$UUIDCourantePersonne)
			
			$L:=Find in array:C230(<>TbPerUUID;$UUIDCourantePersonne)
			APPEND TO ARRAY:C911(<>TbLotoAssociation;<>TbPAAssociation{$l})
			If ($Fumé+$Salé=2)  // Premier passage
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$UUIDCouranteParticipation:=$TbLotoUUIDParticipation{$Salé}
			APPEND TO ARRAY:C911(<>TbLotoUUIDParticipation;$UUIDCouranteParticipation)
			APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			
			$NumEnrCourantParticipation:=$TbNumEnrParticipation{$Salé}
			APPEND TO ARRAY:C911(<>TbLotoNumEnrParticipation;$NumEnrCourantParticipation)
			APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			
			
			APPEND TO ARRAY:C911(<>TbLotoNumCampagne;$NumCampagneCourante)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$ArgumentCourant:=$TbParticipationArgument{$Salé}
			$NumLaboN:=Num:C11(ASAPTrouveNumeroLaboParUUID ($UUIDCourantePersonne))
			APPEND TO ARRAY:C911(<>TbLotoNumLaboRAEMA;$NumLaboN)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$Transporteur:=OB Get:C1224($ArgumentCourant;"Transporteur";Est un texte:K8:3)
			If ($Transporteur="")
				QUERY:C277([Personnes:12];[Personnes:12]UUID:1=$TbLotoUUIDLabo{$Salé})
				$Transporteur:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis";Est un texte:K8:3)
			End if 
			APPEND TO ARRAY:C911(<>TbLotoTransporteur;$Transporteur)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"Transporteur")
			End if 
			
			$BoiteIsotherme:=OB Get:C1224($ArgumentCourant;"BoîteIsotherme";Est un entier long:K8:6)
			APPEND TO ARRAY:C911(<>TbLotoBoiteIsotherme;$BoiteIsotherme)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"BoîteIsotherme")
			End if 
			
			$SansPathogene:=OB Get:C1224($ArgumentCourant;"SansPathogene";Est un booléen:K8:9)
			If ($SansPathogene=False:C215)
				QUERY:C277([Personnes:12];[Personnes:12]UUID:1=$TbLotoUUIDLabo{$Salé})
				$SansPathogene:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogene";Est un booléen:K8:9)
			End if 
			APPEND TO ARRAY:C911(<>TbLotoSansPathogene;$SansPathogene)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"SansPathogene")
			End if 
			
			$NumBonCommandePoudre:=OB Get:C1224($ArgumentCourant;"NumBonCommandePoudre";Est un texte:K8:3)
			If ($NumBonCommandePoudre="") & ($AnCourant=Year of:C25(Current date:C33))
				$NumBonCommandePoudre:=WebTrouveValeurParNom ($UUIDCourantePersonne;-><>TbPerUUID;-><>TbPANumBonCommandePoudre)
			End if 
			APPEND TO ARRAY:C911(<>TbLotoNumBonCommandePoudre;$NumBonCommandePoudre)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"NumBonCommandePoudre")
			End if 
			
			$ProformaPoudre:=OB Get:C1224($ArgumentCourant;"Proforma";Est un texte:K8:3)
			If ($ProformaPoudre="") & ($AnCourant=Year of:C25(Current date:C33))
				QUERY:C277([Personnes:12];[Personnes:12]UUID:1=$TbLotoUUIDLabo{$Salé})
				$ProformaPoudre:=OB Get:C1224([Personnes:12]Arguments:7;"Proforma";Est un texte:K8:3)
			End if 
			APPEND TO ARRAY:C911(<>TbLotoProformaPoudre;$ProformaPoudre)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"Proforma")
			End if 
			
			$CodeRaemaLié:=OB Get:C1224($ArgumentCourant;"CodeRaemaLié";Est un texte:K8:3)
			APPEND TO ARRAY:C911(<>TbLotoCodeRaemaLié;$CodeRaemaLié)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"CodeRaemaLié")
			End if 
			
			$NbColisPoudreSR:=OB Get:C1224($ArgumentCourant;"NbreColisSupSansRapport";Est un entier long:K8:6)
			APPEND TO ARRAY:C911(<>TbLotoNbColisPoudreSR;$NbColisPoudreSR)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"NbreColisSupSansRapport")
			End if 
			
			$NbColisPoudreAR:=OB Get:C1224($ArgumentCourant;"NbreColisSupAvecRapport";Est un entier long:K8:6)
			APPEND TO ARRAY:C911(<>TbLotoNbColisPoudreAR;$NbColisPoudreAR)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"NbreColisSupAvecRapport")
			End if 
			
			$NumBonCommandeGel:=OB Get:C1224($ArgumentCourant;"NumBonCommandeGel";Est un texte:K8:3)
			If ($NumBonCommandeGel="") & ($AnCourant=Year of:C25(Current date:C33)) & (Size of array:C274(<>TbPANumBonCommandeGel)=Size of array:C274(<>TbPerUUID))
				$NumBonCommandeGel:=WebTrouveValeurParNom ($UUIDCourantePersonne;-><>TbPerUUID;-><>TbPANumBonCommandeGel)
			End if 
			APPEND TO ARRAY:C911(<>TbLotoNumBonCommandeGel;$NumBonCommandeGel)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"NumBonCommandeGel")
			End if 
			
			$ProformaGel:=OB Get:C1224($ArgumentCourant;"RGProforma";Est un texte:K8:3)
			If ($ProformaGel="") & ($AnCourant=Year of:C25(Current date:C33))
				$Pt:=Get pointer:C304("<>TbPARGProforma"+String:C10($AnCourant))
				$ProformaGel:=WebTrouveValeurParNom ($UUIDCourantePersonne;-><>TbPerUUID;$Pt)
			End if 
			APPEND TO ARRAY:C911(<>TbLotoProformaGel;$ProformaGel)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"RGProforma")
			End if 
			
			$Identifiant:=String:C10($NumLaboN)+"_"+$NumCampagneCourante+"_"+$CodeRaemaLié
			APPEND TO ARRAY:C911(<>TbLotoIdentifiantParticipation;$Identifiant)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$Identifiant:=Num:C11($CodeRaemaLié#"")*(String:C10(RAEMADemoduleMdPWeb ($CodeRaemaLié))+"_"+$NumCampagneCourante)
			APPEND TO ARRAY:C911(<>TbLotoNumLaboRapportCampagne;$Identifiant)
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			
			$L:=0
			ARRAY TEXT:C222($TbNomGerme;0)
			ARRAY LONGINT:C221($TbNbAR;0)
			ARRAY LONGINT:C221($TbNbSR;0)
			Repeat 
				$L:=Find in array:C230($TbToutUUIDParticipation;$UUIDCouranteParticipation;($L+1))
				If ($L>0)
					APPEND TO ARRAY:C911($TbNomGerme;$TbToutNomGerme{$l})
					APPEND TO ARRAY:C911($TbNbAR;$TbToutNbAR{$l})
					APPEND TO ARRAY:C911($TbNbSR;$TbToutNbSR{$l})
				End if 
			Until ($L<0)
			
			$L:=Find in array:C230($TbNomGerme;"Bacillus")
			If ($L<0)
				APPEND TO ARRAY:C911(<>TbLotoBacillus;"")
				APPEND TO ARRAY:C911(<>TbLotoBacillusNCGSR;0)
				APPEND TO ARRAY:C911(<>TbLotoBacillusNCGAR;0)
			Else 
				APPEND TO ARRAY:C911(<>TbLotoBacillus;"X")
				APPEND TO ARRAY:C911(<>TbLotoBacillusNCGSR;$TbNbSR{$l})
				APPEND TO ARRAY:C911(<>TbLotoBacillusNCGAR;$TbNbAR{$l})
			End if 
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$L:=Find in array:C230($TbNomGerme;"Pseudomonas")
			If ($L<0)
				APPEND TO ARRAY:C911(<>TbLotoPseudo;"")
				APPEND TO ARRAY:C911(<>TbLotoPseudoNCGSR;0)
				APPEND TO ARRAY:C911(<>TbLotoPseudoNCGAR;0)
			Else 
				APPEND TO ARRAY:C911(<>TbLotoPseudo;"X")
				APPEND TO ARRAY:C911(<>TbLotoPseudoNCGSR;$TbNbSR{$l})
				APPEND TO ARRAY:C911(<>TbLotoPseudoNCGAR;$TbNbAR{$l})
			End if 
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$L:=Find in array:C230($TbNomGerme;"Bacilles lactiques")
			If ($L<0)
				APPEND TO ARRAY:C911(<>TbLotoLactiques;"")
				APPEND TO ARRAY:C911(<>TbLotoLactiquesNCGSR;0)
				APPEND TO ARRAY:C911(<>TbLotoLactiquesNCGAR;0)
			Else 
				APPEND TO ARRAY:C911(<>TbLotoLactiques;"X")
				APPEND TO ARRAY:C911(<>TbLotoLactiquesNCGSR;$TbNbSR{$l})
				APPEND TO ARRAY:C911(<>TbLotoLactiquesNCGAR;$TbNbAR{$l})
			End if 
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$L:=Find in array:C230($TbNomGerme;"Levures moisissures")
			If ($L<0)
				APPEND TO ARRAY:C911(<>TbLotoLevMoisEns;"")
				APPEND TO ARRAY:C911(<>TbLotoLevMoisEnsNCGSR;0)
				APPEND TO ARRAY:C911(<>TbLotoLevMoisEnsNCGAR;0)
			Else 
				APPEND TO ARRAY:C911(<>TbLotoLevMoisEns;"X")
				APPEND TO ARRAY:C911(<>TbLotoLevMoisEnsNCGSR;$TbNbSR{$l})
				APPEND TO ARRAY:C911(<>TbLotoLevMoisEnsNCGAR;$TbNbAR{$l})
			End if 
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$L:=Find in array:C230($TbNomGerme;"Levures + moisissures")
			If ($L<0)
				APPEND TO ARRAY:C911(<>TbLotoLevMoisSep;"")
				APPEND TO ARRAY:C911(<>TbLotoLevMoisSepNCGSR;0)
				APPEND TO ARRAY:C911(<>TbLotoLevMoisSepNCGAR;0)
			Else 
				APPEND TO ARRAY:C911(<>TbLotoLevMoisSep;"X")
				APPEND TO ARRAY:C911(<>TbLotoLevMoisSepNCGSR;$TbNbSR{$l})
				APPEND TO ARRAY:C911(<>TbLotoLevMoisSepNCGAR;$TbNbAR{$l})
			End if 
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$L:=Find in array:C230($TbNomGerme;"Campylobacter dénombrement")
			If ($L<0)
				APPEND TO ARRAY:C911(<>TbLotoCampyloDen;"")
				APPEND TO ARRAY:C911(<>TbLotoCampyloDenNCGSR;0)
				APPEND TO ARRAY:C911(<>TbLotoCampyloDenNCGAR;0)
			Else 
				APPEND TO ARRAY:C911(<>TbLotoCampyloDen;"X")
				APPEND TO ARRAY:C911(<>TbLotoCampyloDenNCGSR;$TbNbSR{$l})
				APPEND TO ARRAY:C911(<>TbLotoCampyloDenNCGAR;$TbNbAR{$l})
			End if 
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
			
			$L:=Find in array:C230($TbNomGerme;"Campylobacter recherche")
			If ($L<0)
				APPEND TO ARRAY:C911(<>TbLotoCampyloChe;"")
				APPEND TO ARRAY:C911(<>TbLotoCampyloCheNCGSR;0)
				APPEND TO ARRAY:C911(<>TbLotoCampyloCheNCGAR;0)
			Else 
				APPEND TO ARRAY:C911(<>TbLotoCampyloChe;"X")
				APPEND TO ARRAY:C911(<>TbLotoCampyloCheNCGSR;$TbNbSR{$l})
				APPEND TO ARRAY:C911(<>TbLotoCampyloCheNCGAR;$TbNbAR{$l})
			End if 
			If ($Fumé+$Salé=2)
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
				APPEND TO ARRAY:C911($TbPropriétéArgument;"")
			End if 
		End for 
	End for 
	
	SORT ARRAY:C229(<>TbLotoIdentifiantParticipation;<>TbLotoNumLaboRapportCampagne;<>TbLotoNumLaboRAEMA;<>TbLotoUUIDLabo;<>TbLotoAssociation;<>TbLotoNumCampagne;<>TbLotoTransporteur;<>TbLotoBoiteIsotherme;<>TbLotoSansPathogene;<>TbLotoCodeRaemaLié;<>TbLotoNbColisPoudreSR;<>TbLotoNbColisPoudreAR;<>TbLotoNumBonCommandePoudre;<>TbLotoProformaPoudre;<>TbLotoNumBonCommandeGel;<>TbLotoProformaGel;<>TbLotoBacillus;<>TbLotoPseudo;<>TbLotoLactiques;<>TbLotoLevMoisEns;<>TbLotoLevMoisSep;<>TbLotoCampyloDen;<>TbLotoCampyloChe;<>TbLotoBacillusNCGSR;<>TbLotoPseudoNCGSR;<>TbLotoLactiquesNCGSR;<>TbLotoLevMoisEnsNCGSR;<>TbLotoLevMoisSepNCGSR;<>TbLotoCampyloDenNCGSR;<>TbLotoCampyloCheNCGSR;<>TbLotoBacillusNCGAR;<>TbLotoPseudoNCGAR;<>TbLotoLactiquesNCGAR;<>TbLotoLevMoisEnsNCGAR;<>TbLotoLevMoisSepNCGAR;<>TbLotoCampyloDenNCGAR;<>TbLotoCampyloCheNCGAR;<>TbLotoUUIDParticipation;<>TbLotoNumEnrParticipation;>)
	
	  // FIXER TEXTE DANS CONTENEUR(ZTableauVersTexte(->$TbPropriétéArgument))
	
	If ($MCE)  // Il demande à mettre le tableau dans le PP
		
		$ET:="<>TbLotoUUIDLabo"+<>ZTab+"<>TbLotoNumLaboRAEMA"+<>ZTab+"<>TbLotoNumCampagne"+<>ZTab+"<>TbLotoIdentifiantParticipation"+<>ZTab+"<>TbLotoNumLaboRapportCampagne"+<>ZTab+"<>TbLotoAssociation"+<>ZTab+"<>TbLotoTransporteur"+<>ZTab+"<>TbLotoBoiteIsotherme"
		$ET:=$ET+<>ZTab+"<>TbLotoSansPathogene"+<>ZTab+"<>TbLotoNumBonCommandePoudre"+<>ZTab+"<>TbLotoProformaPoudre"+<>ZTab+"<>TbLotoCodeRaemaLié"+<>ZTab+"<>TbLotoNbColisPoudreSR"+<>ZTab+"<>TbLotoNbColisPoudreAR"
		$ET:=$ET+<>ZTab+"<>TbLotoNumBonCommandeGel"+<>ZTab+"<>TbLotoProformaGel"+<>ZTab+"<>TbLotoBacillus"+<>ZTab+"<>TbLotoBacillusNCGSR"+<>ZTab+"<>TbLotoBacillusNCGAR"+<>ZTab+"<>TbLotoPseudo"+<>ZTab+"<>TbLotoPseudoNCGSR"+<>ZTab+"<>TbLotoPseudoNCGAR"
		$ET:=$ET+<>ZTab+"<>TbLotoLactiques"+<>ZTab+"<>TbLotoLactiquesNCGSR"+<>ZTab+"<>TbLotoLactiquesNCGAR"
		$ET:=$ET+<>ZTab+"<>TbLotoLevMoisEns"+<>ZTab+"<>TbLotoLevMoisEnsNCGSR"+<>ZTab+"<>TbLotoLevMoisEnsNCGAR"+<>ZTab+"<>TbLotoLevMoisSep"+<>ZTab+"<>TbLotoLevMoisSepNCGSR"+<>ZTab+"<>TbLotoLevMoisSepNCGAR"
		$ET:=$ET+<>ZTab+"<>TbLotoCampyloDen"+<>ZTab+"<>TbLotoCampyloDenNCGSR"+<>ZTab+"<>TbLotoCampyloDenNCGAR"+<>ZTab+"<>TbLotoCampyloChe"+<>ZTab+"<>TbLotoCampyloCheNCGSR"+<>ZTab+"<>TbLotoCampyloCheNCGAR"
		$ET:=$ET+<>ZTab+"<>TbLotoUUIDParticipation"+<>ZTab+"<>TbLotoNumEnrParticipation"+<>ZCR
		
		$ET:=$ET+"Propriété de l'argument"+<>ZTab+""+<>ZTab+""+<>ZTab+""+<>ZTab+""+<>ZTab+""+<>ZTab+"Transporteur"+<>ZTab+"BoîteIsotherme"+<>ZTab+"SansPathogene"+<>ZTab+"NumBonCommandePoudre"+<>ZTab+"Proforma"+<>ZTab+"CodeRaemaLié"
		$ET:=$ET+<>ZTab+"NbreColisSupSansRapport"+<>ZTab+"NbreColisSupAvecRapport"+<>ZTab+"NumBonCommandeGel"+<>ZTab+"RGProforma"+(22*(<>ZTab+""))+<>ZCR
		
		$ET:=$ET+"UUID labo"+<>ZTab+"N° labo"+<>ZTab+"N° campagne"+<>ZTab+"Identifiant de Participation"+<>ZTab+"N° de labo Raema lié + campagne"+<>ZTab+"Association"+<>ZTab+"Transporteur"+<>ZTab+"Boîte isotherme"
		$ET:=$ET+<>ZTab+"Sans pathogène"+<>ZTab+"Num Bon Commande Poudre"+<>ZTab+"Proforma Poudre"+<>ZTab+"Code Raema Lié"+<>ZTab+"Nb Colis Poudre SR"+<>ZTab+"Nb Colis Poudre AR"
		$ET:=$ET+<>ZTab+"Num Bon Commande Gel"+<>ZTab+"Proforma Gel"+<>ZTab+"Bacillus"+<>ZTab+"Bacillus SR"+<>ZTab+"Bacillus AR"+<>ZTab+"Pseudomonas"+<>ZTab+"Pseudomonas SR"+<>ZTab+"Pseudomonas AR"
		$ET:=$ET+<>ZTab+"Lactiques"+<>ZTab+"Lactiques SR"+<>ZTab+"Lactiques AR"
		$ET:=$ET+<>ZTab+"Lev-Mois Ens"+<>ZTab+"Lev-Mois Ens SR"+<>ZTab+"Lev-Mois Ens AR"+<>ZTab+"Lev-Mois Sep"+<>ZTab+"Lev-Mois Sep SR"+<>ZTab+"Lev-Mois Sep AR"
		$ET:=$ET+<>ZTab+"Campylobacter Recherche"+<>ZTab+"Campylobacter Recherche SR"+<>ZTab+"Campylobacter Recherche AR"+<>ZTab+"Campylobacter Dénombrement"+<>ZTab+"Campylobacter Dénombrement SR"+<>ZTab+"Campylobacter Dénombrement AR"+<>ZTab+"UUID Participation"+<>ZCR
		$Rapport:=$ET
		$FT:=Size of array:C274(<>TbLotoUUIDLabo)
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+<>TbLotoUUIDLabo{$Salé}+<>ZTab+String:C10(<>TbLotoNumLaboRAEMA{$Salé})+<>ZTab+<>TbLotoNumCampagne{$Salé}+<>ZTab+<>TbLotoIdentifiantParticipation{$Salé}+<>ZTab+<>TbLotoNumLaboRapportCampagne{$Salé}+<>ZTab+<>TbLotoAssociation{$Salé}+<>ZTab+<>TbLotoTransporteur{$Salé}+<>ZTab+String:C10(<>TbLotoBoiteIsotherme{$Salé})+<>ZTab
			$Rapport:=$Rapport+String:C10(<>TbLotoSansPathogene{$Salé})+<>ZTab+<>TbLotoNumBonCommandePoudre{$Salé}+<>ZTab+<>TbLotoProformaPoudre{$Salé}+<>ZTab+<>TbLotoCodeRaemaLié{$Salé}+<>ZTab+String:C10(<>TbLotoNbColisPoudreSR{$Salé})+<>ZTab+String:C10(<>TbLotoNbColisPoudreAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoNumBonCommandeGel{$Salé}+<>ZTab+<>TbLotoProformaGel{$Salé}+<>ZTab+<>TbLotoBacillus{$Salé}+<>ZTab+String:C10(<>TbLotoBacillusNCGSR{$Salé})+<>ZTab+String:C10(<>TbLotoBacillusNCGAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoPseudo{$Salé}+<>ZTab+String:C10(<>TbLotoPseudoNCGSR{$Salé})+<>ZTab+String:C10(<>TbLotoPseudoNCGAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoLactiques{$Salé}+<>ZTab+String:C10(<>TbLotoLactiquesNCGSR{$Salé})+<>ZTab+String:C10(<>TbLotoLactiquesNCGAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoLevMoisEns{$Salé}+<>ZTab+String:C10(<>TbLotoLevMoisEnsNCGSR{$Salé})+<>ZTab+String:C10(<>TbLotoLevMoisEnsNCGAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoLevMoisSep{$Salé}+<>ZTab+String:C10(<>TbLotoLevMoisSepNCGSR{$Salé})+<>ZTab+String:C10(<>TbLotoLevMoisSepNCGAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoCampyloDen{$Salé}+<>ZTab+String:C10(<>TbLotoCampyloDenNCGSR{$Salé})+<>ZTab+String:C10(<>TbLotoCampyloDenNCGAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoCampyloChe{$Salé}+<>ZTab+String:C10(<>TbLotoCampyloCheNCGSR{$Salé})+<>ZTab+String:C10(<>TbLotoCampyloCheNCGAR{$Salé})+<>ZTab
			$Rapport:=$Rapport+<>TbLotoUUIDParticipation{$Salé}+<>ZTab+String:C10(<>TbLotoNumEnrParticipation{$Salé})+<>ZCR
		End for 
		SET TEXT TO PASTEBOARD:C523($Rapport)
	End if 
	$H2:=Milliseconds:C459
	  // ALERTE(Chaîne($H2-$H1))
	
	If (Application type:C494=4D Server:K5:6)  // MAJ des clients inscrits
		EXECUTE ON CLIENT:C651("@";$NomMéthodeMAJ)
	End if 
	
End if 
