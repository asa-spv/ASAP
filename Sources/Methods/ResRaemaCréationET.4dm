//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/09/15, 08:01:28
  // ----------------------------------------------------
  // Méthode : ResRaemaCréationET
  // Description
  // Création du début des pages de saisie des résultats 
  // et de récupération des rapports
  // Paramètre : $1 = Titre de la page Web
  // ----------------------------------------------------

C_TEXT:C284($THTML;$1)
$TitrePage:=$1

$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+" <head>"+<>ZCR
$THTML:=$THTML+"    <meta http-equiv="+<>ZGuil+"Content-Type"+<>ZGuil+" content="+<>ZGuil+"text/html; charset=UTF-8"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"../styles/style-asa.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/jquery.min.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"    <script src="+<>ZGuil+"../js/raema.js"+<>ZGuil+" type="+<>ZGuil+"text/javascript"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"    <noscript>"+<>ZCR
$THTML:=$THTML+"      Votre navigateur semble ne pas accepter le javascript : nous vous recommandons de l'activer afin de bénéficier des fonctionnalités avancées."+<>ZCR
$THTML:=$THTML+"    </noscript>"+<>ZCR
$THTML:=$THTML+"    <title>"+$TitrePage+"</title>"+<>ZCR
$THTML:=$THTML+" </head>"+<>ZCR
$THTML:=$THTML+" <body>"+<>ZCR
$THTML:=$THTML+"   <div id="+<>ZGuil+"header"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <a href="+<>ZGuil+"../index.shtml"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <img src="+<>ZGuil+"../images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1009"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    </a>"+<>ZCR
$THTML:=$THTML+"   </div>"+<>ZCR
$THTML:=$THTML+"   <div id="+<>ZGuil+"corps"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"contenu1"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"hautpage"+<>ZGuil+"> Pour revenir au site de l'ASA, cliquer sur le dessin ci-dessus </p>"+<>ZCR
$0:=$THTML