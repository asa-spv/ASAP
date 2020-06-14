//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Patrick EMANUEL
  // date et heure : 14/05/12, 13:58:27
  // ----------------------------------------------------
  // méthode : LB_SelectionneTout
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_TEXT:C284($ListBox;$1)
C_LONGINT:C283($index;$NbLignes)

If (Count parameters:C259=1)
	
	$ListBox:=$1
	$NbLignes:=LISTBOX Get number of rows:C915(*;$ListBox)
	
	For ($index;1;$NbLignes)
		LISTBOX SELECT ROW:C912(*;$ListBox;$index;lk ajouter à sélection:K53:2)
	End for 
	
Else 
	
	ALERT:C41(Get localized string:C991("Opération annulée")+" :"+Current method name:C684)
	
End if 
