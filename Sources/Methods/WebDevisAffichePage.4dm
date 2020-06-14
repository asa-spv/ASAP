//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/12/16, 15:54:35
  // ----------------------------------------------------
  // Méthode : WebDevisAffichePage
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

$ValeurAdresseCourrielA:=$1
  // Affichage de la page finale
$THTML:=ResRaemaCréationET ("Fin de la demande de devis";True:C214)
$THTML:=$THTML+"<br /><br /><br />"+<>ZCR
$THTML:=$THTML+"<p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  Demande de devis du RAEMA Gel"+<>ZCR
$THTML:=$THTML+"</p>"+<>ZCR
  //$THTML:=$THTML+"<br /><p class="+<>ZGuil+"textecentre plusbleu"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"<br />"+TraducUtiliseTableau (72)
  //$THTML:=$THTML+"  <br /></p>"+<>ZCR
$THTML:=$THTML+"<br /><p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"<br />"+"Votre demande de devis est à présent terminée.<br />"+<>ZCR
$THTML:=$THTML+"<br />"+"Un mail vous a été envoyé à l'adresse mail <b>"+$ValeurAdresseCourrielA+"</b>.<br />"+<>ZCR
$THTML:=$THTML+"<br />"+"Pour finaliser votre commande, il suffit de nous envoyer signé le devis en pièce jointe du mail.<br />"+<>ZCR
$THTML:=$THTML+"<br /></p>"+<>ZCR
$THTML:=$THTML+"<br />"+<>ZCR
$THTML:=$THTML+"<br /><p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
LangueCourante:="F"
$THTML:=$THTML+"<br /><br />"+RaemaTraducUtiliseTableau (61)+<>ZCR
$THTML:=$THTML+"<br /><a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+RaemaTraducUtiliseTableau (55)+"</a>"+<>ZCR
$THTML:=$THTML+"<br /></p>"+<>ZCR

$THTML:=$THTML+ResRaemaCréationPied 
  //$THTML:=Mac vers ISO($THTML)
WEB SEND TEXT:C677($THTML)