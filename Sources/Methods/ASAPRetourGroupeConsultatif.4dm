//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/01/19, 06:09:31
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPRetourGroupeConsultatif
  // Description
  // 
CUT NAMED SELECTION:C334([RetoursFiches:24];"$sel")
$F:=Open form window:C675("DlgTableauxConsultatif")
DIALOG:C40("DlgTableauxConsultatif")
CLOSE WINDOW:C154
USE NAMED SELECTION:C332("$sel")