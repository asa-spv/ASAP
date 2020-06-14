//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/08/18, 12:04:54
  // ----------------------------------------------------
  // Paramètre $1 = chaine AJAX envoyée par la page Web
  // ----------------------------------------------------
  // Méthode : RapAjax
  // Description
  // Permet de savois si on a récupéré le rapport par 
  //  un clic sur le lien de téléchargement
  // ----------------------------------------------------

$Mess:=$1  // type pdf/Rapports/2/RI58_2.pdf
$Pos:=Position:C15("/bRI";$Mess)

If ($Pos>0)
	$NomFichier:=Replace string:C233($Mess;"/bRI";"/RI")
	$CDDocumenavecb:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$Mess
	$CDDocumensansb:=<>PermCheDosTel+$NomFichier
	
	COPY DOCUMENT:C541($CDDocumensansb;$CDDocumenavecb)
	
	$Mess:=Substring:C12($Mess;($Pos+5))
	  // Envoi AJAX du site pour prévenir du téléchargement du fichier de résultat individuel
	$Pos1:=Position:C15("_";$Mess)
	$Pos2:=Position:C15(".";$Mess)
	$campagne:=Substring:C12($Mess;6;($Pos1-6))
	$labo:=Substring:C12($Mess;$Pos1+1;($Pos2-$Pos1-1))
	$Idenf:=$campagne+"_"+$labo
	READ WRITE:C146([CampagneParticipations:17])
	$UUID:=WebTrouveValeurParNom ($labo;-><>TbPerNumLaboRAEMAA;-><>TbPerUUID)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=$UUID;*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$campagne)
	OB SET:C1220([CampagneParticipations:17]Arguments:5;"RapportPris";True:C214)
	$Participe:="Le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" : récupération du rapport par un clic sur le lien"+<>ZCR
	[CampagneParticipations:17]TexteParticipation:4:=[CampagneParticipations:17]TexteParticipation:4+<>ZCR2+$Participe
	SAVE RECORD:C53([CampagneParticipations:17])
	  // Il reste à renseigner le tableau de gestion page 5 de "DlgPrincipal"
	  // à mon sens très utile si c'est une campagne en cours
	  // voir RapInitZoneLabNonPris
	  // Fin de si 
End if 
ZAmnistieInternationale 