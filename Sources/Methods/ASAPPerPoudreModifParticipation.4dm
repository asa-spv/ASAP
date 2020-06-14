//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/08/19, 05:24:34
  // ----------------------------------------------------
  // Méthode : ASAPPerPoudreModifParticipation
  // Description
  //   Méthode qui gère la modification d'une participation
  //   par un clic sur la boîte à cocher CaCMarsOK ou CaCOctobreOK
  // ----------------------------------------------------
C_TEXT:C284($NomTransporteur)
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

$PtAR:=Get pointer:C304("Var"+$Mois+"PAR")  // Le nombre de colis avec rapport
$PtSR:=Get pointer:C304("Var"+$Mois+"PSR")  // Le nombre de colis sans rapport
$PtBt:=Get pointer:C304("PUM"+$Mois+"Boite")  // Le menu local des boîtes isothermes
$PtSP:=Get pointer:C304("CaC"+$Mois+"SP")  // La boîte à cocher des sans pathogène
$PtTr:=Get pointer:C304("Var"+$Mois+"Transport")  // Le nom du transporteur
$PtRL:=Get pointer:C304("Var"+$Mois+"NRL")  // Les n° de laboratoire des RAEMA liés
If ($PtObjetCourant->=0)  // il était au loto et on veut l'enlever
	$Mess:="Voulez-vous VRAIMENT supprimer la participation du laboratoire "
	$Mess:=$Mess+"au RAEMA "+$NumCampagne+"???"
	CONFIRM:C162($Mess;"Oui, c'est ça";"Non, bien sûr")
	If (OK=1)
		$PtAR->:=0
		$PtSR->:=0
		$PtBt->:=0
		$PtSP->:=0
		$PtTr->:=""
		$PtRLv:=""
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$NumCampagne)
		DELETE SELECTION:C66([CampagneParticipations:17])
		ZAmnistiePartielle (->[CampagneParticipations:17])
	Else 
		$PtObjetCourant->:=1
		OnAChangéParticipation:=False:C215
	End if 
	
Else   // il n'était pas au loto et on veut l'ajouter
	CREATE RECORD:C68([CampagneParticipations:17])
	[CampagneParticipations:17]UUIDPersonne:2:=[Personnes:12]UUID:1
	[CampagneParticipations:17]NumCampagne:3:=$NumCampagne
	  // le transporteur
	$PtTransporteurAutreMois:=Get pointer:C304("Var"+$AutreMois+"Transport")
	If ($PtTransporteurAutreMois->#"")  // Il existe un transporteur sur l'autre campagne
		$NomTransporteur:=$PtTransporteurAutreMois->  // Parions que c'est le même
	Else   // Il n'existe pas de transporteur sur l'autre campagne
		$NomTransporteur:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis";Est un texte:K8:3)  // Lisons celui proposé au laboratoire
	End if 
	OB SET:C1220([CampagneParticipations:17]Arguments:5;"Transporteur";$NomTransporteur)
	$PtTr->:=$NomTransporteur
	  // La boîte isotherme
	$PtBtAutre:=Get pointer:C304("PUM"+$AutreMois+"Boite")  // Le menu local des boîtes isothermes
	If ($PtBtAutre->>1)
		$BoiteIsotherme:=$PtBtAutre->
	Else 
		$BoiteIsotherme:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"BoiteIsotherme";Est un texte:K8:3))  // "1", "2" ou "3"
	End if 
	If ($BoiteIsotherme>1)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"BoiteIsotherme";$BoiteIsotherme)
	End if 
	$PtBt:=->$BoiteIsotherme
	  // Sans pathogène
	$SansPatho:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogenes";Est un texte:K8:3)
	If ($SansPatho="Vrai")
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"SansPathogène";True:C214)
	End if 
	$PtSP->:=Num:C11($SansPatho="Vrai")
	  // Proforma
	If (PUMProforma>1)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"Proforma";PUMProforma{PUMProforma})
	End if 
	SAVE RECORD:C53([CampagneParticipations:17])
End if 
ZAmnistiePartielle (->[CampagneParticipations:17])
OBJECT SET VISIBLE:C603(*;($Mois+"@");($PtObjetCourant->=1))
OBJECT SET VISIBLE:C603(*;($Mois+"NRL@");False:C215)