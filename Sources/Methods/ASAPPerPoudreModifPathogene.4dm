//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/08/19, 05:24:34
  // ----------------------------------------------------
  // Méthode : ASAPPerPoudreModifPathogene
  // Description
  //   Méthode qui gère la modification d'un envoi sans pathogène
  //   par un clic sur la boîte à cocher CaCMarsSP ou CaCOctobreSP
  // ----------------------------------------------------
C_TEXT:C284($NumCampagne)

$PtObjetCourant:=OBJECT Get pointer:C1124(Objet courant:K67:2)
RESOLVE POINTER:C394($PtObjetCourant;$NomVariable;$T;$C)
If ($NomVariable="@octobre@")
	$Mois:="Octobre"
Else 
	$Mois:="Mars"
End if 
$AutreMois:=(Num:C11($Mois="Octobre")*"Mars")+(Num:C11($Mois="Mars")*"Octobre")
$Pt:=Get pointer:C304("Campagne"+$Mois)
$NumCampagne:=$Pt->
$PtObjetCourant:=OBJECT Get pointer:C1124(Objet courant:K67:2)
$PtSP:=Get pointer:C304("CaC"+$Mois+"SP")  // La boîte à cocher des sans pathogène
$Valeur:=$PtSP->
READ WRITE:C146([CampagneParticipations:17])
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
$FT:=Records in selection:C76([CampagneParticipations:17])
For ($Salé;1;$FT)
	If ($Valeur=1)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"SansPathogene";True:C214)
	Else 
		OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"SansPathogene")
	End if 
	SAVE RECORD:C53([CampagneParticipations:17])
	NEXT RECORD:C51([CampagneParticipations:17])
End for 
ZAmnistiePartielle (->[CampagneParticipations:17])
