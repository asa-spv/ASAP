//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 23/04/18, 05:31:05
  // ----------------------------------------------------
  // Méthode : ZBoumUtilisateur
  // Description
  //  Méthode projet de destruction des enregistrements 
  // liés à un utilisateur ([XAttributions], [XDroits],  [XLocalisations])
  // ----------------------------------------------------

READ WRITE:C146([XAttributions:5])
READ WRITE:C146([XDroits:7])
READ WRITE:C146([XLocalisations:8])
RELATE MANY:C262([XUtilisateurs:2]UUID:1)
DELETE SELECTION:C66([XAttributions:5])
DELETE SELECTION:C66([XDroits:7])
DELETE SELECTION:C66([XLocalisations:8])
ZAmnistiePartielle (->[XAttributions:5])
ZAmnistiePartielle (->[XDroits:7])
ZAmnistiePartielle (->[XLocalisations:8])
