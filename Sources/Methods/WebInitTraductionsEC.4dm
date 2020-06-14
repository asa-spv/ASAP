//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/10/19, 11:51:42
  // ----------------------------------------------------
  // Méthode : WebInitTraductionsEC
  // Description
  // Méthode qui rappelle les tableaux de traduction
  //  pour l'espace client
  // ----------------------------------------------------
QUERY:C277([XData:1];[XData:1]XType:3="TraductionEC";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Traduction de l'espace client")
ARRAY TEXT:C222(TbRef;0)
ARRAY TEXT:C222(TbFr;0)
ARRAY TEXT:C222(TbEn;0)
OB GET ARRAY:C1229([XData:1]XObjet:18;"Ref";TbRef)
OB GET ARRAY:C1229([XData:1]XObjet:18;"TbF";TbFr)
OB GET ARRAY:C1229([XData:1]XObjet:18;"TbA";TbEn)