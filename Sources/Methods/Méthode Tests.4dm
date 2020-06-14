//%attributes = {}
C_OBJECT:C1216($transporter;$ObjetMail;$Succes)

$transporter:=ASAPCreationtransporter 
$ObjetMail:=New object:C1471
$ObjetMail.from:=$transporter.user
$ObjetMail.subject:="Mon beau mail"
$ObjetMail.to:="cegeheme@wanadoo.fr"
  //$ObjetMail.cc:="claude.grandmontagne@gmail.com"
  //$ObjetMail.bcc:="qualisoft@me.com"
$texteBrut:="Gloire à qui, n'ayant pas d'idéal sacro-saint,"+<>ZCR
$texteBrut:=$texteBrut+"Se borne à ne pas trop emmerder ses voisins"
  //$ObjetMail.textBody:=$texteBrut
  //$ObjetMail.htmlBody:=remplacer chaine($texteBrut;<>ZCR;"<br />")
$html:="<h1>Voici mon message</h1>"
$html:=$html+"Gloire à qui, n'ayant pas d'idéal sacro-saint,<br />"
$html:=$html+"Se borne à ne pas trop <b>emmerder ses voisins</b>"
$ObjetMail.htmlBody:="<html><body>"+$html+"</body></html>"
$CDPJ:="IMacASA2017HD:Users:asa:Claude:Docs:Pastis des homs.pdf"
$ObjetMail.attachments:=New collection:C1472(MAIL New attachment:C1644($CDPJ))
$Succes:=$transporter.send($ObjetMail)




  //LIRE CLIENTS INSCRITS(listeClients;nbMéthodes)
  //TRACE

  //CHERCHER([RAEMACampagnes];[RAEMACampagnes]NumCampagne="@a";*)
  //CHERCHER([RAEMACampagnes]; & [RAEMACampagnes]NumCampagne>"65")
  //SÉLECTION RETOUR([RAEMAGermes]UUIDCampagne)
  //CHERCHER DANS SÉLECTION([RAEMAGermes];[RAEMAGermes]NomFr#"condi@")
  //SÉLECTION VERS TABLEAU([RAEMAGermes]NomFr;$TbNomGermesFr)
  //$FT:=Taille tableau($TbNomGermesFr)
  //Boucle ($Salé;1;$FT)
  //$L:=Chercher dans tableau(<>TbNomGermeSchémaGEL;$TbNomGermesFr{$Salé})
  //Si ($L<0)

  //TRACE

  //Fin de si 
  //Fin de boucle 
