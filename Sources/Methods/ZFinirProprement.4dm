//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/01/18, 10:25:26
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZFinirEnBeauté
  // Description
  //  Permet de quitter proprement l'application
  // ----------------------------------------------------

<>ZFinirEnBeauté:=True:C214
POST OUTSIDE CALL:C329(-1)  // Anciennement APPELER PROCESS
DELAY PROCESS:C323(Current process:C322;30)  // Pour permettre aux autres process de quitter
QUIT 4D:C291  //il fallait bien le faire une jour