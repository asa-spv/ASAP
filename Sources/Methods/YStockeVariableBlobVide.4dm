//%attributes = {"publishedWeb":true}
  //YStockeVariableBLOB

  // Méthode projet STOCKER VARIABLES DANS BLOB
  // STOCKER VARIABLES DANS BLOB ( Pointeur { ; Pointeur ... { ;  Pointeur } } )
  // STOCKER VARIABLES DANS BLOB ( BLOB { ; Var1 ... { ; Var2 } } )

C_POINTER:C301(${1})
C_LONGINT:C283($vlParam)

SET BLOB SIZE:C606($1->;0)
For ($vlParam;2;Count parameters:C259)
	VARIABLE TO BLOB:C532(${$vlParam}->;$1->;*)
End for 