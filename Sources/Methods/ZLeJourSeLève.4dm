//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 03/05/18, 20:40:29
  // ----------------------------------------------------
  // Pas de Paramètres 
  // ----------------------------------------------------
  // Méthode : ZLeJourSeLève
  // Description
  //  

C_TEXT:C284(<>JPlusX;<>SemNum;<>ZSaintDuJour;$NumSemaine)
C_DATE:C307(<>ZDateDuJour)
C_POINTER:C301($Pt)
C_LONGINT:C283($Mois;$JourCon;$Salé;$TT;$Fumé;$FT)
C_OBJECT:C1216($ArgumentCampagne)
C_BOOLEAN:C305($MailDejaEnvoyé)
ARRAY LONGINT:C221($TbNumLabosConcernés;0)
  // mise à jour des données du RAEMA

  // ASAPFabriqueTbRAEMACourant 
  // Envoi du mail de rappel de la date limite de saisie des résultats le lundi pour la poudre et le mercredi pour le gel.
  //  Est-on dans ces circonstances ?
COPY ARRAY:C226(<>TbCampagnesDateLimiteReponse;$TbCampagnesDateLimiteReponse)
SORT ARRAY:C229($TbCampagnesDateLimiteReponse;<)
For ($Salé;1;$TT)
	$DateCourante:=$TbCampagnesDateLimiteReponse{$Salé}
	If ($DateCourante<Current date:C33)
		$Salé:=$TT
		$DateCourante:=$TbCampagnesDateLimiteReponse{$Salé-1}
		  // On est sur la bonne camapgne
		$NumeroJour:=Day number:C114(Current date:C33)
		$DeltaDate:=$DateCourante-Current date:C33
		$L:=Find in array:C230(<>TbCampagnesDateLimiteReponse;$DateCourante)
		$NumCampagne:=<>TbCampagnesNumCampagne{$L}
		$ArgumentCampagne:=<>TbCampagnesArguments{$L}
		OB GET ARRAY:C1229($ArgumentCampagne;"Loto";$TbNumLabosConcernés)
		$MailDejaEnvoyé:=OB Get:C1224($ArgumentCampagne;"MailDejaEnvoyé";Est un booléen:K8:9)
		If (($NumeroJour=4) | ($NumeroJour=2)) & ($DeltaDate<7) & (Not:C34($MailDejaEnvoyé))  // inutile de tester tout si les conditions ne sont pas réunies
			If (($NumCampagne="@a") & ($NumeroJour=4)) | (($NumCampagne#"@a") & ($NumeroJour=2))  // RAEMA Gel on prévient le mercredi et lundi pour la poudre
				  // le laboratoire a t'il répondu ??
				$FT:=Size of array:C274($TbNumLabosConcernés)
				For ($Fumé;1;$FT)
					$IDParticipation:=String:C10($TbNumLabosConcernés{$Fumé})+"_"+$NumCampagne+"_"
					$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IDParticipation)
					If ($L>0)
						$NumEnrParticipation:=<>TbLotoNumEnrParticipation{$L}
						GOTO RECORD:C242([CampagneParticipations:17];$NumEnrParticipation)
						QUERY:C277([WebConnexions:13];[WebConnexions:13]UUIDParticipation:12=[CampagneParticipations:17]UUID:1;*)
						QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
						
						  // test des laboratoires avec délais négociés à faire  (IndiceCasParticulier # Null)
						If (Records in selection:C76([WebConnexions:13])=0)
							  // Envoi du mail
							  // S'il est parti  on écrit
							  // OB fixer([CampagneParticipations]Arguments;"MailDejaEnvoyé";Vrai)
							  // STOCKER ENREGISTREMENT([CampagneParticipations])
						End if 
					End if 
					
				End for 
			End if 
		End if 
		
		ZAmnistiePartielle (->[CampagneParticipations:17])
		If ($Erreur=0)
			READ WRITE:C146([RAEMACampagnes:20])
			GOTO RECORD:C242([RAEMACampagnes:20];<>TbNumEnrRaemaCampagne{$L})
			OB SET:C1220($ArgumentCampagne;"MailDejaEnvoyé";True:C214)
			SAVE RECORD:C53([RAEMACampagnes:20])
		End if 
	End if 
End for 



  // Mise à jour du calendrier
<>JPlusX:="Jour "+String:C10(1+(<>ZDateDuJour-Date:C102("1/1/"+String:C10(Year of:C25(<>ZDateDuJour)))))  // j+X
$NumSemaine:=ZfNuméroDeSemaine (<>ZDateDuJour)
<>SemNum:="Semaine "+Substring:C12($NumSemaine;4;2)

  // Recherche et affichage du Saint du Jour
$JourCon:=Day of:C23(Current date:C33)
$Mois:=Month of:C24(Current date:C33)
$Pt:=Get pointer:C304("<>ZTbSaints"+<>ZTbNomDuMois{$Mois})
$LeSaintDuJour:=$Pt->{$JourCon}
$Pos:=Position:C15(" ";$LeSaintDuJour)
<>LeSaintDuJour:=Substring:C12($LeSaintDuJour;($Pos+1))
<>ZSaintDuJour:="Aujourd'hui, nous fêtons "+$Pt->{$JourCon}

  // Suppression des messages de plus de X jours
C_OBJECT:C1216($Config)
C_LONGINT:C283($Delay)

QUERY:C277([XData:1];[XData:1]XType:3="Configuration";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Configuration")
$Config:=[XData:1]XObjet:18
ZAmnistiePartielle (->[XData:1])

$delay:=(OB Get:C1224($Config;"option_news_delais";Est un entier long:K8:6))

If (Records in selection:C76([XData:1])>0)
	C_DATE:C307($DteLimite)
	C_LONGINT:C283($Salé)
	ARRAY BOOLEAN:C223($TbBoolSup;0x0000)
	
	$DteLimite:=Add to date:C393(Current date:C33;0;0;-$Delay)
	QUERY:C277([XData:1];[XData:1]XType:3="MsgNews";*)
	QUERY:C277([XData:1]; & ;[XData:1]XBoolSup:15=False:C215;*)
	QUERY:C277([XData:1]; & ;[XData:1]XDate:4<=$DteLimite)
	
	SELECTION TO ARRAY:C260([XData:1]XBoolSup:15;$TbBoolSup)
	For ($Salé;1;Size of array:C274($TbBoolSup))
		$TbBoolSup{$Salé}:=True:C214
	End for 
	ARRAY TO SELECTION:C261($TbBoolSup;[XData:1]XBoolSup:15)
End if 
