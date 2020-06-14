//%attributes = {}
  // ----------------------------------------------------
  // Méthode : ASAPEnvoiMailTransporter
  // Description
  // Méthode qui envoie les mails
  //   avec SMTP transporteur
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 30/04/20, 05:18:27
  // Paramètre : $1=objet de description contextuelle du mail
  //   $Objet.to = adresse du (ou des) destinataire(s) * 
  //   $Objet.subject = sujet du mail (texte)
  //   $Objet.textBody = texte brut à envoyer
  //   $Objet.htmlBody = html à envoyer
  //               * (peut être une liste séparée par une virgule)

C_OBJECT:C1216($transporter;$email;$status)
$email:=$1
$transporter:=ASAPCreationtransporter 
$email.from:=$transporter.user
$status:=$transporter.send($email)  // Envoi du message
$0:=($status.success)