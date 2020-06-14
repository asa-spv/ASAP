//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/12/18, 16:28:59
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : WebDevisEcritPage
  // Description
  // // méthode qui écrit le HTML initial de la page du devis
$UUIDLabo:=$1
$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR2

$THTML:=$THTML+" <head>"+<>ZCR
$THTML:=$THTML+"  <title>Devis RAEMA Gel</title>"+<>ZCR
$THTML:=$THTML+"  <!--4dinclude HeaderRaema.shtml-->"+<>ZCR
$THTML:=$THTML+" </head>"+<>ZCR2

$THTML:=$THTML+"<body>"+<>ZCR2

$THTML:=$THTML+" <div id="+<>ZGuil+"header"+<>ZGuil+" align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <!--4dinclude bandeau.shtml-->"+<>ZCR
$THTML:=$THTML+" </div>"+<>ZCR2

$THTML:=$THTML+" <div id="+<>ZGuil+"corps"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <br /><br />"+<>ZCR
  // <>AnCourantDevisRGA est défini dans ASAPFabriqueTbPrestations
$THTML:=$THTML+"  <p class="+<>ZGuil+"grandtitrepage"+<>ZGuil+">Devis RAEMA gel : année "+<>AnCourantDevisRGA+"</p>"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"devarticle"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"   <br />"+<>ZCR
If ($UUIDLabo="")
	$THTML:=$THTML+"   <p class="+<>ZGuil+"grandhautpage"+<>ZGuil+">Participez-vous déjà au RAEMA ?</p>"+<>ZCR
	$THTML:=$THTML+"   <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"    <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"raemaok"+<>ZGuil+" name="+<>ZGuil+"radio"+<>ZGuil+" >Oui</input>     "+<>ZCR
	$THTML:=$THTML+"    <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"raemako"+<>ZGuil+" name="+<>ZGuil+"radio"+<>ZGuil+" >Non</input>"+<>ZCR
	$THTML:=$THTML+"   </p>"+<>ZCR
End if 
  // Zone de formulaire qui réagira à l'envoi par WebDevisRecevoir
$THTML:=$THTML+"   <form action="+<>ZGuil+"WebDevisRecevoir"+$UUIDLabo+<>ZGuil+" method="+<>ZGuil+"post"+<>ZGuil+">"+<>ZCR
  // Zone d'identification si le laboratoire a déjà participé au RAEMA
If ($UUIDLabo="")
	$THTML:=$THTML+"    <div id="+<>ZGuil+"identificationlabo"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"       <p class="+<>ZGuil+"grandhautpagedecale"+<>ZGuil+">Identifiez-vous</p>"+<>ZCR
	$THTML:=$THTML+"       <label for="+<>ZGuil+"numlabo"+<>ZGuil+">   Entrer votre n° de labo</label>"+<>ZCR
	$THTML:=$THTML+"       <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"numlabo"+<>ZGuil+" name="+<>ZGuil+"numlabo"+<>ZGuil+" size="+<>ZGuil+"2"+<>ZGuil+" maxlength="+<>ZGuil+"3"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"       <label for="+<>ZGuil+"mdplabo"+<>ZGuil+">    et votre mot de passe</label>"+<>ZCR
	$THTML:=$THTML+"       <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"mdplabo"+<>ZGuil+" name="+<>ZGuil+"mdplabo"+<>ZGuil+" maxlength="+<>ZGuil+"10"+<>ZGuil+" size="+<>ZGuil+"10"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"       <button id="+<>ZGuil+"envoi"+<>ZGuil+"  class="+<>ZGuil+"boutonbleu"+<>ZGuil+" >Envoyer</button>"+<>ZCR
	$THTML:=$THTML+"    </div>"+<>ZCR
End if 

If ($UUIDLabo#"")
	$THTML:=$THTML+"       <div id="+<>ZGuil+"ECDevisGel"+<>ZGuil+"></div>"+<>ZCR
End if 
$THTML:=$THTML+"       <p id="+<>ZGuil+"detaillabo"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+"></p>"+<>ZCR

  // Zone d'identification si le laboratoire n'a jamais participé au RAEMA
$THTML:=$THTML+"    <div id="+<>ZGuil+"nouveaulabo"+<>ZGuil+" class="+<>ZGuil+"textedecale30"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <p class="+<>ZGuil+"grandhautpagedecale"+<>ZGuil+">Précisez nom et coordonnées de votre laboratoire </p>"+<>ZCR
$THTML:=$THTML+"     <table>"+<>ZCR
$THTML:=$THTML+"      <tr> "+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneadroite"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"         <label for="+<>ZGuil+"Nom"+<>ZGuil+">Nom du laboratoire<span class="+<>ZGuil+"rouge"+<>ZGuil+">*</span> </label>"+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneagauchel"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"         <input class="+<>ZGuil+"colonneagauchel"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"Nom"+<>ZGuil+" id="+<>ZGuil+"devlabnom"+<>ZGuil+" size="+<>ZGuil+"85"+<>ZGuil+" /> "+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"      </tr>"+<>ZCR
$THTML:=$THTML+"      <tr> "+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneadroite"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <label for="+<>ZGuil+"adresse"+<>ZGuil+">Adresse postale<span class="+<>ZGuil+"rouge"+<>ZGuil+">*</span> </label>"+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneagauchel"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <input class="+<>ZGuil+"colonneagauchel"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"adresse"+<>ZGuil+" id="+<>ZGuil+"devlabadresse"+<>ZGuil+" size="+<>ZGuil+"85"+<>ZGuil+" /> "+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"      </tr>"+<>ZCR
$THTML:=$THTML+"      <tr> "+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneadroite"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <label for="+<>ZGuil+"cp"+<>ZGuil+">code postal et ville <span class="+<>ZGuil+"rouge"+<>ZGuil+">*</span> </label>"+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneagauchel"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <input class="+<>ZGuil+"colonneagauchel"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"cp"+<>ZGuil+" id="+<>ZGuil+"devlabcp"+<>ZGuil+" size="+<>ZGuil+"5"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"        <input class="+<>ZGuil+"colonneagauchel"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"ville"+<>ZGuil+" id="+<>ZGuil+"devlabville"+<>ZGuil+" size="+<>ZGuil+"55"+<>ZGuil+" /> "+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"      </tr>"+<>ZCR
$THTML:=$THTML+"      <tr> "+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneadroite"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <label for="+<>ZGuil+"pays"+<>ZGuil+">Pays</label>"+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneagauchel"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <input class="+<>ZGuil+"colonneagauchel"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"pays"+<>ZGuil+" id="+<>ZGuil+"pays"+<>ZGuil+" size="+<>ZGuil+"55"+<>ZGuil+" /> "+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"      </tr>"+<>ZCR
$THTML:=$THTML+"      <tr> "+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneadroite"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <label for="+<>ZGuil+"mail"+<>ZGuil+">Adresse mail <span class="+<>ZGuil+"rouge"+<>ZGuil+">*</span> </label>"+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"colonneagauchel"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"        <input class="+<>ZGuil+"colonneagauchel"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"mail"+<>ZGuil+" id="+<>ZGuil+"devlabmail"+<>ZGuil+" size="+<>ZGuil+"65"+<>ZGuil+" maxlenght="+<>ZGuil+"65"+<>ZGuil+" onChange="+<>ZGuil+"verif_mail(this)"+<>ZGuil+"/> "+<>ZCR
$THTML:=$THTML+"       </td>"+<>ZCR
$THTML:=$THTML+"       </tr>"+<>ZCR
$THTML:=$THTML+"     </table>"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"detailraemagel"+<>ZGuil+">"+<>ZCR

  // Emplacement du futur programme de campagne et du prix
If ($UUIDLabo#"")
	$L:=Find in array:C230(<>TbPerUUID;$UUIDLabo)
	If ($L>0)
		$Code:=<>TbPerIdentificateur{$L}
		$NumLabo:=RAEMADemoduleMdPWeb ($Code)
		$Mess:="ECdevisid"+String:C10($NumLabo)+"_"+$Code
		$THTML:=$THTML+WebDevisIdentification ($Mess)
	End if 
End if 
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"   </form>"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
  // bloc des tarifs et du baratin d'explication des règles de facturation
$THTML:=$THTML+"  <div id="+<>ZGuil+"devaside"+<>ZGuil+" class="+<>ZGuil+"textebanal"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <br /><br />"+<>ZCR
  // Les tarifs
$THTML:=$THTML+"   <span class="+<>ZGuil+"textebanalgrand"+<>ZGuil+"><b>Les Tarifs "+<>AnCourantDevisRGA+"</b><br /></span> <br />"+<>ZCR
$THTML:=$THTML+"    <b>Pour les 2 campagnes</b><br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G21")+" € H.T. pour 1 essai <br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G22")+" € H.T. pour 2 essais<br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G23")+" € H.T. pour 3 essais<br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G24")+" € H.T. pour 4 essais<br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G25")+" € H.T. pour 5 essais<br />         "+<>ZCR
$THTML:=$THTML+"    <b>Pour une seule campagne</b><br /> "+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G11")+" € H.T. pour 1 essai <br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G12")+" € H.T. pour 2 essais <br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G13")+" € H.T. pour 3 essais <br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G14")+" € H.T. pour 4 essais <br />"+<>ZCR
$THTML:=$THTML+"    - "+WebDevisCracheTarifRG ("G15")+" € H.T. pour 5 essais <br />"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"    Pot supplémentaire <b>AVEC</b> rapport "+WebDevisCracheTarifRG ("GPA")+" € H.T. par pot. <br />"+<>ZCR
$THTML:=$THTML+"    Pot supplémentaire <b>SANS</b> rapport "+WebDevisCracheTarifRG ("GPS")+" € H.T. par pot.<br /> "+<>ZCR
$THTML:=$THTML+"    <br /> <br />"+<>ZCR2
  // Le principe de facturation
$THTML:=$THTML+"    <b>Principe de facturation</b><br />"+<>ZCR
$THTML:=$THTML+"    Pour une demande sur une seule campagne, le tarif est appliqué pour les pots de l’envoi principal,"+<>ZCR
$THTML:=$THTML+"    le ou les envois secondaires avec rapport COFRAC ou non et les pots supplémentaires.<br />"+<>ZCR
$THTML:=$THTML+"    Pour une demande sur les deux campagnes, le prix est calculé sur le nombre commun de détermination"+<>ZCR
$THTML:=$THTML+"    et l’excédent est compté comme pot supplémentaire sans rapport.<br />"+<>ZCR
$THTML:=$THTML+"    <br />"+<>ZCR
$THTML:=$THTML+"    <b>Pourquoi ces tarifs ?</b><br />"+<>ZCR
$THTML:=$THTML+"    Il est de l’intérêt des laboratoires que le nombre de participants soit suffisant"+<>ZCR
$THTML:=$THTML+"    pour permettre d’obtenir des résultats statistiquement robustes.<br />"+<>ZCR
$THTML:=$THTML+"    C’est pourquoi, les tarifs indiqués les incitent fortement à participer"+<>ZCR
$THTML:=$THTML+"    aux deux campagnes (mai et décembre) et à la détermination d’un grand nombre de germes.<br />"+<>ZCR
$THTML:=$THTML+"    <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />"+<>ZCR
$THTML:=$THTML+"   </div> "+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR2

$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude pied.shtml-->"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+"  <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/devisraemagel.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+" </body>"+<>ZCR2

$THTML:=$THTML+"</html>"+<>ZCR
WEB SEND TEXT:C677($THTML)