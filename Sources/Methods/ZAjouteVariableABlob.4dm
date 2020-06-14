//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/02/18, 18:41:00
  // ----------------------------------------------------
  // Méthode : ZAjouteVariableABlob
  // Description
  // Méthode projet AJOUT de VARIABLES à la fin du DANS BLOB
  // STOCKER VARIABLES DANS BLOB ( Pointeur { ; Pointeur ... { ;  Pointeur } } )
  // STOCKER VARIABLES DANS BLOB ( BLOB { ; Var1 ... { ; Var2 } } )
  // ----------------------------------------------------

C_POINTER:C301(${1})
C_LONGINT:C283($vlParam)

For ($vlParam;2;Count parameters:C259)
	VARIABLE TO BLOB:C532(${$vlParam}->;$1->;*)
End for 