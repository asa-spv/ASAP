//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/01/18, 10:22:18
  // ----------------------------------------------------
  // Paramètres
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZFenetreOuvertureStandard
  // Description
  //  Ouvre la fenêtre adéquate de toutes les situations
  //

C_LONGINT:C283($MargeHaut;$F)

$MargeHaut:=Menu bar height:C440+Tool bar height:C1016+30  // Pour décaler le titre de la fenêtre
$F:=Open window:C153(10;$MargeHaut;1600;850+$MargeHaut;Fenêtre standard de taille fixe:K34:6)  // Taille minimale des écrans