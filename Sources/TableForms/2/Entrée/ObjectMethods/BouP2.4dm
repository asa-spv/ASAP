
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/07/18, 07:34:51
  // ----------------------------------------------------
  // Méthode : [XUtilisateurs].Entrée.BouP2
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

If ([XUtilisateurs:2]UUID:1#<>ZQuiCodeUUID) & (Not:C34(<>ZToutNeuf))
	ALERT:C41("Désolé "+<>ZQuiVaLa+",  l'accès à cet écran est réservé à "+[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]Nom:2+" en personne...")
Else 
	FORM GOTO PAGE:C247(2)
End if 