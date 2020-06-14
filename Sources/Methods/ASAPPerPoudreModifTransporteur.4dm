//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/08/19, 05:54:56
  // ----------------------------------------------------
  // Méthode : ASAPPerPoudreModifTransporteur
  // Description
  // Méthode qui ajuste des [CampagneParticipations]
  //   en fonction du type du nom du transporteur

C_POINTER:C301($PtObjetCourant;$Pt)
C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($CampagneCourante)

$PtObjetCourant:=OBJECT Get pointer:C1124(Objet courant:K67:2)
$NomVariable:=OBJECT Get name:C1087(Objet courant:K67:2)
  // RÉSOUDRE POINTEUR($PtObjetCourant;$NomVariable;$T;$C)
If ($NomVariable="@octobre@")
	$Mois:="Octobre"
Else 
	$Mois:="Mars"
End if 
$Pt:=Get pointer:C304("Campagne"+$Mois)
$CampagneCourante:=$Pt->

$NomTransporteur:=PUMTransporteur{PUMTransporteur}
READ WRITE:C146([CampagneParticipations:17])
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$CampagneCourante;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
$FT:=Records in selection:C76([CampagneParticipations:17])
For ($Salé;1;$FT)
	If (VarMarsTransport#"")
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"Transporteur";$NomTransporteur)
	Else 
		OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"Transporteur")
	End if 
	SAVE RECORD:C53([CampagneParticipations:17])
End for 
$Pt:=Get pointer:C304("Var"+$Mois+"Transport")
$Pt->:=$NomTransporteur
ZAmnistiePartielle (->[CampagneParticipations:17])