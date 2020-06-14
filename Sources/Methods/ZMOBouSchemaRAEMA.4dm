//%attributes = {}

  // $F:=Créer fenêtre formulaire("DlgSaisieRAEMA")
  //$MargeHaut:=Hauteur barre de menus+Hauteur barre outils+30  // Pour décaler le titre de la fenêtre
  //CHANGER COORDONNÉES FENÊTRE(10;$MargeHaut;1600;850+$MargeHaut)
  //$AncTitre:=Titre fenêtre
ZFenetreOuvertureStandard 
SET WINDOW TITLE:C213("Schéma des campagnes du RAEMA")
DIALOG:C40("DlgSaisieRAEMA")
CLOSE WINDOW:C154
  // CHANGER TITRE FENÊTRE($AncTitre)

  // FERMER FENÊTRE