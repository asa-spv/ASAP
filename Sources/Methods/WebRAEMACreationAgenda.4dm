//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/03/16, 16:31:06
  // ----------------------------------------------------
  // Méthode : WebRAEMACreationAgenda
  // Description
  // Permet la création automatique de l'agenda des RAEMA
  // à partir des renseignements des schéma des RAEMA
  // Paramètres : $1 = Vrai si récents et faux sinon
  // {$2} = version anglaise si existe
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
C_BOOLEAN:C305($recents;$1)
ARRAY TEXT:C222($TbNomFichiers;4)
$TbNomFichiers{1}:="raemaactualites.shtml"  // Page agenda RAEMA Récents en Français
$TbNomFichiers{2}:="raemaactualitesA.shtml"  // Page agenda RAEMA Récents en Anglais
$TbNomFichiers{3}:="raemaagendaancien.shtml"  // Page agenda RAEMA Anciens en Français
$TbNomFichiers{4}:="raemaagendaancienA.shtml"  // Page agenda RAEMA Anciens en Anglais


$recents:=$1
$anglais:=(Count parameters:C259>1)
$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html PUBLIC "+<>ZGuil+"-//W3C//DTD XHTML 1.0 Transitional//EN"+<>ZGuil+" "+<>ZGuil+"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+" <head>"+<>ZCR
$THTML:=$THTML+"  <title>AGENDA</title>"+<>ZCR
$THTML:=$THTML+"  <!--4dinclude HeaderASA.shtml-->"+<>ZCR
$THTML:=$THTML+" </head>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"<body>"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"header"+<>ZGuil+"align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
If ($recents)  // RAEMAS récents
	If ($anglais)  // En anglais
		$THTML:=$THTML+"   <a id="+<>ZGuil+"flagA"+<>ZGuil+" href="+<>ZGuil+"w2"+$TbNomFichiers{1}+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"    <img  src="+<>ZGuil+"images/DrapeauF.gif"+<>ZGuil+"alt="+<>ZGuil+"drapeau français"+<>ZGuil+"width="+<>ZGuil+"30px"+<>ZGuil+"/>"+<>ZCR
		$nomfichier:=$TbNomFichiers{2}  // Page agenda RAEMA Récents en Anglais
		$href:="w2"+$TbNomFichiers{4}  // Page agenda RAEMA Anciens en Anglais
	Else   // En français
		$THTML:=$THTML+"   <a id="+<>ZGuil+"flagA"+<>ZGuil+" href="+<>ZGuil+"w2"+$TbNomFichiers{2}+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"    <img  src="+<>ZGuil+"images/DrapeauA.gif"+<>ZGuil+"alt="+<>ZGuil+"drapeau anglais"+<>ZGuil+"width="+<>ZGuil+"30px"+<>ZGuil+"/>"+<>ZCR
		$nomfichier:=$TbNomFichiers{1}  //Page agenda RAEMA Récents en Français
		$href:="w2"+$TbNomFichiers{3}  // Page agenda RAEMA Anciens en Français
	End if 
Else   // RAEMAS anciens
	If ($anglais)  // En anglais
		$THTML:=$THTML+"   <a id="+<>ZGuil+"flagA"+<>ZGuil+" href="+<>ZGuil+"w2"+$TbNomFichiers{3}+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"    <img  src="+<>ZGuil+"images/DrapeauF.gif"+<>ZGuil+"alt="+<>ZGuil+"drapeau français"+<>ZGuil+"width="+<>ZGuil+"30px"+<>ZGuil+"/>"+<>ZCR
		$nomfichier:=$TbNomFichiers{4}  //  Page agenda RAEMA Anciens en Anglais
		$href:="w2"+$TbNomFichiers{2}  // Page agenda RAEMA Récents en Anglais
	Else   // En français
		$THTML:=$THTML+"   <a id="+<>ZGuil+"flagA"+<>ZGuil+" href="+<>ZGuil+"w2"+$TbNomFichiers{4}+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"    <img  src="+<>ZGuil+"images/DrapeauA.gif"+<>ZGuil+"alt="+<>ZGuil+"drapeau anglais"+<>ZGuil+"width="+<>ZGuil+"30px"+<>ZGuil+"/>"+<>ZCR
		$nomfichier:=$TbNomFichiers{3}  // Page agenda RAEMA Anciens en Français
		$href:="w2"+$TbNomFichiers{1}  // Page agenda RAEMA Récents en Français
	End if 
End if 
$THTML:=$THTML+"   </a>"
$THTML:=$THTML+"    <!--4dinclude bandeau.shtml-->"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"corps"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+" "+<>ZCR
$THTML:=$THTML+"   <div id="+<>ZGuil+"contenu1"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude menuraema.shtml-->"+<>ZCR
$THTML:=$THTML+"     <br /> <br />"+<>ZCR2

  // Le titre de la page
$An:=Year of:C25(Current date:C33)
$dateDébut:=Date:C102("01/01/"+String:C10($An-1))
If ($recents)
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]DateEnvoiColis:3>$dateDébut)
	If ($anglais)
		$type:="List of recent RAEMA (since "+String:C10($An-1)
		$textelien:="Access to old RAEMA campaigns"
	Else 
		$type:="Agenda des RAEMA récents (depuis "+String:C10($An-1)
		$textelien:="Accéder aux campagnes du RAEMA plus anciennes"
	End if 
	
Else 
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]DateEnvoiColis:3<$dateDébut)
	If ($anglais)
		$type:="List of old RAEMA (2007 to "+String:C10($An-2)
		$textelien:="Back to the latest RAEMA campaigns"
	Else 
		$type:="Agenda des RAEMA anciens (de 2007 à "+String:C10($An-2)
		$textelien:="Retourner aux campagnes du RAEMA plus récentes"
	End if 
End if 
$THTML:=$THTML+"    <p class="+<>ZGuil+"grandtitrepage"+<>ZGuil+">"+$type+")</p> <br />"+<>ZCR

  // liste des RAEMA
$FT:=Records in selection:C76([RAEMACampagnes:20])
ORDER BY:C49([RAEMACampagnes:20];[RAEMACampagnes:20]DateEnvoiColis:3;<)
For ($Salé;1;$FT)
	$THTML:=$THTML+WebEcritUneCampagne ($anglais)
	NEXT RECORD:C51([RAEMACampagnes:20])
End for 

$THTML:=$THTML+"       <br />  <br />"+<>ZCR
$THTML:=$THTML+"     <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"
$THTML:=$THTML+"      <a class="+<>ZGuil+"titrepage"+<>ZGuil+" href="+<>ZGuil+$href+<>ZGuil+">"+$textelien+"</a> <br />"+<>ZCR
$THTML:=$THTML+"     </p>"
$THTML:=$THTML+"       <br />  <br />"+<>ZCR

$THTML:=$THTML+"   </div>"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude pied.shtml-->"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+" </body>"+<>ZCR
$THTML:=$THTML+"</html>"+<>ZCR

$CD:=Get 4D folder:C485(Dossier base:K5:14)+"pages_Web"+Séparateur dossier:K24:12+$nomfichier
If (Test path name:C476($CD)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CD)
End if 
$Doc:=Create document:C266($CD)
SEND PACKET:C103($Doc;$THTML)
CLOSE DOCUMENT:C267($Doc)
