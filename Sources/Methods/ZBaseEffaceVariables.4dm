//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick
  // Date et heure : 29/12/11
  // ----------------------------------------------------
  // Méthode : BASE_EraseVariables
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------


C_POINTER:C301(${1})
C_LONGINT:C283($i)

For ($i;1;Count parameters:C259)
	If (Is a variable:C294(${$i}))
		CLEAR VARIABLE:C89(${$i}->)
	End if 
End for 