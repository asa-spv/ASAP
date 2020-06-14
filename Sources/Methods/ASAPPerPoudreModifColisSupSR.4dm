//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/08/19, 05:41:28
  // ----------------------------------------------------
  // Méthode : ASAPPerPoudreModifColisSupSR
  // Description
  // Méthode qui ajuste des [CampagneParticipations]
  //   en fonction du nombre demandé 
  //   de colis supplémentaire avec rapport

C_POINTER:C301($PtObjetCourant;$Pt)
C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($CampagneCourante)

$PtObjetCourant:=OBJECT Get pointer:C1124(Objet courant:K67:2)
RESOLVE POINTER:C394($PtObjetCourant;$NomVariable;$T;$C)
If ($NomVariable="@octobre@")
	$Mois:="Octobre"
Else 
	$Mois:="Mars"
End if 
$Pt:=Get pointer:C304("Campagne"+$Mois)
$CampagneCourante:=$Pt->
$PtSR:=Get pointer:C304("Var"+$Mois+"PSR")
READ WRITE:C146([CampagneParticipations:17])
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$CampagneCourante;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
$FT:=Records in selection:C76([CampagneParticipations:17])
For ($Salé;1;$FT)
	If ($PtSR->=0)
		OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"NbreColisSupSansRapport")
	Else 
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"NbreColisSupSansRapport";$PtSR->)
	End if 
	SAVE RECORD:C53([CampagneParticipations:17])
	NEXT RECORD:C51([CampagneParticipations:17])
End for 
ZAmnistiePartielle (->[CampagneParticipations:17])