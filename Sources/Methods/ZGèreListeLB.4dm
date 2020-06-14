//%attributes = {}
  // ----------------------------------------------------
  // Méthode : ZGèreListeLB
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
  // Modifié par : Patrick EMANUEL (10/05/12)

  //  Procédure globale qui permet de piloter l'utilisateur
  //  $1 = Pt de le champ expressif    
  //  $2 = Chemin du logo illustrant la table
  //  $3 = nom du formulaire projet de saisie (Entrée)
  //  $4 = Format d'impression en page
  //  $5 = procédure à effectuer avant une destruction, "" sinon

C_POINTER:C301($1)
C_TEXT:C284($2;$3;$4;$5)  // noms des formats ou des procédures
C_LONGINT:C283(ZNumTable)

If (Count parameters:C259=5)
	ZPtChamp:=$1
	ZNumTable:=Table:C252(ZPtChamp)
	ZPtTable:=Table:C252(ZNumTable)
	ZNomChaDis:=Field name:C257(ZPtChamp)
	ZNomTable:=Table name:C256(ZPtTable)
	ZTypEns:=String:C10(Table:C252(ZPtTable))  // identifie par le numéro de fichier les ensembles crées
	VarCDLogo:=$2
	ZFormatSaisie:=$3
	ZFormatImp:=$4
	ZBoumProc:=$5  // Méthode à effectuer avant destruction
	
	
	ZMAJPrivilèges (ZPtTable)
	If (ZModif)
		READ WRITE:C146(ZPtTable->)
	Else 
		READ ONLY:C145(ZPtTable->)
	End if 
	
	  //Si (Enregistrements trouves(ZPtTable->)=0)  //autant ne pas afficher une liste vide
	ALL RECORDS:C47(ZPtTable->)
	  //Fin de si 
	ZNomEnsembleAvant:="Ceusses avant table "+ZNomTable
	CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)
	  //  crée l'ensemble des résultats de recherche
	ZAjoutEnr:=False:C215  //  initialise le booléen d'ajout
	ZFenetreOuvertureStandard 
	
	ZFenetreActualiseTitre 
	CREATE EMPTY SET:C140(ZPtTable->;"UserSet")
	CREATE EMPTY SET:C140(ZPtTable->;"LockedSet")
	
	FORM SET INPUT:C55(ZPtTable->;ZFormatSaisie;ZNomTable)
	
	DIALOG:C40("LBSelection")  // le format d'accueil doit être un formulaire projet
	CLOSE WINDOW:C154
	  // EFFACER SELECTION("LB_SelTemp")
	ZAmnistiePartielle (ZPtTable)
	ZFini:=False:C215
	
Else 
	
	ALERT:C41("Appel incorrecte de la méthode : "+Current method name:C684)
	
End if 