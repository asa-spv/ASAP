//%attributes = {}
  // EnvoiMailDiscret

  // EnvoiMail
  // $1 = nom ou adresse IP du serveur
  // $2 = nom ou adresse IP de l'emetteur
  // $3 = texte du corps du message
  // $4 = adresse courriel du destinataire principal
  // $5 = Pt sur tableau des destinataires secondaires
  // $6 = Objet du courriel
  // {$7} = Chemin de la PJ ou "" sinon
  // {$8} = tableau des chemins DES PJ
While (Semaphore:C143("Envoi d'un mail"))
	DELAY PROCESS:C323(Current process:C322;30)
End while 
C_LONGINT:C283($Erreur)
C_BOOLEAN:C305($Suite;$0)
CourrielOK:=False:C215
$err:=SMTP_SetPrefs (0;16;0)
$err:=SMTP_Charset (1;1)
<>Erreur:=""  // alerte en cas d'erreur
$Ref_Connect:=0
$Erreur:=SMTP_New ($Ref_Connect)  //reservation espace
$Suite:=ZDetecteICErreur ($Erreur;"SMTP_New";2;-><>Erreur)

If ($Suite)
	$Erreur:=SMTP_Host ($Ref_Connect;$1)  //indique nom serveur
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Host";2;-><>Erreur)
End if 

If ($Suite)
	$Erreur:=SMTP_From ($Ref_Connect;$2;1)  //indique l'origine + envoi e-mail
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Sender";2;-><>Erreur)
End if 

If ($Suite)
	$Erreur:=SMTP_Body ($Ref_Connect;$3;1)  //Creation corps
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Body";2;-><>Erreur)
End if 

If ($Suite)
	$Erreur:=SMTP_To ($Ref_Connect;$4;1)  // destinataire principal
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_To";2;-><>Erreur)
End if 

$FT:=Size of array:C274($5->)
If ($FT>0)
	$Dest:="Envoi du mail "+<>ZGuil+$6+<>ZGuil+<>ZCR+"Liste des destinataires :"+<>ZCR
	For ($Salé;1;$FT)
		$Erreur:=SMTP_Bcc ($Ref_Connect;$5->{$Salé};0)  //destinataire secondaires
		$Dest:=$dest+$5->{$Salé}+<>ZCR
		$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Bcc";2;-><>Erreur)
	End for 
End if 

If ($Suite) & ($6#"")
	$Erreur:=SMTP_Subject ($Ref_Connect;$6;1)  // objet
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Subject";2;-><>Erreur)
End if 

If (Count parameters:C259=7)
	If ($Suite) & ($7#"")
		$Erreur:=SMTP_Attachment ($Ref_Connect;$7;2)  //piece jointe en binhex
		$Suite:=ZDetecteICErreur ($Erreur;"SMTP_AddHeader";2;-><>Erreur)
	End if 
End if 

If (Count parameters:C259=8)  // tableau des PJ
	If ($Suite)
		$TT:=Size of array:C274($8->)
		For ($Fumé;1;$TT)
			$Erreur:=SMTP_Attachment ($Ref_Connect;$8->{$Fumé};2;0)  //piece jointe en binhex ajoutée aux précedentes
		End for 
	End if 
End if 

If ($Suite)
	
	  //$vAuthUtilisateur:=[XData]XObjet.NomFAM.AdresseEnvoi
	  //$vAuthMotPasse:=[XData]XObjet.NomFAM.MotDePasseEnvoi
	  //$NumPort:=[XData]XObjet.NomFAM.PortEnvoi
	  //$Erreur:=IT_SetPort (12;$NumPort)  // 12 pour envoi smtp SSL  (2 pour SMTP simple)
	  //$Erreur:=SMTP_Auth ($Ref_Connect;"asa-spv";$vAuthMotPasse)
	
	$Erreur:=SMTP_Send ($Ref_Connect)  //envoi du message
	$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Send";2;-><>Erreur)
End if 
$0:=$Suite

$Erreur:=SMTP_Clear ($Ref_Connect)  //menage ds memoire
$Suite:=ZDetecteICErreur ($Erreur;"SMTP_Clear";2;-><>Erreur)


CLEAR SEMAPHORE:C144("Envoi d'un mail")