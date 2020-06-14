//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 05/05/18, 17:22:41
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZTacheDeFondLocal
  // Description
  // Méthode de traitement des [XTachesDeFond]
Repeat 
	ZTacheDeFondAccomplir ("local")
	ZTacheDeFondAccomplir (Current machine:C483)
	DELAY PROCESS:C323(Current process:C322;60*10)
Until (False:C215)

