//%attributes = {"publishedWeb":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 10/05/12
  // ----------------------------------------------------
  // Méthode : YStockeVariableBlobPasVide
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
  // Méthode projet AJOUT de VARIABLES à la fin du DANS BLOB
  // STOCKER VARIABLES DANS BLOB ( Pointeur { ; Pointeur ... { ;  Pointeur } } )
  // STOCKER VARIABLES DANS BLOB ( BLOB { ; Var1 ... { ; Var2 } } )

C_POINTER:C301(${1})
C_LONGINT:C283($vlParam)

For ($vlParam;2;Count parameters:C259)
	VARIABLE TO BLOB:C532(${$vlParam}->;$1->;*)
End for 