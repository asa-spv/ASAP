//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/01/18, 08:21:14
  // ----------------------------------------------------
  // Méthode : ZBlobVersVariable
  // Description
  // Méthode qui déstocke autant de variables que nécessaire
  //   dans le Blob passé en premier paramètre.
  //   La méthode ZVariableVersBlob blobe les variables (opération initiale)
  // Paramètres : $1 = Pt sur le blob, $2= pointeur sur la variable à blober, 
  // {$3},{$4},... {$n}, pointeur sur les variables à blober
  // ----------------------------------------------------

C_POINTER:C301(${1})
C_LONGINT:C283($Salé)
$Offset:=0
For ($Salé;2;Count parameters:C259)
	BLOB TO VARIABLE:C533($1->;${$Salé}->;$Offset)
End for 
$0:=$Offset