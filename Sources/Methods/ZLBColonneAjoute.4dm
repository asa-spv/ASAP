//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 12:45:30
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZLBColonneAjoute
  // Description
  //  

ARRAY TEXT:C222($ChmpsDispo;0)
ARRAY LONGINT:C221($ChmpsDispoID;0)
ARRAY TEXT:C222($tabNomsEntêtes;0)
ARRAY TEXT:C222($tabNomsCols;0)
ARRAY POINTER:C280($tabVarCols;0)
ARRAY POINTER:C280($tabVarEntêtes;0)
ARRAY BOOLEAN:C223($tabColsVisibles;0)
ARRAY POINTER:C280($tabStyles;0)

GET FIELD TITLES:C804(Table:C252(ZNumTable)->;$ChmpsDispo;$ChmpsDispoID)
$vtItems:="Table : "+Table name:C256(ZNumTable)+";-;"

LISTBOX GET ARRAYS:C832(*;ZNomListe;$tabNomsCols;$tabNomsEntêtes;$tabVarCols;$tabVarEntêtes;$tabColsVisibles;$tabStyles)
$col_i:=LISTBOX Get number of columns:C831(*;ZNomListe)-Num:C11(GestionTableau)

  // Retirons les champs déjà affichés
For ($z;1;$col_i)
	If (GestionTableau)
		RESOLVE POINTER:C394($tabVarCols{$z};$var;$NumT;$NumC)
		$pos:=Position:C15("_";$var)
		$Table:=Num:C11(Substring:C12($var;1;$pos-1))
		$Champ:=Field name:C257($Table;Num:C11(Substring:C12($var;$pos+1)))
	Else 
		$PtChamps:=$tabVarCols{$z}
		$Champ:=Field name:C257($PtChamps)
	End if 
	$x:=Find in array:C230($ChmpsDispo;$Champ)
	If ($x>0)
		DELETE FROM ARRAY:C228($ChmpsDispo;$x;1)
		DELETE FROM ARRAY:C228($ChmpsDispoID;$x;1)
	End if 
End for 

For ($a;1;Size of array:C274($ChmpsDispo))
	  // Création du PopUp dynamique des champs
	$vtItems:=$vtItems+$ChmpsDispo{$a}+Choose:C955($a<Size of array:C274($ChmpsDispo);";";"")
End for 

GET MOUSE:C468($vlMouseX;$vlMouseY;$vlBouton)
$vlChoixUtilisateur:=Pop up menu:C542($vtItems)

If (($vlChoixUtilisateur>0) & ($vlChoixUtilisateur>2))  // Il faut au moins avoir cliqué dans le PopUp Menu
	$vlChoixUtilisateur:=$vlChoixUtilisateur-2  // A cause des 2 lignes ajoutées initialement
	
	$Der:=LISTBOX Get number of columns:C831(*;ZNomListe)
	If (GestionTableau)
		$Nom:=Get pointer:C304("Tb"+String:C10(ZNumTable)+"_"+String:C10($ChmpsDispoID{$vlChoixUtilisateur}))
		LISTBOX INSERT COLUMN:C829(*;ZNomListe;$Der;$ChmpsDispo{$vlChoixUtilisateur};$Nom->;$ChmpsDispo{$vlChoixUtilisateur};$Nom->)
	Else 
		$Nom:=Get pointer:C304("tLB"+String:C10($Der+1))
		LISTBOX INSERT COLUMN:C829(*;ZNomListe;$Der+1;$ChmpsDispo{$vlChoixUtilisateur};Field:C253(Table:C252(ZptTable);$ChmpsDispoID{$vlChoixUtilisateur})->;$ChmpsDispo{$vlChoixUtilisateur};$Nom->)
	End if 
	
	$NC:=$ChmpsDispo{$vlChoixUtilisateur}
	$L:=Find in array:C230(<>TbNomChampBase;$NC)
	$NumChamp:=<>TbNumChampBase{$L}
	$NonChampPerso:=ZLBCracheTitreColonne (ZNumTable;$NumChamp)
	If ($NonChampPerso="")
		OBJECT SET TITLE:C194($Nom->;$ChmpsDispo{$vlChoixUtilisateur})
	Else 
		OBJECT SET TITLE:C194($Nom->;$NonChampPerso)
	End if 
	
End if 

