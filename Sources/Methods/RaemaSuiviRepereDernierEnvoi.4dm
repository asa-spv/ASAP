//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/02/19, 08:15:00
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSuiviRepereDernierEnvoi
  // Description
  // Méthode qui rend courant l'enregistrement de [WebConnexions]
  // Qui correspond au dernier envoi à l'ASA


QUERY:C277([WebConnexions:13];[WebConnexions:13]Campagne:5=VarNumRaema;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)