//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 17/08/19, 11:37:07
  // ----------------------------------------------------
  // Méthode : ASAPLaboImprimeProforma
  // Description
  //   Méthode qui imprime les proforma de la selection
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)

  //CRÉER SELECTION SUR TABLEAU([CampagneParticipations];TbNumEnr)
  //JOINTURE([CampagneParticipations];[Personnes])
  //CHERCHER PAR ATTRIBUT DANS SÉLECTION([Personnes];[Personnes]Arguments;"Proforma";"#";Null)

  // initialisation des tableaux des laboratoires avec Proforma
ARRAY TEXT:C222(TbNomLaboratoire;0)
ARRAY LONGINT:C221(TbNumLabo;0)
ARRAY TEXT:C222(TbProformaLabo;0)
ARRAY TEXT:C222(TbPoidsColis;0)
ARRAY TEXT:C222(TbDimensionColis;0)
ARRAY TEXT:C222(TbUUIDLabo;0)

  // Cherchons les colis qui ont une valeur dans TbProforma
$TT:=Size of array:C274(TbProforma)
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=TbNumCampagne{1})
VarDate:=[RAEMACampagnes:20]DateEnvoiColis:3
For ($Salé;1;$TT)
	$L:=Find in array:C230(<>TbPerNumLaboRAEMA;TbNumLaboN{$Salé})  // Rang dans tableaux généraux personnes
	$identifiantParticipation:=String:C10(TbNumLaboN{$Salé})+"_"+TbNumCampagne{$Salé}+"_"
	$LP:=Find in array:C230(<>TbLotoIdentifiantParticipation;$identifiantParticipation)  // Rang dans tableaux généraux participation
	If (TbProforma{$Salé}#"") & (<>TbPAAssociation{$L}#"LRAR-M")
		APPEND TO ARRAY:C911(TbNomLaboratoire;TbNomLabo{$Salé})
		APPEND TO ARRAY:C911(TbNumLabo;TbNumLaboN{$Salé})
		APPEND TO ARRAY:C911(TbProformaLabo;TbProforma{$Salé})
		APPEND TO ARRAY:C911(TbUUIDLabo;<>TBPerUUID{$L})
		
		Case of 
			: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=0)  // si pas isotherme et pas de colis sup = 1 Kg     24 cm x 24 cm x 10 cm
				$Poids:="1 Kg"
				$Dimensions:="24cm x 24cm x 10cm"
				
			: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=1)  // si pas isotherme et 1 colis sup = 3 Kg     25 cm x 25 cm x 25 cm
				$Poids:="3 Kg"
				$Dimensions:="25cm x 25cm x 25cm"
				
			: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=2)  // si pas isotherme et 2 colis sup = 3 Kg    30 cm x 30 cm x 30 cm
				$Poids:="3 Kg"
				$Dimensions:="30cm x 30cm x 30cm"
				
			: (<>TbLotoBoiteIsotherme{$LP}>0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=0)  // si isotherme  = 10 Kg     386 mm x 376 mm x 337 mm
				$Poids:="10 Kg"
				$Dimensions:="386mm x 376mm x 337mm"
				
			: (<>TbPAAssociation{$L}="ASA - LRAR-M")  // si "Marocain"  = 6 Kg     45 cm x 37 cm x 25 cm
				$Poids:="6 Kg"
				$Dimensions:="45cm x 37cm x 25cm"
				
			Else 
				
				$Poids:=""
				$Dimensions:=""
		End case 
		
		APPEND TO ARRAY:C911(TbPoidsColis;$Poids)
		APPEND TO ARRAY:C911(TbDimensionColis;$Dimensions)
		
	End if 
End for 


PRINT SETTINGS:C106
If (OK=1)
	ZFenetreModaleAuCentre (500;500)
	DIALOG:C40("DlgProforma")
	
	If (BouImp=1)
		$NumCampagne:=PUMNumCampagneSuivi{PUMNumCampagneSuivi}
		$TypeRaema:=(Num:C11($NumCampagne="@a")*"Gel")+(Num:C11($NumCampagne#"@a")*"Poudre")
		$FT:=Size of array:C274(TbDimensionColis)
		For ($Salé;1;$FT)
			$OI:=True:C214
			$L:=Find in array:C230(TbNumLaboN;TbNumLabo{$Salé})
			$Formulaire:=TbProforma{$L}
			
			Case of 
				: ($Formulaire="Facture") | ($Formulaire="Commercial")
					$Format:="FacCom"
					
				: ($Formulaire="Proforma")
					$Format:="Proforma"+$TypeRaema
					
				Else 
					$OI:=False:C215
			End case 
			
			If ($OI)
				VarPoids:=TbPoidsColis{$Salé}
				VarDim:=TbDimensionColis{$Salé}
				QUERY:C277([Personnes:12];[Personnes:12]UUID:1=TbUUIDLabo{$Salé})
				$H:=Print form:C5([Personnes:12];$Format)
			End if 
			
			NEXT RECORD:C51([Personnes:12])
		End for 
	End if 
End if 

