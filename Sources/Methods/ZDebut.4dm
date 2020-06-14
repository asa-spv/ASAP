//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 03/05/18, 08:09:32
  // ----------------------------------------------------
  // Méthode : ZDebut
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------


  // Affiche le dialogue About le temps de la configuration du système
CALL WORKER:C1389("SplashScreen";"ZSplash")

ZDeclareVarDiamant 
ZInfosEnviron 
ZInitTbDiamant 

  // ENDORMIR PROCESS(Numéro du process courant;2*60)
KILL WORKER:C1390("SplashScreen")

ZEcran 
ZAmnistieInternationale 