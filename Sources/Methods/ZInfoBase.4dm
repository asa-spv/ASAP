//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 03/05/18, 19:47:00
  // ----------------------------------------------------
  // Paramètres
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZInfoBase
  // Description
  //

C_TEXT:C284(<>ZSaintDuJour;<>ZCheminStruture;<>ZCheminData;<>ZTailleBase;<>ZIPbase;<>ZRacineWeb;<>ZDossierActif;<>ZDossierRessources)
C_OBJECT:C1216($Ob)

$Chem:=ZDocNomFichier (System folder:C487(Bureau:K41:16);1)
<>PermCheDropBox:=$Chem+"Dropbox"+Séparateur dossier:K24:12
$OK:=Test path name:C476(<>PermCheDropBox)

If (<>ZClient)
	QUERY:C277([XData:1];[XData:1]XNom:2="Passeport";*)
	QUERY:C277([XData:1]; & [XData:1]XType:3="Papiers")
	$Ob:=[XData:1]XObjet:18
	
	<>ZCheminStruture:=OB Get:C1224($ob;"Structure";Est un texte:K8:3)
	<>ZCheminData:=OB Get:C1224($ob;"Data";Est un texte:K8:3)
	<>ZTailleBase:=String:C10(Round:C94(OB Get:C1224($ob;"TailleBase";Est un entier long:K8:6)/1024/1024;1))+" Mo"
	<>ZIPbase:=OB Get:C1224($ob;"IP";Est un texte:K8:3)
	<>ZRacineWeb:=OB Get:C1224($ob;"RacineWeb";Est un texte:K8:3)
	<>ZDossierActif:=OB Get:C1224($ob;"DossierActif";Est un texte:K8:3)
	<>ZDossierRessources:=OB Get:C1224($ob;"DossierRessources";Est un texte:K8:3)
	
	
Else 
	
	
	<>ZCheminStruture:=Structure file:C489
	<>ZCheminData:=Data file:C490
	<>ZTailleBase:=String:C10(Get document size:C479(Data file:C490)/1024/1024)+" Mo"
	  // <>ZIPbase:=ZTrouveIPExterne 
	<>ZIPbase:=""
	<>ZRacineWeb:=Get 4D folder:C485(Dossier racine HTML:K5:20;*)
	<>ZDossierActif:=Get 4D folder:C485(Dossier 4D actif:K5:10;*)
	<>ZDossierRessources:=Get 4D folder:C485(Dossier Resources courant:K5:16;*)
	
	<>PermCheDosPdf:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"pdf"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosPdf)<0)  // c'est le chemin de dossier des pdf du site Web
		CREATE FOLDER:C475(<>PermCheDosPdf)
	End if 
	
	<>PermCheDosRap:=<>PermCheDosPdf+"Rapports"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosRap)<0)  // c'est le chemin de dossier de téléchargement du rapport
		CREATE FOLDER:C475(<>PermCheDosRap)
	End if 
	
	<>PermCheDosFac:=<>PermCheDosPdf+"Factures"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosRap)<0)  // c'est le chemin de dossier de téléchargement du rapport
		CREATE FOLDER:C475(<>PermCheDosFac)
	End if 
	
	<>PermCheDosAtt:=<>PermCheDosPdf+"Attestations"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosAtt)<0)  // c'est le chemin de dossier des attestations du site Web
		CREATE FOLDER:C475(<>PermCheDosAtt)
	End if 
	
	<>PermCheDosTel:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"Téléchargements"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosTel)<0)  // c'est le chemin de dossier des téléchargements du site Web
		CREATE FOLDER:C475(<>PermCheDosTel)
	End if 
	
	<>PermCheDosPJCourrielWeb:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"PJCourriels"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosPJCourrielWeb)<0)  // c'est le chemin de dossier des téléchargements du site Web
		CREATE FOLDER:C475(<>PermCheDosPJCourrielWeb)
	End if 
	
	<>CDDossierEmailsContraries:=<>PermCheDropBox+"synchrobases"+Séparateur dossier:K24:12+"Emails non reçus"+Séparateur dossier:K24:12
	If (Test path name:C476(<>CDDossierEmailsContraries)#Est un dossier:K24:2)
		CREATE FOLDER:C475(<>CDDossierEmailsContraries)
	End if 
	
	  // Les dossiers pour le RAEMA
	<>PermCheDosRapIni:=Get 4D folder:C485(Dossier base:K5:14)+"Dossier Rapports"+<>ZSéparateur
	If (Test path name:C476(<>PermCheDosRapIni)<0)  // c'est le chemin de dossier de dépot des rapports
		CREATE FOLDER:C475(<>PermCheDosRapIni)
	End if 
	
End if 

<>PermCheDosPJCourrielSource:=<>PermCheDropBox+"SynchroBases"+Séparateur dossier:K24:12+"DossierPJCourriels"+Séparateur dossier:K24:12
If (Test path name:C476(<>PermCheDosPJCourrielSource)<0)  // c'est le chemin de dossier des téléchargements du site Web
	CREATE FOLDER:C475(<>PermCheDosPJCourrielSource)
End if 

  // Les dossiers pour le Mail
$CAT:=Get 4D folder:C485(Dossier base:K5:14)+"Dossier Messages"+<>ZSéparateur
If (Test path name:C476($CAT)<0)  // c'est un chemin de dossier
	CREATE FOLDER:C475($CAT)
End if 
$CAT:=Get 4D folder:C485(Dossier base:K5:14)+"Dossier PJ"+<>ZSéparateur
If (Test path name:C476($CAT)<0)  // c'est un chemin de dossier
	CREATE FOLDER:C475($CAT)
End if 




