//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/07/18, 09:25:44
  // ----------------------------------------------------
  // Méthode : GAFabriqueTableauRaemaPoudre
  // Description
  // Permet de gérer les différents élements 
  //   du RAEMA poudre
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
C_BOOLEAN:C305($SP)


  // Le modèle de Proforma
PUMProforma:=1  // pas de modèle a priori
$Proforma:=OB Get:C1224([Personnes:12]Arguments:7;"Proforma";Est un texte:K8:3)
If ($Proforma#"")
	PUMProforma:=Find in array:C230(PUMProforma;$Proforma)
End if 


  // Le n° de la campagne
$AnCourantA:=<>PUMAnRaemaPoudre{<>PUMAnRaemaPoudre}
$AnCourantN:=Num:C11($AnCourantA)

  // Initialisation des noms des campagnes déduits du menu local <>PUMAnRaemaPoudre
CampagneMars:=RaemaTrouveNumCampagneParAn ($AnCourantN)
  // Accessibilité de la campagne de mars en modification
$L:=Find in array:C230(<>TbCampagnesNumCampagne;CampagneMars)
$DateLimiterésultats:=<>TbCampagnesDateLimiteReponse{$L}
OBJECT SET VISIBLE:C603(Tartuffe1;($DateLimiterésultats<=Current date:C33))  // Bouton invisible en avant p^lan

CampagneOctobre:=RaemaTrouveNumCampagneParAn ($AnCourantN;3)
  // Accessibilité de la campagne d'octobre en modification
$L:=Find in array:C230(<>TbCampagnesNumCampagne;CampagneOctobre)
$DateLimiterésultats:=<>TbCampagnesDateLimiteReponse{$L}
OBJECT SET VISIBLE:C603(Tartuffe2;($DateLimiterésultats<=Current date:C33))

  // Les titres des pavés
OBJECT SET TITLE:C194(*;"ZdGMars";"Mars : RAEMA "+CampagneMars)
OBJECT SET TITLE:C194(*;"ZdGOctobre";"Octobre : RAEMA "+CampagneOctobre)



  // MARS
ASAPPerAfficheTbPoudre ("Mars")
  // OCTOBRE
ASAPPerAfficheTbPoudre ("Octobre")


If (False:C215)
	
	CaCOctobreOK:=Num:C11($LigneOctobre>0)
	If (CaCOctobreOK=1)
		VarOctobrePAR:=Num:C11(WebTrouveValeurParNom ($TestOctobre;-><>TbLotoIdentifiantParticipation;-><>TbLotoNbColisPoudreAR))
		VarOctobrePSR:=Num:C11(WebTrouveValeurParNom ($TestOctobre;-><>TbLotoIdentifiantParticipation;-><>TbLotoNbColisPoudreSR))
		If (VarNumBdC="")
			VarNumBdC:=WebTrouveValeurParNom ($TestOctobre;-><>TbLotoIdentifiantParticipation;-><>TbLotoNumBonCommandePoudre)
		End if 
		$LignePUM:=<>TbLotoBoiteIsotherme{$LigneOctobre}+1
		PUMOctobreBoite:=$LignePUM
		$CaCOctobreSP:=WebTrouveValeurParNom ($TestOctobre;-><>TbLotoIdentifiantParticipation;-><>TbLotoSansPathogene)
		CaCOctobreSP:=Num:C11($CaCOctobreSP)
		If (CaCOctobreSP=0)
			$SP:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogenes";Est un booléen:K8:9)
			CaCOctobreSP:=Num:C11($SP)
		End if 
		VarOctobreTransport:=WebTrouveValeurParNom ($TestOctobre;-><>TbLotoIdentifiantParticipation;-><>TbLotoTransporteur)
		If (VarOctobreTransport="")
			VarOctobreTransport:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis";Est un texte:K8:3)
		End if 
		
		
		VarOctobreNRL:=""
		If ($LigneOctobre<Size of array:C274(<>TbLotoIdentifiantParticipation))
			$OC:=True:C214
			$ID:=<>TbLotoIdentifiantParticipation{$LigneOctobre+1}
			While ($ID=$TestOctobre) & ($OC)
				$Pos:=Position:C15("_";$ID)
				$MdPLaboRL:=Substring:C12($ID;($Pos+1))
				$Pos:=Position:C15("_";$MdPLaboRL)
				$MdPLaboRL:=Substring:C12($MdPLaboRL;($Pos+1))
				VarNumLaboRAEMARL:=String:C10(RAEMADemoduleMdPWeb ($MdPLaboRL))
				VarOctobreNRL:=VarOctobreNRL+", "+VarNumLaboRAEMARL
				$LigneOctobre:=$LigneOctobre+1
				If ($LigneOctobre<Size of array:C274(<>TbLotoIdentifiantParticipation))
					$ID:=<>TbLotoIdentifiantParticipation{$LigneOctobre+1}
				Else 
					$OC:=False:C215
				End if 
			End while 
			If (VarOctobreNRL#"")
				VarOctobreNRL:=Substring:C12(VarOctobreNRL;3)  // élimination du premier ", "
			End if 
		End if 
		
		
	Else   // pas de campagne en Octobre
		VarOctobrePAR:=0
		VarOctobrePSR:=0
		PUMOctobreBoite:=0
		CaCOctobreSP:=0
		VarOctobreTransport:=""
		VarOctobreNRL:=""
	End if 
	
	OBJECT SET VISIBLE:C603(*;"VarOctobreNRL@";(VarOctobreNRL#""))
	OBJECT SET VISIBLE:C603(*;"Octobre@";($LigneOctobre>0))
	
End if 