//%attributes = {}
C_TEXT:C284($ntext_t)
C_LONGINT:C283($col_i;$row_i;$index;$index_col)
C_POINTER:C301($PtChamps)

ARRAY TEXT:C222($tabNomsEntêtes;0)
ARRAY TEXT:C222($tabNomsCols;0)
ARRAY POINTER:C280($tabVarCols;0)
ARRAY POINTER:C280($tabVarEntêtes;0)
ARRAY BOOLEAN:C223($tabColsVisibles;0)
ARRAY POINTER:C280($tabStyles;0)

MESSAGES OFF:C175
CREATE SET:C116(ZptTable->;"Tempo")
USE SET:C118("ZFichesSurlignees")  // Réduction aux seules fiches sélectionnées

$col_i:=LISTBOX Get number of columns:C831(*;"Lb_Balance")
$row_i:=LISTBOX Get number of rows:C915(*;"Lb_Balance")
$ntext_t:=""

LISTBOX GET ARRAYS:C832(*;"Lb_Balance";$tabNomsCols;$tabNomsEntêtes;$tabVarCols;\
$tabVarEntêtes;$tabColsVisibles;$tabStyles)

FIRST RECORD:C50(ZptTable->)

For ($index;1;$row_i)  // Par ligne
	
	For ($index_col;1;$col_i)  // POur chaque colonne
		
		$PtChamps:=$tabVarCols{$index_col}
		$ntext_t:=$ntext_t+String:C10($PtChamps->)+Choose:C955($index_col<$col_i;Char:C90(Tabulation:K15:37);"")
		
	End for 
	
	$ntext_t:=$ntext_t+Char:C90(Retour chariot:K15:38)
	NEXT RECORD:C51(ZptTable->)
	
End for 
  //FIXER TEXTE DANS CONTENEUR($ntext_t)

USE SET:C118("Tempo")
CLEAR SET:C117("Tempo")


MESSAGES ON:C181