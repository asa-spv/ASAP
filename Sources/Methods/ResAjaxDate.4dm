//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/09/16, 12:53:44
  // ----------------------------------------------------
  // Méthode : ResAjaxDate
  // Description
  // Renvoie par Ajax la date de début de la campagne
  //
  // ----------------------------------------------------

QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursSaisie)
WEB SEND TEXT:C677(String:C10([RAEMACampagnes:20]DateEnvoiColis:3))

