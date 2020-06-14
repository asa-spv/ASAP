//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 20/07/14, 15:26:10
  // ----------------------------------------------------
  // Méthode : BASE_IMG_SurDebutGlisser
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

READ PICTURE FILE:C678(Get 4D folder:C485(Dossier Resources courant:K5:16)+"img"+Séparateur dossier:K24:12+"download_48x48.png";$vpict)
CREATE THUMBNAIL:C679($vpict;$vpict;48;48)
SET DRAG ICON:C1272($vPict)