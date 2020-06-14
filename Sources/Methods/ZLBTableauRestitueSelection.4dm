//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 23/04/18, 05:46:56
  // ----------------------------------------------------
  // Méthode : ZLBTableauRestitueSelection
  // Description
  //   Méthode qui remet dans les tableaux la sélection courante
  // ----------------------------------------------------

If (True:C214)
	EXECUTE METHOD:C1007(ZMethodeTableaux)
Else 
	C_LONGINT:C283($Salé;$FT)
	ARRAY TEXT:C222($tabNomsEntêtes;0)
	ARRAY TEXT:C222($tabNomsCols;0)
	ARRAY POINTER:C280($tabVarCols;0)
	ARRAY POINTER:C280($tabVarEntêtes;0)
	ARRAY BOOLEAN:C223($tabColsVisibles;0)
	ARRAY POINTER:C280($tabStyles;0)
	
	$NomLB:="Lb_Tableaux"
	LISTBOX GET ARRAYS:C832(*;$NomLB;$tabNomsCols;$tabNomsEntêtes;$tabVarCols;$tabVarEntêtes;$tabColsVisibles;$tabStyles)
	$FT:=Size of array:C274($tabVarCols)-1
	For ($Salé;1;$FT)
		RESOLVE POINTER:C394($tabVarCols{$Salé};$NomVariable;$NumTableChamp;$NumChamp)
		$Chaine:=Substring:C12($NomVariable;3)  // élimination de "Tb"
		$Pos:=Position:C15("_";$Chaine)
		$NumTableChamp:=Num:C11(Substring:C12($Chaine;1;($pos-1)))
		$NumChamp:=Num:C11(Substring:C12($Chaine;($pos+1)))
		$PtChampCourant:=Field:C253($NumTableChamp;$NumChamp)
		SELECTION TO ARRAY:C260($PtChampCourant->;$tabVarCols{$Salé}->;*)
	End for 
	SELECTION TO ARRAY:C260
	LONGINT ARRAY FROM SELECTION:C647(ZPtTable->;TbNumEnr)
End if 