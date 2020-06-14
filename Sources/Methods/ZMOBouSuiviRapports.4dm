//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/08/18, 14:22:05
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouSuiviRapports
  // Description
  // // Amène à l'écran le dialogue de surveillance du téléchargement des rapports
  //$MargeHaut:=Hauteur barre de menus+Hauteur barre outils+30  // Pour décaler le titre de la fenêtre
  //CHANGER COORDONNÉES FENÊTRE(10;$MargeHaut;1600;850+$MargeHaut)
  //$AncTitre:=Titre fenêtre

ZFenetreOuvertureStandard 
SET WINDOW TITLE:C213("Suivi du téléchargement des rapports de campagnes")
DIALOG:C40("DlgSuiviRapport")
CLOSE WINDOW:C154

  //CHANGER TITRE FENÊTRE($AncTitre)