//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/10/19, 07:09:48
  // ----------------------------------------------------
  // Méthode : WebEspaceHTMLDonneesPerso
  // Description
  // Méthode qui écrit le HTML de l'espace personnel
  // ----------------------------------------------------
$Langue:=$1
$UUID:=$2
WebInitTraductionsEC 
$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"  <head>"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude HeaderRaema.shtml-->"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-espace-participants.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <title>Données personnelles</title>"+<>ZCR
$THTML:=$THTML+"  </head>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"  <body>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"header"+<>ZGuil+" align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"      <a href="+<>ZGuil+"../index.shtml"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <img src="+<>ZGuil+"../images/bandeau.jpg"+<>ZGuil+"alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1009"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$InitialeInverse:=(Num:C11($Langue="F")*"A")+(Num:C11($Langue="A")*"F")
$THTML:=$THTML+"      <a id="+<>ZGuil+"flagA"+<>ZGuil+" href="+<>ZGuil+"DonneesPersonnelles"+$InitialeInverse+$UUID+<>ZGuil+">"+<>ZCR
$Pays:=(Num:C11($Langue="F")*"français")+(Num:C11($Langue="A")*"anglais")
$THTML:=$THTML+"        <img src="+<>ZGuil+"../images/Drapeau"+$InitialeInverse+".gif"+<>ZGuil+" alt="+<>ZGuil+"drapeau "+$Pays+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
  //$THTML:=$THTML+"      <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"        Pour revenir au site de l'ASA, cliquer sur le dessin ci-dessus"+<>ZCR
  //$THTML:=$THTML+"      </p>"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"corps"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <br /><br />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"GrisEncadre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          "+<>ZCR+WebTraduitTexte ("Info données personnelles";$Langue)+<>ZCR
$THTML:=$THTML+"          <br />"+<>ZCR+WebTraduitTexte ("Modif données perso";$Langue)+<>ZCR+"<a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("contacter l'ASA";$Langue)+<>ZCR+"</a>"+<>ZCR
$THTML:=$THTML+"          <br />"+<>ZCR+WebTraduitTexte ("Pour revenir à l'espace client,";$Langue)+<>ZCR+"<a href="+<>ZGuil+"javascript:history.go(-1)"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("cliquer ici";$Langue)+<>ZCR+"</a>"+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"      <!--<h1>Vos données personnelles</h1>-->"+<>ZCR
  // LIVRAISON
If ($Langue="A")
	$THTML:=$THTML+"      <img class="+<>ZGuil+"DecaleGauche"+<>ZGuil+" src="+<>ZGuil+"../images/DeliveryTitre.png"+<>ZGuil+" alt="+<>ZGuil+"Livraion"+<>ZGuil+" width="+<>ZGuil+"240px"+<>ZGuil+" height="+<>ZGuil+"65px"+<>ZGuil+"/>"+<>ZCR
Else 
	$THTML:=$THTML+"      <img class="+<>ZGuil+"DecaleGauche"+<>ZGuil+" src="+<>ZGuil+"../images/LivraisonTitre.png"+<>ZGuil+" alt="+<>ZGuil+"Livraion"+<>ZGuil+" width="+<>ZGuil+"240px"+<>ZGuil+" height="+<>ZGuil+"65px"+<>ZGuil+"/>"+<>ZCR
End if 
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("Personne à contacter";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarNomPersonneContact+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("Adresse de livraison";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarAdresseLivraison+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("N° de téléphone";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarPhoneContact+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("N° de fax";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarFaxContact+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2 class="+<>ZGuil+"MargeBas"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Adresse mail de la personne à contacter ";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarMailPersonneCommunication+"</span></h2>"+<>ZCR

  // FACTURATION
If ($Langue="A")
	$THTML:=$THTML+"      <img class="+<>ZGuil+"DecaleGauche"+<>ZGuil+" src="+<>ZGuil+"../images/InvoicingTitre.png"+<>ZGuil+" alt="+<>ZGuil+"Livraion"+<>ZGuil+" width="+<>ZGuil+"240px"+<>ZGuil+" height="+<>ZGuil+"65px"+<>ZGuil+"/>"+<>ZCR
Else 
	$THTML:=$THTML+"      <img class="+<>ZGuil+"DecaleGauche"+<>ZGuil+" src="+<>ZGuil+"../images/FacturationTitre.png"+<>ZGuil+" alt="+<>ZGuil+"Livraion"+<>ZGuil+" width="+<>ZGuil+"240px"+<>ZGuil+" height="+<>ZGuil+"65px"+<>ZGuil+"/>"+<>ZCR
End if 
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("Personne à contacter";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarNomPersonneFacturation+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("Adresse facturation";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarAdresseFacturation+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("N° de téléphone";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarPhoneFacturation+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2>"+<>ZCR+WebTraduitTexte ("N° de fax";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarFaxFacturation+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <h2 class="+<>ZGuil+"MargeBas"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Adresse mail de la personne à contacter ";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarMailPersonneFacturation+"</span></h2>"+<>ZCR
  // RAPPORT
If ($Langue="A")
	$THTML:=$THTML+"      <img class="+<>ZGuil+"DecaleGauche"+<>ZGuil+" src="+<>ZGuil+"../images/ReportTitre.png"+<>ZGuil+" alt="+<>ZGuil+"Livraion"+<>ZGuil+" width="+<>ZGuil+"240px"+<>ZGuil+" height="+<>ZGuil+"65px"+<>ZGuil+"/>"+<>ZCR
Else 
	$THTML:=$THTML+"      <img class="+<>ZGuil+"DecaleGauche"+<>ZGuil+" src="+<>ZGuil+"../images/RapportTitre.png"+<>ZGuil+" alt="+<>ZGuil+"Livraion"+<>ZGuil+" width="+<>ZGuil+"240px"+<>ZGuil+" height="+<>ZGuil+"65px"+<>ZGuil+"/>"+<>ZCR
End if 
$THTML:=$THTML+"      <h2 class="+<>ZGuil+"MargeBas"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Adresse mail de la personne à contacter ";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarMailPersonneRapport+"</span></h2>"+<>ZCR
  // COMMUNICATION
$THTML:=$THTML+"      <img class="+<>ZGuil+"DecaleGauche"+<>ZGuil+" src="+<>ZGuil+"../images/CommunicationTitre.png"+<>ZGuil+" alt="+<>ZGuil+"Communication"+<>ZGuil+" width="+<>ZGuil+"240px"+<>ZGuil+" height="+<>ZGuil+"65px"+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"      <h2 class="+<>ZGuil+"MargeBas"+<>ZGuil+">"+<>ZCR+WebTraduitTexte ("Adresse mail de la personne à contacter ";$Langue)+<>ZCR+"<span class="+<>ZGuil+"h2sansB"+<>ZGuil+">"+VarMailPersonneCommunication+"</span></h2>"+<>ZCR
$THTML:=$THTML+"      <br/>"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"   <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      Site officiel de l'association Animal - Société - Aliment (ASA)  <br />"+<>ZCR
$THTML:=$THTML+"      Adresse : Bâtiment Jean GIRARD - Ecole Nationale Vétérinaire d'Alfort -7 avenue du Général de Gaulle - 94704 Maisons-Alfort Cedex    FRANCE <br />"+<>ZCR
$THTML:=$THTML+"      Téléphone : <b>+ 33 (0)1 56 29 36 30</b>       Fax : <b>+ 33 (0)9 61 24 33 81</b>       e-mail :"+<>ZCR
$THTML:=$THTML+"      <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       <b>asa-spv@wanadoo.fr</b>"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"      <em>Pour signaler un problème, cliquez sur le lien suivant <a href="+<>ZGuil+"mailto:cegeheme@wanadoo.fr"+<>ZGuil+"> écrire au webmaster</a></em>"+<>ZCR
$THTML:=$THTML+"      <br /><br />"+<>ZCR
$THTML:=$THTML+"   </div>"+<>ZCR
$THTML:=$THTML+"  </body>"+<>ZCR
$THTML:=$THTML+"</html>"
$0:=$THTML
