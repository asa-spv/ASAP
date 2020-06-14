//%attributes = {"publishedWeb":true}
  //  ZAdieuEnr V11 du 10/08/2010
  // ----------------------------------------------------
  // Paramètre
  // Pas de paramètre
  // ----------------------------------------------------
  //  détruit une fiche si elle n'est pas protégée
  //  appelée par ZAdieuSélection
  //  appelle ZDétruitPas si la fiche n'est pas destructible
  //  du fait des liens avec contrôle d'intégrité
  //  utilise ZAttendVerrou

ON ERR CALL:C155("ZDétruitPas")
ZVerrouAttendre (ZPtTable)
DELETE RECORD:C58(ZPtTable->)
ON ERR CALL:C155("")