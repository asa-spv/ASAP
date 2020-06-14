//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 12/12/16, 06:21:28
  // ----------------------------------------------------
  // Méthode : WebDevisRecevoir
  // Description
  // Reçoit le formulaire de devis, écrit une [XDonnées]
  //  édite le formulaire, l'envoie par mail au laboratoire et à l'ASA
  // ----------------------------------------------------
C_BOOLEAN:C305($OK;$Test)
C_OBJECT:C1216($Objet)
C_LONGINT:C283(NumLabo)

$UUID:=$1
ARRAY TEXT:C222(TbNoms;0)
ARRAY TEXT:C222(TbValeurs;0)
WEB GET VARIABLES:C683(TbNoms;TbValeurs)
If ($UUID="")
	$NumLabo:=WebTrouveValeurParNom ("numlabo";->TbNoms;->TbValeurs)
Else 
	$NumLabo:=ASAPTrouveNumeroLaboParUUID ($UUID)
End if 
$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumLabo)
NumLabo:=Num:C11($NumLabo)
If ($L>0)
	$NomLabo:=<>TbPerNomLong{$L}
	$AdhRaema:=True:C214
Else 
	$NomLabo:=WebTrouveValeurParNom ("Nom";->TbNoms;->TbValeurs)
	$AdhRaema:=False:C215
End if 
CREATE RECORD:C68([PersonnesDevis:30])
[PersonnesDevis:30]NomLabo:2:="Demande de devis labo "+$NomLabo
[PersonnesDevis:30]DateDevis:3:=Current date:C33
[PersonnesDevis:30]HeureDevis:4:=Current time:C178
[PersonnesDevis:30]UUIDPersonne:6:=ASAPTrouveUUIDLaboParNumero (Num:C11($NumLabo))
[PersonnesDevis:30]AnneeDevis:5:=<>AnCourantDevisRGN
OB SET ARRAY:C1227([PersonnesDevis:30]Arguments:9;"TbNoms";TbNoms)
OB SET ARRAY:C1227([PersonnesDevis:30]Arguments:9;"TbValeurs";TbValeurs)
SAVE RECORD:C53([PersonnesDevis:30])
$NomFichier:="Devis "+$NomLabo+".pdf"
  //$NomFichier:="Devis"+[XData]UUID+".pdf"
  // UTILISER PARAMÈTRES IMPRESSION([Personnes];"ListeTout")  // Forcer l'orientation portrait

ZPDFImprimer ($NomFichier;<>PermCheDosTel;"WebDevisImprime")
$CDPJ:=<>PermCheDosTel+$NomFichier

  // $OK:=Tester chemin acces($CD)
$An:=String:C10(Year of:C25(Current date:C33)+Num:C11(Month of:C24(Current date:C33)=12))
$Texte:="Bonjour,"+<>ZCR2
$Texte:=$Texte+"Vous avez demandé un devis sur le Web pour le RAEMA gel "+$An+" et nous vous en remercions."+<>ZCR
$Texte:=$Texte+"Vous trouverez en PJ le document qui résume votre demande."+<>ZCR
$Texte:=$Texte+"Vous n'avez plus qu'à nous le renvoyer signé afin de finaliser votre commande."+<>ZCR2
$Texte:=$Texte+"Si vous rencontrez des difficultés à ouvrir votre devis en pièce jointe, merci de contacter l’ASA."+<>ZCR
$Texte:=$Texte+"Nous restons à votre disposition pour tout renseignement complémentaire."+<>ZCR
$Texte:=$Texte+"Bien cordialement."+<>ZCR
$Texte:=$Texte+"--"+<>ZCR
$Texte:=$Texte+"L'équipe du RAEMA"+<>ZCR
$Objet:=ASAPChercheDonneesCouriel 
$Objet.Corps:=$Texte
$Objet.Sujet:="Votre demande de devis pour le RAEMA gel"
If (True:C214)  // A réactiver après tests
	$Serveur:=[XData:1]XTexte:9
	ARRAY TEXT:C222($TbMailAR;2)
	$TbMailAR{1}:="asa-spv@wanadoo.fr"
	$TbMailAR{2}:="cegeheme@wanadoo.fr"
	OB SET ARRAY:C1227($Objet;"DestinatairesSecondaires";$TbMailAR)
	If ($AdhRaema)
		$Objet.Destinataire:=<>TbPAEmailRAEMA{$L}
	Else 
		$Objet.Destinataire:=WebTrouveValeurParNom ("Mail";->TbNoms;->TbValeurs)
	End if 
Else 
	$Objet.Destinataire:="asa.eloise@gmail.com"
End if 

$Objet.CDPJ:=$CDPJ
$ValeurAdresseCourrielA:=$Objet.Destinataire
$OK:=ASAPEnvoiMailDiscretDevis ($Objet)

  // $OK:=EnvoiMailDiscret ($Serveur;"asa-spv@wanadoo.fr";$Texte;$ValeurAdresseCourrielA;->TbMailAR;$Sujet;$CD)   // A réactiver après tests
If ($OK)
	WebDevisAffichePage ($ValeurAdresseCourrielA)
Else 
	VarTitrePage:="Problème de connexion"
	WEB SEND FILE:C619("DlgErreurWebFr.shtml")
End if 
