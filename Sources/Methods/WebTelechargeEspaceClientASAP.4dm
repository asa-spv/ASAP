//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/02/19, 18:20:01
  // ----------------------------------------------------
  // Paramètre : $1 = message envoyé par l'espace client
  // ----------------------------------------------------
  // Méthode : WebTelechargeEspaceClientASAP
  // Description
  // Méthode qui trapse les demande de téléchargement 
  // nécessitant de noter l'action (rapport)
  // ou de fabriquer l'attestation à la volée


$Mess:=$1  // type telechargementRI67A_UUIDLabo.pdf (rapport)  ou Téléchargements/At67_9E859D0D643F4CCE86F87DE0A5D455DC.pdf  (Attestation)
$Mess:=Substring:C12($Mess;15)  // RI67A_UUIDLabo.pdf
$Rapport:=(Substring:C12($Mess;1;2)="RI")
$Pos:=Position:C15("_";$Mess)
$Reste:=Substring:C12($Mess;($Pos+1))
If (Length:C16($Reste)<31)
	$NumLaboA:=$Reste
	$NumLaboA:=Substring:C12($NumLaboA;1;(Length:C16($NumLaboA)-4))
Else 
	$UUIDLabo:=$Reste
	$UUIDLabo:=Substring:C12($UUIDLabo;1;(Length:C16($UUIDLabo)-4))
	$NumLaboA:=String:C10(ASAPTrouveNumeroLaboParUUID ($UUIDLabo))
End if 
  // $UUIDLabo:=Sous chaîne($Mess;($Pos+1))
$NumCampagne:=Substring:C12($Mess;3;(2+Num:C11($Mess[[$Pos-1]]="A")))
If ($Rapport)
	$Redir:="Téléchargements"+Séparateur dossier:K24:12+"RI"+$NumCampagne+"_"+$NumLaboA+".pdf"
	$CDRedir:=<>PermCheDosTel+"RI"+$NumCampagne+"_"+$NumLaboA+".pdf"
	$CDDocOriginal:=<>PermCheDosRap+$NumLaboA+Séparateur dossier:K24:12+"RI"+$NumCampagne+"_"+$NumLaboA+".pdf"
	If (Test path name:C476($CDRedir)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDRedir)
	End if 
	COPY DOCUMENT:C541($CDDocOriginal;$CDRedir)
	While (Test path name:C476($CDredir)#Est un document:K24:1)
		DELAY PROCESS:C323(Current process:C322;60)
	End while 
	WEB SEND HTTP REDIRECT:C659($Redir)
	
	  //Allons actualiser la participation
	  // test dans les RAEMA liés
	$Test:=$NumLaboA+"_"+$NumCampagne
	$L:=Find in array:C230(<>TbLotoNumLaboRapportCampagne;$Test)  // si $L >0 => c'est un RAEMA lié
	If ($L<0)  // test dans les RAEMA principaux
		$Test:=$Test+"_"
		$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
	End if 
	If ($L>0)
		READ WRITE:C146([CampagneParticipations:17])
		GOTO RECORD:C242([CampagneParticipations:17];<>TbLotoNumEnrParticipation{$L})
		$TP:="Le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" : récupération du rapport par un clic sur le lien"+<>ZCR
		[CampagneParticipations:17]TexteParticipation:4:=[CampagneParticipations:17]TexteParticipation:4+<>ZCR2+$TP
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"RapportPris";True:C214)
		SAVE RECORD:C53([CampagneParticipations:17])
	End if 
	
Else   // Attestation : donnée sensible puisque faisant le lien entre n° de laboratoire et son identitié
	
	$NomFichier:="At"+$NumCampagne+"_"+$NumLaboA+".pdf"
	$CDAttestation:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"Téléchargements"+Séparateur dossier:K24:12
	$NomCompletFichier:=$CDAttestation+$NomFichier
	$Redir:="Téléchargements"+Séparateur dossier:K24:12+$NomFichier
	If (Test path name:C476($CDAttestation)=Est un document:K24:1)  // test de l'existence du document antérieur
		DELETE DOCUMENT:C159($CDAttestation)
	End if 
	UUIDLabo:=$UUIDLabo
	NumCampagne:=$NumCampagne
	NumLaboActuelA:=$NumLaboA
	$CDDos:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"Téléchargements"+Séparateur dossier:K24:12
	ZPDFImprimer ($NomFichier;$CDAttestation;"RapImprimeAttestation")
	While (Test path name:C476($NomCompletFichier)#Est un document:K24:1)
		DELAY PROCESS:C323(Current process:C322;60)
	End while 
	
	WEB SEND HTTP REDIRECT:C659($Redir)
	
End if 
ZAmnistieInternationale 
