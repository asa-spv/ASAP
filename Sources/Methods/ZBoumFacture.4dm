//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 24/09/19, 17:07:57
  // ----------------------------------------------------
  // Méthode : ZBoumFacture
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
READ WRITE:C146([Ventes:16])
RELATE MANY:C262([Factures:15]NumFacture:3)
DELETE SELECTION:C66([Ventes:16])
READ ONLY:C145([Ventes:16])