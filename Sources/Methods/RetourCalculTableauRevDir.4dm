//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 10/03/17, 15:11:10
  // ----------------------------------------------------
  // Méthode : RetourCalculTableauRevDir
  // Description
  // Permet de calculer les VarTbRevDirs des tableaux 
  // de la revue de direction
  // Paramètre {$1} si existe ligne du tableau PumDomaine sinon
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$Fumé;$FT)

RetourInitVarTbRevDir 
For ($Salé;1;4)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=TbPointeur{$salé}->)
	SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDLabo)
	$FT:=Size of array:C274($TbUUIDLabo)
	ARRAY TEXT:C222($TbNouvParticip;$FT)
	For ($Fumé;1;$FT)
		$TbNouvParticip{$Fumé}:=ASAPTrouveNumeroLaboParUUID ($TbUUIDLabo{$Fumé};True:C214)
	End for 
	
	$FT:=Size of array:C274($TbNouvParticip)
	$Pt:=Get pointer:C304("VarTbRevDir"+String:C10($salé+4))
	$Pt->:=$Ft
End for 

  // Calcul nombre de fiche contact
For ($salé;1;4)
	QUERY:C277([RetoursFiches:24];[RetoursFiches:24]Campagne:7%TbPointeur{$salé}->)
	If (Count parameters:C259=1)
		QUERY SELECTION:C341([RetoursFiches:24];[RetoursFiches:24]Domaine:6=PumDomaine{$1})
	End if 
	$Pt:=Get pointer:C304("VarTbRevDir"+String:C10($salé+8))
	$Pt->:=Records in selection:C76([RetoursFiches:24])
	CREATE SET:C116([RetoursFiches:24];"Retourfiches")
	QUERY SELECTION:C341([RetoursFiches:24];[RetoursFiches:24]TypeRetour:5="Ret@")
	$Pt:=Get pointer:C304("VarTbRevDir"+String:C10($salé+12))
	$Pt->:=Records in selection:C76([RetoursFiches:24])
	USE SET:C118("Retourfiches")
	QUERY SELECTION:C341([RetoursFiches:24];[RetoursFiches:24]TypeRetour:5="Dem@")
	$Pt:=Get pointer:C304("VarTbRevDir"+String:C10($salé+16))
	$Pt->:=Records in selection:C76([RetoursFiches:24])
	USE SET:C118("Retourfiches")
	QUERY SELECTION:C341([RetoursFiches:24];[RetoursFiches:24]TypeRetour:5="Rec@")
	$Pt:=Get pointer:C304("VarTbRevDir"+String:C10($salé+20))
	$Pt->:=Records in selection:C76([RetoursFiches:24])
End for 

  // calcul des évolutions
VarTbRevDir25:=Round:C94(((VarTbRevDir5+VarTbRevDir6)/(VarTbRevDir7+VarTbRevDir8)*100);2)
VarTbRevDir26:=Round:C94(((VarTbRevDir9+VarTbRevDir10)/(VarTbRevDir11+VarTbRevDir12)*100);2)
VarTbRevDir27:=Round:C94(((VarTbRevDir13+VarTbRevDir14)/(VarTbRevDir15+VarTbRevDir16)*100);2)
VarTbRevDir28:=Round:C94(((VarTbRevDir17+VarTbRevDir18)/(VarTbRevDir19+VarTbRevDir20)*100);2)
VarTbRevDir29:=Round:C94(((VarTbRevDir24+VarTbRevDir22)/(VarTbRevDir23+VarTbRevDir24)*100);2)