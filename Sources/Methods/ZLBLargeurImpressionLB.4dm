//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/03/18, 16:04:12
  // ----------------------------------------------------
  // Méthode : ZLBLargeurImpressionLB
  // Description
  // Méthode projet qui renvoie la largeur de la LB
  // Paramètre : $1 = nom de la ListBox à imprimer
  // ----------------------------------------------------

C_TEXT:C284($1;$vLBNom)
$vLBNom:=$1

C_LONGINT:C283($Salé;$FT;$LargeurColonneImpression;$VarLargeurOptimaleDerCol;$HautOpt)

ARRAY TEXT:C222($tColNom;0)
ARRAY TEXT:C222($tEntNom;0)
ARRAY POINTER:C280($tColVar;0)
ARRAY POINTER:C280($tEntVar;0)
ARRAY BOOLEAN:C223($tColVisible;0)
ARRAY POINTER:C280($tColStyle;0)
ARRAY TEXT:C222($tPPNom;0)
ARRAY POINTER:C280($tPPtVar;0)
LISTBOX GET ARRAYS:C832(*;$vLBNom;$tColNom;$tEntNom;$tColVar;$tEntVar;$tColVisible;$tColStyle;$tPPNom;$tPPtVar)
$LargeurColonneImpression:=0
$FT:=Size of array:C274($tColVar)
For ($Salé;1;$FT)
	If (OBJECT Get visible:C1075(*;$tColNom{$Salé})=True:C214)
		If ($Salé<$FT)
			$LargeurColonneImpression:=$LargeurColonneImpression+LISTBOX Get column width:C834(*;$tColNom{$Salé})
		Else 
			OBJECT GET BEST SIZE:C717($tColVar{$Salé}->;$VarLargeurOptimaleDerCol;$HautOpt)
			$LargeurColonneImpression:=$LargeurColonneImpression+$VarLargeurOptimaleDerCol
		End if 
	End if 
End for 
$0:=$LargeurColonneImpression

