//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 12:51:13
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZLBSupprimeColonne
  // Description
  //  

ARRAY TEXT:C222($tabNomsEntêtes;0)
ARRAY TEXT:C222($tabNomsCols;0)
ARRAY POINTER:C280($tabVarCols;0)
ARRAY POINTER:C280($tabVarEntêtes;0)
ARRAY BOOLEAN:C223($tabColsVisibles;0)
ARRAY POINTER:C280($tabStyles;0)
C_LONGINT:C283($NumC;$NumT)
C_TEXT:C284($var)

$vtItems:="Table : "+ZNomTable+";-;"

LISTBOX GET ARRAYS:C832(*;ZNomListe;$tabNomsCols;$tabNomsEntêtes;$tabVarCols;$tabVarEntêtes;$tabColsVisibles;$tabStyles)
$col_i:=LISTBOX Get number of columns:C831(*;ZNomListe)-Num:C11(GestionTableau)

  // Retirons les champs déjà affichés
For ($z;1;$col_i)
	  // Création du PopUp dynamique des champs
	If (GestionTableau)
		RESOLVE POINTER:C394($tabVarCols{$z};$var;$NumT;$NumC)
		$pos:=Position:C15("_";$var)
		$Table:=Num:C11(Substring:C12($var;1;$pos-1))
		$Champ:=Num:C11(Substring:C12($var;$pos+1))
		$vtItems:=$vtItems+Field name:C257($table;$Champ)+Choose:C955($z<$col_i;";";"")
	Else 
		$PtChamps:=$tabVarCols{$z}
		$vtItems:=$vtItems+Field name:C257($PtChamps)+Choose:C955($z<$col_i;";";"")
	End if 
End for 

GET MOUSE:C468($vlMouseX;$vlMouseY;$vlBouton)
$vlChoixUtilisateur:=Pop up menu:C542($vtItems)

If (($vlChoixUtilisateur>0) & ($vlChoixUtilisateur>2))  // Il faut au moins avoir cliqué dans le PopUp Menu
	$vlChoixUtilisateur:=$vlChoixUtilisateur-2  // A cause des 2 lignes ajoutées initialement
	
	LISTBOX DELETE COLUMN:C830(*;ZNomListe;$vlChoixUtilisateur)
	
	  // ZLBColonnesSauvePE (ZNomListe)
	
End if 