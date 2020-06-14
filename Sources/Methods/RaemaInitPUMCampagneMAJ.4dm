//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 22/08/19, 05:12:48
  // ----------------------------------------------------
  // Méthode : RaemaInitPUMCampagneMAJ
  // Description
  // Met à jour sur le client les paramètres
  //  de la campagne RAEMA actuelle
  // Paramètres
  // ----------------------------------------------------

ON ERR CALL:C155("aaaErreur")
C_LONGINT:C283($TT)
ON ERR CALL:C155("")

ASAPInitTbPUMCampagne 
$TT:=Size of array:C274(<>TbPtPUMCampagne)
For ($Salé;1;$TT)
	GET PROCESS VARIABLE:C371(-1951;<>TbPtPUMCampagne{$Salé}->;<>TbPtPUMCampagne{$Salé}->)
End for 

