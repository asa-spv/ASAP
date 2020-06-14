//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 07/05/18, 17:00:09
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZLBGestionPUMChoixListe
  // Description
  // méthode de gestion du PUM qui permet 
  //  de choisir la composition de la liste en fonction des listes enregistrées

C_LONGINT:C283($NbC)

QUERY:C277([XData:1];[XData:1]UUID:1=TbUUIDFormatPossible{TbPUMFormatPossible})
$NbC:=LISTBOX Get number of columns:C831(*;ZNomListe)
LISTBOX DELETE COLUMN:C830(*;ZNomListe;1;$NbC)
ZLBColonnesCharge 
