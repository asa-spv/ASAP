//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 28/08/19, 17:41:07
  // ----------------------------------------------------
  // Méthode : ASAPEnvoiMailDiscretDevis
  // Description
  // 
  //
  // Paramètres $1 = objet contenant les paramètres du mail
  // ----------------------------------------------------

  // Paramètres liées à l'utilisateur
  // serveur SMTP               = $ObjetMail.ServeurEnvoi
  // mail de l'emetteur         = $ObjetMail.AdresseEnvoi
  // nom de l'emetteur          = $ObjetMail.NomUtilisateurEnvoi
  // mot de passe de l'emetteur = $ObjetMail.MotDePasseEnvoi
  // port d'envoi               = $ObjetMail.PortEnvoi

  // Paramètres propre au courriel 
  // Objet du courriel                               = $ObjetMail.Sujet
  // texte du corps du message                       = $ObjetMail.Corps
  // adresse courriel du destinataire principal      = $ObjetMail.Destinataire
  // Facultativement
  // {Pt sur tableau des destinataires secondaires}  = $ObjetMail.DestinatairesSecondaires
  // {Chemins de la PJ}                              = $ObjetMail.CDPJ
  // {tableau des chemins des PJ}                    = $ObjetMail.TbCDPJ

C_LONGINT:C283($Erreur)
C_BOOLEAN:C305($Suite;$0)
C_OBJECT:C1216($1;$ObjetMail)

$ObjetMail:=$1
While (Semaphore:C143("Envoi d'un mail"))
	DELAY PROCESS:C323(Current process:C322;30)
End while 

CourrielOK:=False:C215
$err:=SMTP_SetPrefs (1;16;0)
$err:=SMTP_Charset (1;1)
  // $err:=IT_SetPort (2;$ObjetMail.PortEnvoi)

<>Erreur:=""  // alerte en cas d'erreur
$Ref_Connect:=0
$Erreur:=SMTP_New ($Ref_Connect)  //reservation espace
$Suite:=ZDetecteICErreur ($Erreur;"SMTP_New";2;-><>Erreur)

If ($Suite)
	$Erreur:=SMTP_Host ($Ref_Connect;$ObjetMail.ServeurEnvoi)  //indique nom serveur
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Host";2;-><>Erreur)
End if 

If ($Suite)
	$Erreur:=SMTP_From ($Ref_Connect;$ObjetMail.AdresseEnvoi;1)  //indique l'origine + envoi e-mail
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Sender";2;-><>Erreur)
End if 

If ($Suite)
	$Erreur:=SMTP_Body ($Ref_Connect;$ObjetMail.Corps;1)  //Creation corps
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Body";2;-><>Erreur)
End if 

If ($Suite)
	$Erreur:=SMTP_To ($Ref_Connect;$ObjetMail.Destinataire;1)  // destinataire principal
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_To";2;-><>Erreur)
End if 

ARRAY TEXT:C222($TbDestinatairesSecondaires;0)
OB GET ARRAY:C1229($ObjetMail;"DestinatairesSecondaires";$TbDestinatairesSecondaires)
$FT:=Size of array:C274($TbDestinatairesSecondaires)
If ($FT>0)
	$Dest:="Envoi du mail "+<>ZGuil+$ObjetMail.Sujet+<>ZGuil+<>ZCR+"Liste des destinataires :"+<>ZCR
	For ($Salé;1;$FT)
		$Erreur:=SMTP_Bcc ($Ref_Connect;$TbDestinatairesSecondaires{$Salé};0)  //destinataire secondaires
		$Dest:=$dest+$TbDestinatairesSecondaires{$Salé}+<>ZCR
		$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Bcc";2;-><>Erreur)
	End for 
End if 

If ($Suite) & ($ObjetMail.Sujet#"")
	$Erreur:=SMTP_Subject ($Ref_Connect;$ObjetMail.Sujet;1)  // objet
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Subject";2;-><>Erreur)
End if 

C_TEXT:C284($CDPJ)
$CDPJ:=OB Get:C1224($ObjetMail;"CDPJ";Est un texte:K8:3)
If ($Suite) & ($CDPJ#"")
	$Erreur:=SMTP_Attachment ($Ref_Connect;$CDPJ;2;1)  //piece jointe en binhex
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_AddHeader";2;-><>Erreur)
End if 

If ($Suite)
	ARRAY TEXT:C222($TbCDPJ;0)
	OB GET ARRAY:C1229($ObjetMail;"TbCDPJ";$TbCDPJ)
	$TT:=Size of array:C274($TbCDPJ)
	If (Size of array:C274($TbCDPJ)>0)  // tableau des PJ
		For ($Fumé;1;$TT)
			$Erreur:=SMTP_Attachment ($Ref_Connect;$TbCDPJ{$Fumé};2;0)  //piece jointe en binhex ajoutée aux précedentes
		End for 
	End if 
End if 

  //Si ($Suite)
  //$Erreur:=SMTP_Auth ($Ref_Connect;$ObjetMail.NomUtilisateurEnvoi;$ObjetMail.MotDePasseEnvoi;0)
  //$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Auth";2;-><>Erreur)
  //Fin de si 

If ($Suite)
	$Erreur:=SMTP_Send ($Ref_Connect)  //envoi du message
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Send";2;-><>Erreur)
End if 
$0:=$Suite

If ($Suite)
	$Erreur:=SMTP_Clear ($Ref_Connect)  //menage ds memoire
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Clear";2;-><>Erreur)
End if 

CLEAR SEMAPHORE:C144("Envoi d'un mail")