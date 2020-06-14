//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/08/18, 15:23:29
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbUneCampagneMAJ
  // Description
  // 
ON ERR CALL:C155("aaaErreur")
C_LONGINT:C283($TT)
ASAPInitTbGenerauxUneCampagne 
ON ERR CALL:C155("")
$TT:=Size of array:C274(<>TbPtTbUneCampagne)
For ($Salé;1;$TT)
	GET PROCESS VARIABLE:C371(-1951;<>TbPtTbUneCampagne{$Salé}->;<>TbPtTbUneCampagne{$Salé}->)
End for 