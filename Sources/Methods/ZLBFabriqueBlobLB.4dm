//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/04/18, 09:16:40
  // ----------------------------------------------------
  // Méthode : ZLBFabriqueLeBlob
  // Description
  // Fabrique le blob qui décrit la LB
  //
  // Paramètre : $1=nom de la listbox
  // ----------------------------------------------------

$NomLB:=$1

ARRAY TEXT:C222($tabNomsEntêtes;0)
ARRAY TEXT:C222($tabNomsCols;0)
ARRAY POINTER:C280($tabVarCols;0)
ARRAY POINTER:C280($tabVarEntêtes;0)
ARRAY BOOLEAN:C223($tabColsVisibles;0)
ARRAY POINTER:C280($tabStyles;0)

C_BLOB:C604($BLobTemp)

LISTBOX GET ARRAYS:C832(*;$NomLB;$tabNomsCols;$tabNomsEntêtes;$tabVarCols;\
$tabVarEntêtes;$tabColsVisibles;$tabStyles)

ZAjouteVariableABlob (->$BLobTemp;->ZNumTable;->$tabNomsCols;->$tabNomsEntêtes;->$tabColsVisibles)

$a:=Size of array:C274($tabVarCols)
$b:=Size of array:C274($tabVarEntêtes)
$c:=Size of array:C274($tabStyles)

ZAjouteVariableABlob (->$BLobTemp;->$a)
ZAjouteVariableABlob (->$BLobTemp;->$b)
ZAjouteVariableABlob (->$BLobTemp;->$c)

For ($za;1;$a)
	$Nom:=Field name:C257($tabVarCols{$za})
	ZAjouteVariableABlob (->$BLobTemp;->$Nom)
End for 

For ($a;1;LISTBOX Get number of columns:C831(*;$NomLB))
	$L:=LISTBOX Get column width:C834($tabVarEntêtes{$a}->)
	ZAjouteVariableABlob (->$BLobTemp;->$L)
End for 
$0:=$BLobTemp