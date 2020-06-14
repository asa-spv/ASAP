//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/07/19, 18:40:28
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbPersonnesMAJ
  // Description
  // Méthode qui fmet à jour 
  // les tableaux généraux des persoones 
  //  sur les clients
  // ----------------------------------------------------
C_LONGINT:C283($TT)
ASAPInitTbPersonnes 
$TT:=Size of array:C274(<>TbPtPersonnes)
For ($Salé;1;$TT)
	GET PROCESS VARIABLE:C371(-1951;<>TbPtPersonnes{$Salé}->;<>TbPtPersonnes{$Salé}->)
End for 