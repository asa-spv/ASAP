//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/08/18, 11:55:51
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP4AROK
  // Description
  // 

$THTML:=ResRaemaCréationET ("Fin de la saisie des résultats";True:C214)
$THTML:=$THTML+"<br /><br /><br />"+<>ZCR
$THTML:=$THTML+"<p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+RaemaTraducUtiliseTableau (48)+<>ZCR
$THTML:=$THTML+"</p>"+<>ZCR
$THTML:=$THTML+"<br /><p class="+<>ZGuil+"textecentre plusbleu"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"<br />"+RaemaTraducUtiliseTableau (72)
$THTML:=$THTML+"  <br /></p>"+<>ZCR
$THTML:=$THTML+"<br /><p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"<br />"+RaemaTraducUtiliseTableau (49)+<>ZCR
$THTML:=$THTML+"<br /></p>"+<>ZCR
$THTML:=$THTML+"<br />"+<>ZCR
$THTML:=$THTML+"<br /><p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"<br /><br />"+RaemaTraducUtiliseTableau (61)+<>ZCR
$THTML:=$THTML+"<br /><a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+RaemaTraducUtiliseTableau (55)+"</a>"+<>ZCR
$THTML:=$THTML+"<br /></p>"+<>ZCR

$THTML:=$THTML+ResRaemaCréationPied 
WEB SEND TEXT:C677($THTML)



