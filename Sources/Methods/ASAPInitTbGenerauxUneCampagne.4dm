//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/08/19, 16:48:05
  // ----------------------------------------------------
  // Méthode : ASAPInitTbGenerauxUneCampagne
  // Description
  // Méthode qui initialise les tableaux généraux 
  //   de toutes les campagnes RAEMA ce qui permet d'éviter 
  //   les CHERCHER pour avoir les caractéristiques d'une campagne
  // ----------------------------------------------------


  // le pointeur sur les tableaux de la campagne
ARRAY POINTER:C280(<>TbPtTbUneCampagne;0)
  // La campagne
ARRAY TEXT:C222(<>TbNumCampagne;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNumCampagne)

  // le germe
ARRAY TEXT:C222(<>TbRefGerme;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbRefGerme)
ARRAY TEXT:C222(<>TbNomGermeF;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNomGermeF)
ARRAY TEXT:C222(<>TbNomGermeA;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNomGermeA)

  // la ligne
ARRAY TEXT:C222(<>TbRefLigne;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbRefLigne)
ARRAY TEXT:C222(<>TbNomLigneF;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNomLigneF)
ARRAY TEXT:C222(<>TbNomLigneA;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNomLigneA)
ARRAY TEXT:C222(<>TbEscamotable;0)  // "X" si escamotable
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbEscamotable)

  // la valeur
ARRAY TEXT:C222(<>TbRefValeur;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbRefValeur)
ARRAY TEXT:C222(<>TbNomValeurF;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNomValeurF)
ARRAY TEXT:C222(<>TbNomValeurA;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNomValeurA)
ARRAY TEXT:C222(<>TbEscamotage;0)  // "X" si provoque l'escamotage
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbEscamotage)

  // Les Tips
ARRAY TEXT:C222(<>TbTipsFr;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbTipsFr)
ARRAY TEXT:C222(<>TbTipsEn;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbTipsEn)

  // Le milieu
ARRAY TEXT:C222(<>TbMilieu;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbMilieu)

  // Le fabricant
ARRAY TEXT:C222(<>TbFabricant;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbFabricant)

  // le type de multiple : "" pour aucune valeur, "M" pour menu local et "C" pour cases à cocher
ARRAY TEXT:C222(<>TbMultiple;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbMultiple)

  // le nombre de valeurs multiple : "" pour aucune valeur, "M" pour menu local et "C" pour cases à cocher
ARRAY TEXT:C222(<>TbNbValeurs;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbNbValeurs)

  // le statut "Précision" : le champ de la colonne 3 n'apparait que si cette valeur a été choisie
ARRAY TEXT:C222(<>TbPrecision;0)
APPEND TO ARRAY:C911(<>TbPtTbUneCampagne;-><>TbPrecision)
