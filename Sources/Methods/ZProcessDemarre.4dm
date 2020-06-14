//%attributes = {}
  // ----------------------------------------------------
  // nom utilisateur (OS) : iMacASA2017
  // date et heure : 24/01/18, 15:17:29
  // ----------------------------------------------------
  // méthode : ZProcessDemarre
  // description
  // méthode exécutée au démarrage de la base dans le process principal
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)

QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Testeur")
If (Records in selection:C76([Personnes:12])=0)
	CREATE RECORD:C68([Personnes:12])
	[Personnes:12]NomLong:2:="Testeur"
	[Personnes:12]TypePersonne:5:="Testeur"
	[Personnes:12]Identificateur:4:="FuQPRPqSYE"
	SAVE RECORD:C53([Personnes:12])
End if 

  // initialisation de la fonction  "Entreprise" qui donne les droit de base
QUERY:C277([XFonctions:3];[XFonctions:3]NomFonction:2="Entreprise")

If (Records in selection:C76([XFonctions:3])=0)
	
	CREATE RECORD:C68([XFonctions:3])
	[XFonctions:3]NomFonction:2:="Entreprise"
	SAVE RECORD:C53([XFonctions:3])
	
	  // recherches des différentes tables sensibles
	ARRAY LONGINT:C221($TbNumTable;0)
	ARRAY BOOLEAN:C223($TbSensible;0)
	
	QUERY:C277([XData:1];[XData:1]XType:3="Tables sensibles")
	C_OBJECT:C1216($Ob)
	$ob:=[XData:1]XObjet:18
	OB GET ARRAY:C1229($Ob;"Sensible";$TbSensible)
	OB GET ARRAY:C1229($Ob;"NumTable";$TbNumTable)
	
	  // création des enregistrements de [XProfils]
	$FT:=Size of array:C274($TbNumTable)
	
	For ($Salé;1;$FT)  // pour chaque table potentiellement sensible
		
		If ($TbSensible{$Salé})
			
			CREATE RECORD:C68([XProfils:4])
			[XProfils:4]Voir:4:=True:C214
			[XProfils:4]UUIDFonction:2:="Entreprise"
			[XProfils:4]NumTableSensible:3:=$TbNumTable{$Salé}
			SAVE RECORD:C53([XProfils:4])
			
		End if 
	End for 
End if 

If (<>ZToutNeuf)  // refus d'utiliser des codes d'accès
	
	ZAjout:=True:C214
	ZSupprime:=True:C214
	ZImprime:=True:C214
	ZAccès:=True:C214
	ZModif:=True:C214
	ZValide:=True:C214
	CHANGE CURRENT USER:C289(1;"")
	
Else 
	ZLoginAfficheCode 
End if 
ZInitTableauxStructure 
ZInitVariables 
ZConfiguration_Demarrage 

  // Car Configuration_Demarrage est exécutée sur le serveur à cause du chemin Cloud
  // Ajouter les autres variables Inter Process si nécessaire
GET PROCESS VARIABLE:C371(-100;<>ZPermDuréeInactif;<>ZPermDuréeInactif)
GET PROCESS VARIABLE:C371(-100;<>ZNews;<>ZNews)
GET PROCESS VARIABLE:C371(-100;<>ZNewsActifs;<>ZNewsActifs)


  //Si (Non(<>ZClient))
  //<>ZNPA:=Nouveau process("ZNewsActualise";64000;"Affiche_News";*)
  //Fin de si 

ZXCarLaProc:=""
ON EVENT CALL:C190("ZBaseEvenement")
SET ABOUT:C316("A propos du programme "+<>ZNomProgramme;"ZApropos")

  //Si (<>ZNews)
  //ZNewsAffichePalette 
  //Fin de si 

ZCarousselDeMaugey 