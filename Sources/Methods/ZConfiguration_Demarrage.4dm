//%attributes = {"executedOnServer":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 08:14:51
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : Configure_Demarrage
  // Description
  // Charge les paramètres de configuration au démarrage de la base

C_OBJECT:C1216($Config;$Papiers)

ARRAY TEXT:C222($TbAccount;1)
ARRAY TEXT:C222($TbDescription;1)
ARRAY TEXT:C222($TbEmail;1)
ARRAY TEXT:C222($TbUsername;1)
ARRAY TEXT:C222($TbPassword;1)
ARRAY TEXT:C222($TbPOPHost;1)
ARRAY TEXT:C222($TbSMTPHost;1)
ARRAY LONGINT:C221($TbPOP;1)
ARRAY LONGINT:C221($TbComptePrincipal;1)
ARRAY LONGINT:C221($TbSSL;1)
ARRAY LONGINT:C221($TbKeepOnServer;1)
ARRAY LONGINT:C221($TbVerifPeriodique;1)
ARRAY LONGINT:C221($TbPOP_Port;1)
ARRAY LONGINT:C221($TbSMTP_Port;1)
$TbComptePrincipal{1}:=1  // Pour définir entant que compte principal


QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))

If (Records in selection:C76([XData:1])=0)
	
	  // -------------------
	
	  // ---- Param Généraux
	OB SET:C1220($Config;"desc_nom";"Association QualiSoft")
	OB SET:C1220($Config;"desc_adresse1";"75 bis, rue de Cuire")
	OB SET:C1220($Config;"desc_adresse2";"")
	OB SET:C1220($Config;"desc_cp";"69004")
	OB SET:C1220($Config;"desc_ville";"LYON")
	OB SET:C1220($Config;"desc_telephone";"")
	OB SET:C1220($Config;"desc_fax";"")
	OB SET:C1220($Config;"desc_email";"info@association-qualisoft.eu")
	OB SET:C1220($Config;"desc_website";"www.association-qualisoft.eu")
	OB SET:C1220($Config;"desc_siret";"")
	OB SET:C1220($Config;"desc_siren";"")
	OB SET:C1220($Config;"desc_ape";"")
	OB SET:C1220($Config;"desc_intracommunautaire";"")
	
	
	  // Réattribution des tableaux dans l'objet
	OB SET ARRAY:C1227($Config;"TbAccount";$TbAccount)
	OB SET ARRAY:C1227($Config;"TbDescription";$TbDescription)
	OB SET ARRAY:C1227($Config;"TbEmail";$TbEmail)
	OB SET ARRAY:C1227($Config;"TbUsername";$TbUsername)
	OB SET ARRAY:C1227($Config;"TbPassword";$TbPassword)
	OB SET ARRAY:C1227($Config;"TbPOPHost";$TbPOPHost)
	OB SET ARRAY:C1227($Config;"TbSMTPHost";$TbSMTPHost)
	OB SET ARRAY:C1227($Config;"TbPOP";$TbPOP)
	OB SET ARRAY:C1227($Config;"TbComptePrincipal";$TbComptePrincipal)
	OB SET ARRAY:C1227($Config;"TbSSL";$TbSSL)
	OB SET ARRAY:C1227($Config;"TbKeepOnServer";$TbKeepOnServer)
	OB SET ARRAY:C1227($Config;"TbVerifPeriodique";$TbVerifPeriodique)
	OB SET ARRAY:C1227($Config;"TbPOP_Port";$TbPOP_Port)
	OB SET ARRAY:C1227($Config;"TbSMTP_Port";$TbSMTP_Port)
	
	  // ----- Param Sécurité
	  // Initialisation des paramètres par défaut de la BDD
	OB SET:C1220($Config;"sec_inactivité";<>ZPermDuréeInactif)
	OB SET:C1220($Config;"sec_cloud";"")
	OB SET:C1220($Config;"sec_password_cloud";"")
	OB SET:C1220($Config;"sec_de";"")
	OB SET:C1220($Config;"sec_a";"")
	
	
	  // Recupération du Chemin de la base 
	QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Papiers") & ([XData:1]XNom:2="Passeport"))
	$Papiers:=[XData:1]XObjet:18
	$Chemin:=OB Get:C1224($Papiers;"DossierActif";Est un texte:K8:3)
	
	If (<>ZPC)
		$Pos:=Position:C15("AppData";$Chemin)
		If ($Pos>0)
			$Chemin:=Substring:C12($Chemin;1;$Pos-1)
		End if 
		
	Else 
		  // Initialisation de <>PermCheDropBox = chemin de la DropBox locale
		$Chem:=Get 4D folder:C485(Dossier 4D actif:K5:10)
		$Pos1:=Position:C15(":";$Chem)
		$Reste:=Substring:C12($Chem;($pos1+1))
		$Pos2:=Position:C15(":";$Reste)
		$Reste:=Substring:C12($Reste;($pos2+1))
		$Pos3:=Position:C15(":";$Reste)
		$Base:=Substring:C12($Chem;1;($Pos1+$Pos2+$Pos3))
		$Chemin:=$Base+"Dropbox"+<>ZSéparateur
		
	End if 
	
	OB SET:C1220($Config;"sec_cloud";$Chemin)
	OB SET:C1220($Config;"option_news";1)
	OB SET:C1220($Config;"option_news_actifs";1)
	OB SET:C1220($Config;"option_news_delais";30)  // 30 jours par défaut
	
	  // Fin des paramètres par défauts
	  // -------------------
	CREATE RECORD:C68([XData:1])
	[XData:1]XType:3:="Configuration"
	[XData:1]XNom:2:="Configuration"
	[XData:1]XObjet:18:=$Config
	SAVE RECORD:C53([XData:1])
	ZAmnistiePartielle (->[XData:1])
	
	C_PICTURE:C286($img)
	CREATE RECORD:C68([XData:1])
	[XData:1]XType:3:="Configuration"
	[XData:1]XNom:2:="Logo"
	[XData:1]XImage:11:=$img
	SAVE RECORD:C53([XData:1])
	ZAmnistiePartielle (->[XData:1])
	
	
Else 
	  // Chargement des paramètres
	$Config:=[XData:1]XObjet:18
	ZAmnistiePartielle (->[XData:1])
	
	<>ZPermDuréeInactif:=OB Get:C1224($Config;"sec_inactivité";Est un entier long:K8:6)
	<>ZNews:=(OB Get:C1224($Config;"option_news";Est un entier long:K8:6)=1)
	<>ZNewsActifs:=(OB Get:C1224($Config;"option_news_actifs";Est un entier long:K8:6)=1)
	
End if 
