//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/02/16, 07:13:51
  // ----------------------------------------------------
  // Méthode : RaemaInitPUMCampagne
  // Description
  // Initialise 
  // <>NumCampagneEnCoursSaisie = le n° du RAEMA en saisie 
  // en tenant compte des tests 10 j avant
  // $NumCampagneEnCoursInfo et <>NumCampagneEnCoursInfoOK
  // = n° du RAEMA traditionnel 
  //avec information de contamination
  // <>NumCampagneEnCoursRecup 
  //= n° du RAEMA en cours de récupération des rapports
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)

$NomMéthodeCourante:=Current method name:C684
$NomMéthodeMAJ:=$NomMéthodeCourante+"MAJ"
If (<>ZClient) & (Count parameters:C259=0)
	$Prc:=Execute on server:C373($NomMéthodeCourante;0)
Else 
	ASAPInitTbPUMCampagne 
	
	
	READ WRITE:C146([RAEMACampagnes:20])
	  //les fiches de [XDonnées] où l'on note les caractéritiques des campagnes
	ALL RECORDS:C47([RAEMACampagnes:20])
	CREATE SET:C116([RAEMACampagnes:20];"Rae")
	
	
	  // Restriction du nombre des RAEMA aux plus récents
	$DateMin:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)-1))
	QUERY:C277([RAEMACampagnes:20]; & [RAEMACampagnes:20]DateEnvoiColis:3>$DateMin)
	  // Fabrication du PUM
	SELECTION TO ARRAY:C260([RAEMACampagnes:20]NumCampagne:2;<>PUMCampagne)
	SORT ARRAY:C229(<>PUMCampagne;<)
	If (Size of array:C274(<>PUMCampagne)>0)
		SELECTION TO ARRAY:C260([RAEMACampagnes:20]NumCampagne:2;$TbNumCamapgne;[RAEMACampagnes:20]DateEnvoiColis:3;$TbDate;[RAEMACampagnes:20]DateMiseEnLigne:5;$TbDateRapport)
		SORT ARRAY:C229($TbDate;$TbNumCamapgne;$TbDateRapport;<)
		$FT:=Size of array:C274($TbNumCamapgne)
		
		  // détermination des RAEMA en cours de saisie NumCampagneCourante et de recupération des rapports
		
		$NumDerRaema:=$TbNumCamapgne{1}
		$NumCampagneEnCoursRecup:=""
		$CampagneEnCoursSaisieAFaire:=True:C214  // permet de sortir au premier Raema OK
		For ($Salé;1;$FT)
			If ($TbDateRapport{$Salé}#!00-00-00!) & ($NumCampagneEnCoursRecup="")
				$NumCampagneEnCoursRecup:=$TbNumCamapgne{$Salé}
			End if 
			
			If ($TbDate{$Salé}<(Current date:C33+15)) & ($NumDerRaema=$TbNumCamapgne{1}) & ($CampagneEnCoursSaisieAFaire)  // 15 jours avant pour permettre les tests
				$NumDerRaema:=$TbNumCamapgne{$Salé}
				$CampagneEnCoursSaisieAFaire:=False:C215
			End if 
		End for 
		  // <>NumCampagneEnCoursSaisie:=$NumDerRaema
		<>NumCampagneEnCoursSaisie:="70A"
		
		  // Recherche des tableaux de traduction
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursSaisie)
		ARRAY TEXT:C222(<>TbF;0)
		ARRAY TEXT:C222(<>TbA;0)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbF";<>TbF)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbA";<>TbA)
		
		
		<>CampagneEnCoursRP:=(<>NumCampagneEnCoursSaisie#"@a")
		<>NumCampagneEnCoursRecup:=$NumCampagneEnCoursRecup
		
		  // initialisation du dernier RAEMA poudre saisi
		If ($NumDerRaema#"@A")  //  le dernier est un RAEMA Poudre"
			$NumCampagneEnCoursInfo:=$NumDerRaema  // l'information a lieu rapidement après la cloture
		Else   // le dernier est un RAEMA Gel
			$NumCampagneEnCoursInfo:=Replace string:C233($NumDerRaema;"A";"")  // On prend le dernier RAEMA Poudre
		End if 
		
		  // initialisation du dernier RAEMA poudre avec information de contamination
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagneEnCoursInfo)
		$NumEch:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"N° des échantillons";Est un texte:K8:3)
		$Contamination:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)
		If ($NumEch#"") & (Length:C16($Contamination)>60)
			<>NumCampagneEnCoursInfoOK:=$NumCampagneEnCoursInfo
		Else 
			<>NumCampagneEnCoursInfoOK:=String:C10(Num:C11($NumCampagneEnCoursInfo)-1)
		End if 
		
		  // Calcul du menu local des années des raema affichés dans [Personnes];"SaisieLabo"
		$FT:=Size of array:C274(<>PUMCampagne)
		For ($Salé;1;$FT)
			$AnCampagneCourante:=String:C10(RaemaTrouveAnParNumCampagne (<>PUMCampagne{$Salé}))
			If (Find in array:C230(<>PUMAnRaemaPoudre;$AnCampagneCourante)<0)
				APPEND TO ARRAY:C911(<>PUMAnRaemaPoudre;$AnCampagneCourante)
			End if 
		End for 
		SORT ARRAY:C229(<>PUMAnRaemaPoudre;<)  // Les plus récentes en haut
		
	End if 
	If (Application type:C494=4D Server:K5:6)  // MAJ des clients inscrits
		EXECUTE ON CLIENT:C651("@";$NomMéthodeMAJ)
	End if 
	
End if 
