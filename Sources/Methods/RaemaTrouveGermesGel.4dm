//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 13/08/19, 06:29:48
  // ----------------------------------------------------
  // Méthode : RaemaTrouveGermesGel
  // Description
  // Méthode qui permet de trouver dans [WebConnexions]Arguments
  //  le nom des germes proposés dans les campagnes Gel
  // ----------------------------------------------------
QUERY BY ATTRIBUTE:C1331([WebConnexions:13];[WebConnexions:13]Arguments:15;"TbNomsP2[]";"=";"rgcb6")
DISTINCT VALUES:C339([WebConnexions:13]Campagne:5;$TbCamp)
  // CHERCHER DANS SÉLECTION([WebConnexions];[WebConnexions]Campagne="@a")