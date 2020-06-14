//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Claude
  // Date et heure : 13/06/13, 10:26:14
  // ----------------------------------------------------
  // Méthode : ImportExtraitColonne
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

$Pos:=Position:C15(<>ZTab;Ligne)
$0:=Substring:C12(Ligne;1;($Pos-1))
Ligne:=Substring:C12(Ligne;($Pos+1))