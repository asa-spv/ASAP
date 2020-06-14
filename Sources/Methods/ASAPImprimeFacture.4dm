//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/02/19, 09:59:58
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPImprimeFacture
  // Description
  // Imprime la facture courante

FORM SET OUTPUT:C54([Factures:15];"Facture")
PRINT RECORD:C71([Factures:15])
