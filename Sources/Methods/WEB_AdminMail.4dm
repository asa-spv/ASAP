//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // 
  // Date et heure : 24/08/09, 17:55:44
  // ----------------------------------------------------
  // Méthode : WEB_AdminMail
  // Description
  // Envoi un mail aux administreateur et log le mail envoyé
  //
  // Paramètres
  // sujet du mail = $1
  // message a envoyer = $2
  // methode appelante = $3
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$3)
C_TEXT:C284($subject;$message;$methode;$dateheure)
C_LONGINT:C283($result_smtp)
If (<>SMTP#"")
	$subject:=$1
	$message:=$2
	$methode:=$3
	
	$message:=$dateheure+" - 4D - "+$methode+Char:C90(13)+Char:C90(10)+$message
	
	If (t_serveurSMTP#"") & (t_MailFrom#"") & (t_MailTo#"")
		  //%W-533.4
		$result_smtp:=SMTP_QuickSend (t_serveurSMTP;t_MailFrom;t_MailTo;$subject;$message)
		  //%W+533.4
	End if 
End if 