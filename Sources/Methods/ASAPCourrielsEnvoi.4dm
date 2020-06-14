//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/01/19, 11:08:33
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsEnvoi(GA15CourrielsEnvoi)
  // Description
  // Permet d'envoyer les courriels  -selon le courriel type sélectionné
  // aux destinataires listés (avec une adresse mail) 
  // Envoi soit des Couriels en HTML si SmartCourriels=Vrai
  //       soit des couriels en texte brut sinon
  // ----------------------------------------------------
C_OBJECT:C1216($server;$transporter;$email;$status)
ARRAY TEXT:C222($fichiers;0)
ARRAY TEXT:C222($TbMailsOK;0)
ARRAY TEXT:C222($TbMailsKO;0)
C_LONGINT:C283($Salé;$Fumé;$SFT;$FT;$TT)
C_TEXT:C284($html)
C_BLOB:C604($Blob)
  //ZFenetreModaleAuCentre (500;150)
MESSAGE:C88(<>ZCR2+"     Patience, le courriel est en cours de chargement...")

  // INITIALISATION DES VARIABLES
$Test:=True:C214  // Pour pouvoir tester les différentes phases de l'envoi
$Délai:=600  // 5 secondes de temporisation
$TT:=Size of array:C274(TbEM)  // Liste des adresses mails des destinataires du courriel
$CompteurPb:=0  // Initialisation du compteur d'échec
$CompteurOK:=0  // Initialisation du compteur de réussite
<>PbEnvoiMail:=False:C215  // Initialisation du booléen d'échec mis à jour par PbEnvoiMail
ON ERR CALL:C155("PbEnvoiMail")  // Appel de PbEnvoiMail si erreur

  // ENVOI DES MAILS
FIRST RECORD:C50(ZPtTable->)  // Placement en début de sélection soit des [Personnes] soit des [Factures]
$PtModele:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text")  // Pt sur le texte stylé affiché
$PtTransfert:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text1")  // Pt sur le texte stylé non affiché (transfert)

  // Création du transporteur
  // $server.logFile:="LogTest.txt"  // Historique étendu à sauvegarder dans le dossier Logs
$transporter:=ASAPCreationtransporter 

If (False:C215)
	$SFT:=Size of array:C274(TbCourrielsCDPJ)  // nombre de PJ
	  // Transfert des PJ sous forme d'une UUID + extension en vue du stockage
	If ($SFT>0)  // il existe des PJ à envoyer
		ARRAY TEXT:C222($TbUUIDPJ;$SFT)
		For ($Salé;1;$SFT)
			$Ext:=YTrouveExtension (TbCourrielsNomPJ{$Salé})
			$NomDoc:=Generate UUID:C1066+"."+$Ext
			$Cible:=<>PermCheDropBox+"Dossier ASA"+Séparateur dossier:K24:12+"PJCourriels"+Séparateur dossier:K24:12+$NomDoc
			$TbUUIDPJ{$Salé}:=$NomDoc
			COPY DOCUMENT:C541(TbCourrielsCDPJ{$Salé};$Cible)
		End for 
	End if 
End if 

For ($Salé;1;$TT)  // Pour chaque destinataire ou pour chaque facture
	MESSAGE:C88(<>ZCR2+"     j'en suis à "+TbEM{$Salé}+" qui est le n°"+String:C10($Salé)+" sur "+String:C10($TT)+" en tout.")
	
	  // Fabrication du message en HTML
	  // Actualisation des données variables inclus dans les lettres-type
	ASAPCourrielsRenseigneChamps (TbMailPerUUID{$Salé})  // Valorisation des variables incluses dans les lettres-type
	$PtModele->:=[CourrielsTypes:28]TexteType:5  // mise du texte de la lettre dans le texte stylé affiché
	ST COMPUTE EXPRESSIONS:C1285(*;"RTA_Text";ST Début texte:K78:15;ST Fin texte:K78:16)  // Actualisation des variables incluses dans les lettres-type
	  // Le texte stylé affiché doit toujours continuer à contenir les variables incluses dans les lettres-type
	  //  on va donc utiliser le texte caché pour figer les valeurs c'est-à-dire transformer les variables en texte fixe
	$PtTransfert->:=$PtModele->  // mise du texte actualisé de la lettre dans le texte stylé non affiché (transfert)
	$VarMail:=""  // initialisation du texte stylé qui sera envoyé
	ST FREEZE EXPRESSIONS:C1282(*;"RTA_Text1";ST Début texte:K78:15;ST Fin texte:K78:16;*)  // Attribution en tant que texte des variables incluses dans les lettres-type
	$VarMail:=$PtTransfert->  // Renseignement du texte stylé qui sera envoyé
	  // $VarMail:=YHTMLFiltreCaracteres ($VarMail)  // Sert à neutraliser les caractères qui ont une signification HTML (semble inutile)
	$html:="<html><body>"+$VarMail+"</body></html>"  // Fabrication de la variable HTML avec ajout des balises <html> et <body>
	  // FIXER TEXTE DANS CONTENEUR($html)  // Pour pouvoir visualiser au cours des tests
	
	  // Création du message
	$email:=New object:C1471
	$email.subject:=VarSujet
	$email.from:=$transporter.user
	$email.to:=TbEM{$Salé}
	
	If (TbBrut{$Salé})
		$texteMail:=ST Get plain text:C1092(*;"RTA_Text1")
		$email.textBody:=ST Get plain text:C1092(*;"RTA_Text1")
	Else 
		$texteMail:=$html
		$email.htmlBody:=$html
	End if 
	
	  // Rattachement des pièces jointes dont le chemin est dans TbCourrielsCDPJ
	If (Size of array:C274(TbCourrielsCDPJ)>0)  // il existe des PJ à envoyer
		  // création de la collection avec le premier chemin de PJ
		$email.attachments:=New collection:C1472(MAIL New attachment:C1644(TbCourrielsCDPJ{1}))
		  // Création des suivantes en les ajoutant à la collection
		For ($Fumé;2;$SFT)  // Ajout à la collection des autres PJ
			$email.attachments[$Fumé-1]:=MAIL New attachment:C1644(TbCourrielsCDPJ{$Fumé})  // Une collection commence à 0  => $Fumé-1
		End for 
	End if 
	
	  // Envoi du message
	$status:=$transporter.send($email)
	
	If ($status.success)  // L'envoi a été effectué
		$CompteurOK:=$CompteurOK+1
		APPEND TO ARRAY:C911($TbMailsOK;$email.to)
		CREATE RECORD:C68([PersonnesCourriels:31])
		[PersonnesCourriels:31]CorpsCourriel:7:=$VarMail
		[PersonnesCourriels:31]DateCourriel:4:=Current date:C33
		[PersonnesCourriels:31]DestinataireCourriel:6:=TbEM{$Salé}
		[PersonnesCourriels:31]HeureCourriel:5:=Current time:C178
		If (Size of array:C274(TbCourrielsCDPJ)>0)  // il existe des PJ à envoyer
			OB SET ARRAY:C1227([PersonnesCourriels:31]ObjetCourriel:8;"TbUUIDPJ";$TbUUIDPJ)
			OB SET ARRAY:C1227([PersonnesCourriels:31]ObjetCourriel:8;"TbNomPJ";TbCourrielsNomPJ)
		End if 
		[PersonnesCourriels:31]SujetCourriel:3:=VarSujet
		[PersonnesCourriels:31]UUIDPersonne:2:=[Personnes:12]UUID:1
		[PersonnesCourriels:31]ObjetCourriel:8.TexteBrut:=TbBrut{$Salé}
		SAVE RECORD:C53([PersonnesCourriels:31])
	Else   // L'envoi N'a PAS été effectué
		$CompteurPb:=$CompteurPb+1
		APPEND TO ARRAY:C911($TbMailsKO;$email.to)
		ALERT:C41("Une erreur est survenue pendant l'envoi de l'e-mail : "+$status.statusText)
	End if 
	
	DELAY PROCESS:C323(Current process:C322;$Délai)  // 5 secondes de temporisation pour ne pas irriter le fournisseur d'accès
	
	NEXT RECORD:C51(ZPtTable->)  // [Factures] ou [Personnes]
End for 

ON ERR CALL:C155("")
CLOSE WINDOW:C154  // Ferme la fenetre de message ouverte par ZFenetreModaleAuCentre

  // MESSAGE RECAPITULATIF
  // Initialisation du titre du message récapitulatif
ARRAY TEXT:C222($TbTexteAR;1)
$LongueurAR:=0
$s:=Num:C11($CompteurOK>1)*"s"
Case of 
	: ($CompteurPb=0)
		VarConcluARMail:="Les mails de tous les "+String:C10($TT)+" destinataires ont bien été envoyés."+<>ZCR
		VarConcluARMail:=VarConcluARMail+"("+String:C10($CompteurOK)+" envoi"+$s+" effectué"+$s+" correctement)"
		
	: ($CompteurPb=1)
		VarConcluARMail:="ATTENTION problème : 1 mail n'a PAS été envoyé ("+$TbMailsKO{1}+")."+<>ZCR
		VarConcluARMail:=VarConcluARMail+"("+String:C10($CompteurOK)+" envoi"+$s+" effectué"+$s+" correctement)"
		
	Else 
		VarConcluARMail:="ATTENTION problèmes : "+String:C10($CompteurPb)+" sur "+String:C10($TT)+" mails N'ont PAS été envoyés."+<>ZCR
		VarConcluARMail:=VarConcluARMail+"("+String:C10($CompteurOK)+" envoi"+$s+" effectué"+$s+" correctement)"
End case 


  // Valorisation du texte du message récapitulatif
VarTexteCRMail:="Envoi du mail "+<>ZGuil+VarObjetMail+<>ZGuil+<>ZCR2+"Liste des destinataires :"
VarTexteCRMail:=VarTexteCRMail+<>ZCR+"Mails envoyés :"+<>ZCR+ZTableauVersTexte (->$TbMailsOK)
VarTexteCRMail:=VarTexteCRMail+<>ZCR2+"Mails NON envoyés :"+<>ZCR+ZTableauVersTexte (->$TbMailsKO)
VarTexteCRMail:=VarTexteCRMail+<>ZCR2+"Courriel-type "+<>ZGuil+ZZonelettre{ZZonelettre}+<>ZGuil
VarTexteCRMail:=VarTexteCRMail+<>ZCR+"Contenu :"+<>ZCR+ST Get plain text:C1092(*;"RTA_Text1")
  // Affichage du message récapitulatif
$F:=Open form window:C675("DlgCRMail")
DIALOG:C40("DlgCRMail")
CLOSE WINDOW:C154

  // Envoi du message récapitulatif
$Objet:="Récapitulatif des envois du mail "+<>ZGuil+VarObjetMail+<>ZGuil
$Destinataire:=(Num:C11($Test)*"cegeheme@wanadoo.fr")+(Num:C11($Test=False:C215)*"asa-spv@wanadoo.fr")
$email:=New object:C1471
$email.subject:=$Objet
$email.from:=$transporter.user
$email.to:="cegeheme@wanadoo.fr"
$email.htmlBody:=Replace string:C233((VarConcluARMail+<>ZCR2+VarTexteCRMail);<>ZCR;" <br /> ")
  //$email.textBody:=VarConcluARMail+<>ZCR2+VarTexteCRMail

  // $transporter:=ASAPCreationtransporter   
$status:=$transporter.send($email)
If ($status.success)  // L'envoi a été effectué
	ALERT:C41("Envoi du mail récapitulatif correctement effectué")
Else 
	ALERT:C41("Envoi du mail récapitulatif NON correctement effectué")
End if 

