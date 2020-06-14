//%attributes = {}
  // ----------------------------------------------------
  // nom utilisateur (OS) : iMacASA2017
  // date et heure : 24/01/18, 08:37:24
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // méthode : ZAmnistieInternationale
  // description
  // méthode qui met toutes les tables en lecture écriture
  // .   et en vide la sélection courante
  // ----------------------------------------------------

C_LONGINT:C283($FT;$Salé)
C_POINTER:C301($PtT)

$FT:=Get last table number:C254

For ($Salé;1;$FT)
	
	If (Is table number valid:C999($Salé))
		
		$PtT:=Table:C252($Salé)
		UNLOAD RECORD:C212($PtT->)  // libère l'enregistrement courant
		REDUCE SELECTION:C351($PtT->;0)  // vide la sélection courante
		
	End if 
End for 

READ ONLY:C145(*)  // met toutes les tables en Lecture seulement
