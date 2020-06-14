//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/01/18, 08:16:46
  // ----------------------------------------------------
  // Méthode : ZVariableVersBlob
  // Description
  //  Méthode qui stocke autant de variables que nécessaire 
  //   dans le Blob passé en premier paramètre.
  //   La méthode ZBlobVersVariable déblobe les variables (opération inverse)
  // Paramètres : $1 = Pt sur le blob, $2= pointeur sur la variable à blober, 
  // {$3},{$4},... {$n}, pointeur sur les variables à blober
  // ----------------------------------------------------
C_POINTER:C301(${1})
C_LONGINT:C283($Salé)
SET BLOB SIZE:C606($1->;0)
For ($Salé;2;Count parameters:C259)
	VARIABLE TO BLOB:C532(${$Salé}->;$1->;*)
End for 