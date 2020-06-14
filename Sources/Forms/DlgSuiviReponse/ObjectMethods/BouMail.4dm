  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 17/11/16, 14:51:03
  // ----------------------------------------------------
  // Méthode : DlgSuiviReponse.BouMail
  // Description
  // Permet d'envoyer les mails de relance pour les participants 
  // du loto n'ayant pas encore envoyé leurs résultats et ne faisant
  // pas parti des cas particuliers
  //
  // ----------------------------------------------------

$test:=True:C214
  // Participants de la campagne qui n'ont pas répondu
USE SET:C118("Absence")
  // Enlevons les cas particuliers
CREATE SELECTION FROM ARRAY:C640([CampagneParticipations:17];TbNumEnrParticuliers)
CREATE SET:C116("$Particuliers")
DIFFERENCE:C122("Absence";"$Particuliers";"$Envoi")
USE SET:C118("$Envoi")
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDLabo)
$message:="Madame, Monsieur, bonjour,"+<>ZCR2+"Il vous reste "+DelaiReponseA+" jours pour répondre au questionnaire du RAEMA."
$message:=$message+<>ZCR+"Merci de bien vouloir vous loguer sur le site de l'ASA (http://www.asa-spv.asso.fr) pour nous envoyer vos résultats."
$message:=$message+<>ZCR2+"Passé ce délai, nous ne serons pas en mesure de tenir compte de vos résultats."
$message:=$message+<>ZCR2+"Comptant sur votre diligence."+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"L'équipe du RAEMA"
$TT:=Size of array:C274($TbUUIDLabo)
$err:=SMTP_Charset (1;1)
For ($salé;1;$TT)
	If ($test)
		$Mail:="asa-spv@wanadoo.fr"
	Else 
		$L:=Find in array:C230(<>TbUUID;$TbUUIDLabo{$salé})
		$Mail:=<>TbPAEmailRAEMA{$L}
	End if 
	$err:=SMTP_QuickSend ("SMTP.orange.fr";"asa-spv@wanadoo.fr";$Mail;"Saisie des résultats du RAEMA n°"+VARNUMRAEMA;$message)
End for 