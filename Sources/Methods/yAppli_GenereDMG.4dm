//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 29/01/2012 : Anniversaire de Christelle !
  // ----------------------------------------------------
  // Méthode : Appli_GenereDMG
  // Description
  //
  // http://c-command.com/dropdmg/
  //
  // ----------------------------------------------------
C_TEXT:C284($Chemin;$Command;$err;$IconeName;$In;$Nom;$out;$Rep;$RepDest)

$IconeName:=Get 4D folder:C485(Dossier base:K5:14)+"mainscreen.icns"

$Rep:=Get 4D folder:C485(Dossier base:K5:14)+<>SoftName+"_build"+<>ZSeparateur+"Final Application"+<>ZSeparateur
$Chemin:=$Rep+<>SoftName+".app"
$RepDest:=Get 4D folder:C485(Dossier base:K5:14)+<>SoftName+"_build"+<>ZSeparateur

If (Test path name:C476($RepDest)#Est un dossier:K24:2)
	CREATE FOLDER:C475($RepDest)
End if 

  // Conversion des Chemins en UNIX
$Chemin:=Convert path system to POSIX:C1106($Chemin)
$RepDest:=Convert path system to POSIX:C1106($RepDest)
$IconeName:=Convert path system to POSIX:C1106($IconeName)

  //Création du jeu d'instructions pour DropDMG
  // - y : Nom de la licence créée dans DropDMG
  // - l : Nom du Layout créé dans DropDMG
  // - o : destination de l'archive
  // - i : optimisé pour internet

  //  *******************************
  //  **** Les SimplyAsso correspondent à la Licence et au Layout créés préalablement dans DropDMG
  //  *******************************
$Command:="dropdmg -y SimplyAsso -l SimplyAsso -o "+$RepDest+" -i "+$Chemin
$In:=""
$out:=""
$err:=""

  // Suppression de l'ancien fichier
$Nom:=Get 4D folder:C485(Dossier base:K5:14)+<>SoftName+"_build"+<>ZSeparateur+<>SoftName+".DMG"
If (Test path name:C476($Nom)=Est un document:K24:1)
	DELETE DOCUMENT:C159($Nom)
End if 

If (OK=1)  // Pas d'erreur latente, on peut y aller
	  // Génération du fichier DMG !
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";$Rep)
	LAUNCH EXTERNAL PROCESS:C811($Command;$In;$Out;$Err)
	
	If ($err#"")  // Mauvais Plan
		ALERT:C41($err)
		  //FIXER TEXTE DANS CONTENEUR($err)
	Else 
		SHOW ON DISK:C922($Nom)
	End if 
End if 
