//%attributes = {}
  // ResP4ARKO

$THTML:=ResRaemaCréationET ("Pb envoi courriel")
$THTML:=$THTML+"         <br /><br />"+<>ZCR
$THTML:=$THTML+"         <p class="+<>ZGuil+"titrepage"+<>ZGuil+">VERIFICATION DE L'ENVOI DU  COURRIEL</p><br /><br />"+<>ZCR
$THTML:=$THTML+"         <p class="+<>ZGuil+"textecentre"+<>ZGuil+">Un incident s'est produit pendant l'envoi de votre courriel :</p>"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"rougeRAEMA"+<>ZGuil+">Veuillez revenir à l'écran précédent pour renouveller votre requète.</p>"+<>ZCR
$THTML:=$THTML+"        <form class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <input class="+<>ZGuil+"titrepage"+<>ZGuil+" type="+<>ZGuil+"button"+<>ZGuil+" value="+<>ZGuil+"Retour à l'écran précédent"+<>ZGuil+" onClick="+<>ZGuil+"history.go(-1)"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"        </form>"+<>ZCR
$THTML:=$THTML+"         <br /><br />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textecentre"+<>ZGuil+"> Si le problème persiste, contacter l'association.<br />"+<>ZCR
$THTML:=$THTML+"          <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">Envoyer un mail à l'ASA</a>"+<>ZCR
$THTML:=$THTML+"        </p><br/>"
$THTML:=$THTML+"</body>"+<>ZCR
$THTML:=$THTML+ResRaemaCréationPied 
WEB SEND TEXT:C677($THTML)