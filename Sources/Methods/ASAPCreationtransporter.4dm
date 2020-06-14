//%attributes = {}
  // ----------------------------------------------------  // ----------------------------------------------------
  // Méthode : ASAPCreationtransporter
  // Description
  //  Création d'un transporteur 
  //  avec les caractéristiques courantes du serveur de mail
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 28/04/20, 18:24:34

C_OBJECT:C1216($server;$0)
QUERY:C277([XData:1];[XData:1]XNom:2="Données courriel";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="MWb")
$server:=New object:C1471
$server.host:=[XData:1]XObjet:18.NomFAM.ServeurEnvoi
$server.port:=[XData:1]XObjet:18.NomFAM.PortEnvoi
$Pos:=Position:C15(Char:C90(Arobase:K15:46);[XData:1]XObjet:18.NomFAM.AdresseEnvoi)
$server.user:=[XData:1]XObjet:18.NomFAM.AdresseEnvoi
$server.password:=[XData:1]XObjet:18.NomFAM.MotDePasseEnvoi
$0:=SMTP New transporter:C1608($server)  //  Création du transporteur
