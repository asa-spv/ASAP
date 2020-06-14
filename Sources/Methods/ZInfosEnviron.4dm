//%attributes = {"publishedWeb":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 02/05/18, 15:58:56
  // ----------------------------------------------------
  // Méthode : ZInfosEnviron
  // Description
  // Méthode  de test de l'environnement de travail et de l'affichage
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($plateforme;$system;$machine)
C_BOOLEAN:C305(<>ZPC;<>ZClient)
C_TEXT:C284(<>ZSéparateur;<>NomImprimante;<>SMTP)
C_TEXT:C284(<>CheminDataLocal)
C_OBJECT:C1216($Object)

  // Savoir si l'on est client ou serveur / Standalone
<>ZClient:=Choose:C955(Application type:C494=4D mode distant:K5:5;True:C214;False:C215)

  // Savoir si l'on est en serveur sur AJAR
<>Ajar:=(Get 4D folder:C485(Dossier base:K5:14)="asaserveur@")

  // test du verrouillage du support
If (Is data file locked:C716)
	ALERT:C41("Le fichier de données est verrouillé. Impossible d'ouvrir la base.")
	QUIT 4D:C291
End if 

  //Recherche de la Plateforme et gestion de l'écran
_O_PLATFORM PROPERTIES:C365($plateforme;$system;$machine)
<>ZPC:=($plateforme=Windows:K25:3)
<>ZSéparateur:=Séparateur dossier:K24:12  //Permet de connaitre le séparateur de l'OS

  //******** CHEMINS D'ACCES DIVERS ET TAILLE DE LA BASE ************
<>CheminDossier4DLocal:=Get 4D folder:C485(Dossier 4D actif:K5:10)
<>NomMachine:=Current machine:C483
<>Utilisateur:=Current machine:C483

ZInfoBase 

<>NomImprimante:=Get current printer:C788
If (<>NomImprimante=" ")  //Ben y'en a pas d'imprimante par défaut 
	<>NomImprimante:=""
End if 

  // Présence et création des dossiers pour la gestion des mails
If (Not:C34(<>ZClient))  // Serveur, Standalone ou Enginée
	$CDPJ:=<>ZCheminData+"Dossier PJ"
	If (Test path name:C476($CDPJ)#Est un dossier:K24:2)
		CREATE FOLDER:C475($CDPJ;*)
	End if 
	
	$CDM:=<>ZCheminData+"Dossier Messages"
	If (Test path name:C476($CDM)#Est un dossier:K24:2)
		CREATE FOLDER:C475($CDM;*)
	End if 
End if 

  //  // Gestion de la case à cocher de "DlgPrincipal" qui concerne les mails et la publication sur le Web
  //  // Mails = notification de la base => ce n'est pas une gestion de mails
  //READ WRITE([XData])
  //QUERY([XData];[XData]XNom="CourrielOK";*)
  //QUERY([XData]; & [XData]XType="COK")
  //If (Records in selection([XData])=0)
  //CREATE RECORD([XData])
  //[XData]XNom:="CourrielOK"
  //[XData]XType:="COK"
  //End if 
  //[XData]XBool:=False
  //[XData]XDate:=Current date
  //SAVE RECORD([XData])

  //  // Gestion des comptes mails 
  //QUERY([XData];[XData]XType="CompteMail")
  //If (Records in selection([XData])=0)
  //CREATE RECORD([XData])
  //[XData]XType:="CompteMail"
  //[XData]XNom:="Perso"
  //OB SET($Object;"Adresse";"")
  //OB SET($Object;"ID";"")
  //OB SET($Object;"MdP";"")
  //OB SET($Object;"POP";"")
  //OB SET($Object;"SMTP";"")
  //OB SET($Object;"PortNumPOP";0)
  //OB SET($Object;"PortNumSMTP";0)
  //OB SET($Object;"SSL";False)
  //OB SET($Object;"ConserverCopie";True)
  //[XData]XObjet:=$Object

  //Else 
  //ZVerrouAttendre (->[XData])
  //End if 

  //SAVE RECORD([XData])
  //<>SMTP:=OB Get($Object;"SMTP";Is text)
  //ZAmnistiePartielle (->[XData])


If (Application type:C494#4D Server:K5:6)
	
	  // Possibilité d'arrêter le programme tout de suite en mode local interprété
	  // Modifié par : PE (27/06/2018)
	If ((Application type:C494=4D mode local:K5:1) & (Not:C34(Is compiled mode:C492)) & (Macintosh option down:C545))
		TRACE:C157
	End if 
	
	  // Gestion de l'écran
	HIDE TOOL BAR:C434
	
	If (Screen height:C188(*)<800) | (Screen width:C187(*)<1200)
		ALERT:C41("Réglez votre écran de façon à obtenir une résolution au moins égale à 1200 x 800")
		ZFinirProprement 
	End if 
	
	
	  // Plombage 
	  // TODO : Ajouter sous forme de composant les méthodes + formulaires utilisés dans Simply Asso
	
	
	  // TODO : Intégrer écran de paramétrage de la BDD Maileur (style interface)
	  // TODO : Dans le paramétrage, demander le chemin du dossier Cloud qui sera utilisé dans la variable <>PermCheDropBox
	
	
	SET WINDOW RECT:C444(-1;Menu bar height:C440+15;350;300)
	
End if 
If ((Application type:C494=4D mode local:K5:1) & (Not:C34(Is compiled mode:C492)) & (Macintosh option down:C545))
	TRACE:C157
End if 
QUERY:C277([XUtilisateurs:2];[XUtilisateurs:2]Passoire:5#"")
<>ZToutNeuf:=(Records in selection:C76([XUtilisateurs:2])=0)

QUERY:C277([XData:1];[XData:1]XType:3="TxTVA")
If (Records in selection:C76([XData:1])=0)
	
	CREATE RECORD:C68([XData:1])
	[XData:1]XType:3:="TxTVA"
	[XData:1]XNom:2:="Taux de TVA courant"
	[XData:1]XValeur:7:=20
	SAVE RECORD:C53([XData:1])
End if 
<>PermTVA:=[XData:1]XValeur:7