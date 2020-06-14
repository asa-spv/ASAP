//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 03/05/18, 11:43:18
  // ----------------------------------------------------
  // Méthode : ZSplash
  // Description
  // ZSplashScreen V11 du 15/08/2010
  // Méthode : ZSplashScreen
  // Description
  // Affichage d'un SplashScreen au démarrage de l'application
  // Permet de faire attendre pendant le chargement de la machine 
  //
  // Paramètres
  // ----------------------------------------------------


C_LONGINT:C283($_WSplashScreen)
$_WSplashScreen:=Open form window:C675("About";Form fenêtre standard:K39:10;Centrée horizontalement:K39:1;Centrée verticalement:K39:4)
DIALOG:C40("About";*)