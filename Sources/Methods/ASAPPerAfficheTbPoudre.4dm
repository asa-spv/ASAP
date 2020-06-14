//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 15/08/19, 17:42:51
  // ----------------------------------------------------
  // Méthode : ASAPPerAfficheTbPoudre
  // Description
  // Méthode qui remplit les carctéristiques de chaque campagne
  //   affiché dans l'écran 3 de [Personnes];"SaisieLabo"
  // Paramètre : $1 = "Mars" ou "Octobre"
  // ----------------------------------------------------
C_LONGINT:C283($BoiteIsotherme)
$Mois:=$1
$Pt:=Get pointer:C304("Campagne"+$Mois)
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$Pt->;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
$TT:=Records in selection:C76([CampagneParticipations:17])

  // Le bon de commande
VarNumBdC:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"NumBonCommandePoudre";Est un texte:K8:3)

  // La case de participation
$Pt:=Get pointer:C304("CaC"+$Mois+"OK")
$Pt->:=Num:C11($TT>0)  // MAJ de la case de participation (CaCMarsOK ou CaCOctobreOK)
If ($TT>0)  // Il existe au moins 1 participation
	
	  // Nbre de colis avec (VarMarsPAR ou VarOctPAR) ou sans (VarMarsPSR ou VarOctPSR) rapport
	  // AVEC rapport
	$Pt:=Get pointer:C304("Var"+$Mois+"PAR")
	$Pt->:=$TT-1
	
	  // SANS rapport
	$Pt:=Get pointer:C304("Var"+$Mois+"PSR")
	$Pt->:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"NbreColisSupSansRapport";Est un entier long:K8:6)
	
	  // La boite isotherme
	$BoiteIsotherme:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"BoîteIsotherme";Est un entier long:K8:6)
	$Pt:=Get pointer:C304("PUM"+$Mois+"Boite")
	$Pt->:=$BoiteIsotherme+1  // remise sur la bonne ligne
	
	  // les sans pathogènes
	$SansPathogene:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"SansPathogene";Est un booléen:K8:9)
	If ($SansPathogene=False:C215)
		$SansPathogene:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogene";Est un booléen:K8:9)
	End if 
	$Pt:=Get pointer:C304("CaC"+$Mois+"SP")
	$Pt->:=Num:C11($SansPathogene)
	
	  // le transporteur
	$Pt:=Get pointer:C304("Var"+$Mois+"Transport")
	$Pt->:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"Transporteur";Est un texte:K8:3)
	If ($Pt->="")
		$Pt->:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis";Est un texte:K8:3)
	End if 
	
	  // les N° de laboratoires associés aux colis supplémentaire avec rapport
	ARRAY OBJECT:C1221($TbArgument;0)
	SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5;$TbArgument)
	$Pt:=Get pointer:C304("Var"+$Mois+"NRL")
	$Pt->:=""
	If ($TT>1)  // Il y a plusieurs participations pour ce laboratoire = colis avec rapport
		For ($Salé;1;$TT)
			$NumLié:=OB Get:C1224($TbArgument{$Salé};"CodeRaemaLié";Est un texte:K8:3)
			If ($NumLié#"")
				$Pt->:=$Pt->+","+String:C10(RAEMADemoduleMdPWeb ($NumLié))
			End if 
		End for 
		If ($Pt->#"")
			$Pt->:=Substring:C12($Pt->;2)  // élimination du premier ","
		End if 
	End if 
	OBJECT SET VISIBLE:C603(*;"Var"+$Mois+"NRL@";($Pt->#""))
Else   // pas de campagne 
	
	If ($Mois="Mars")  // en mars
		VarMarsPAR:=0
		VarMarsPSR:=0
		PUMMarsBoite:=0
		CaCMarsSP:=0
		VarMarsTransport:=""
		VarMarsNRL:=""
	Else   // en octobre
		VarOctobrePAR:=0
		VarOctobrePSR:=0
		PUMOctobreBoite:=0
		CaCOctobreSP:=0
		VarOctobreTransport:=""
		VarOctobreNRL:=""
		OBJECT SET VISIBLE:C603(*;"VarOctobreNRL@";False:C215)
	End if 
End if 
OBJECT SET VISIBLE:C603(*;($Mois+"@");($TT>0))
If ($Mois="Mars")
	OBJECT SET VISIBLE:C603(*;"MarsNRL@";(VarMarsPAR>0))
Else 
	OBJECT SET VISIBLE:C603(*;"OctobreNRL@";(VarOctobrePAR>0))
End if 