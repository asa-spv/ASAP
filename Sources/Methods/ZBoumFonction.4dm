//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 08/05/18, 16:18:36
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZBoumFonction
  // Description
  // Conséquences de la suppression d'une fonction


READ WRITE:C146([XAttributions:5])
READ WRITE:C146([XAttributions:5])
READ WRITE:C146([XUtilisateurs:2])

  // Rappel des [XAttributions] et des [XProfils]
RELATE MANY:C262([XFonctions:3]UUID:1)

  // Suppression des [XAttributions] et des [XProfils]
DELETE SELECTION:C66([XAttributions:5])
DELETE SELECTION:C66([XProfils:4])

  // recalcul des droits
ALL RECORDS:C47([XUtilisateurs:2])
APPLY TO SELECTION:C70([XUtilisateurs:2];ZDroitsRecalcule (True:C214;True:C214))


ZAmnistiePartielle (->[XAttributions:5])
ZAmnistiePartielle (->[XAttributions:5])
ZAmnistiePartielle (->[XUtilisateurs:2])
