//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/01/19, 11:09:37
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbNomGermeRAEMAGelMAJ
  // Description
  //  Méthode qui met à jour sur les postes clients la correspondance entre le nom des germes 
  //  du schéma ([RAEMAGermes]NomFr), de la campagne ([CampagneGelGermes]NomDuGerme), du petit nom sur le Web
  //   et des tableaux de participation, Nb de pots avec ou sans Rapport COFRAC

C_LONGINT:C283($TT)

ASAPInitTbNomGermeGel 
$TT:=Size of array:C274(<>TbPtTbNomGermeGel)
For ($Salé;1;$TT)
	GET PROCESS VARIABLE:C371(-1951;<>TbPtTbNomGermeGel{$Salé}->;<>TbPtTbNomGermeGel{$Salé}->)
End for 