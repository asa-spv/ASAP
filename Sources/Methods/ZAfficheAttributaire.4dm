//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 08/05/18, 17:00:59
  // ----------------------------------------------------
  // Pas de paramètre
  // ---------------------------------------------------- 
  // Méthode : ZAfficheAttributaire
  // Description
  // renvoie la liste des attributaires d'une fonction
  //

RELATE MANY:C262([XFonctions:3]UUID:1)
RELATE ONE SELECTION:C349([XAttributions:5];[XUtilisateurs:2])
SELECTION TO ARRAY:C260([XUtilisateurs:2]Initiales:4;$TbInitialesUtilisateur)
$0:=ZTableauVersTexte (->$TbInitialesUtilisateur;", ")