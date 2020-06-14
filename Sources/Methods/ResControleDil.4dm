//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 20/02/18, 08:33:30
  // ----------------------------------------------------
  // Méthode : ResControleDil
  // Description
  // Méthode gérée par AJAX qui permet de savoir  
  //  si la dilution est une valeur possible
  // Paramètre $1=message AJAX
  // ----------------------------------------------------

$Valeur:=Substring:C12($1;19)

$L:=Find in array:C230(<>TbDilution;$Valeur)
If ($L=-1)
	WEB SEND TEXT:C677("0")
Else 
	WEB SEND TEXT:C677($Valeur)
End if 