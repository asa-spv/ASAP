//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 10/05/12
  // ----------------------------------------------------
  // Méthode : ZBlobVersVariableOffset
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

  // Méthode projet RECUPERER VARIABLES POINTEURS DANS BLOB à partir d'un Offset Donné
  // RECUPERER VARIABLES DANS BLOB ( Pointeur { ; Pointeur ... { ;  Pointeur } } )
  // RECUPERER VARIABLES DANS BLOB ( BLOB { ; Var1 ... { ; Var2 } } )

C_POINTER:C301(${2})
C_LONGINT:C283($1;$vlParam;$Offset;$0)

$Offset:=$1

For ($vlParam;3;Count parameters:C259)
	BLOB TO VARIABLE:C533($2->;${$vlParam}->;$Offset)
End for 
$0:=$Offset