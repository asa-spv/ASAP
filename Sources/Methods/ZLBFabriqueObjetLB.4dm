//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/04/18, 09:16:40
  // ----------------------------------------------------
  // Pas de paramètre : 

  // ----------------------------------------------------
  // Méthode : ZLBFabriqueObjetLB
  // Description
  // Fabrique le blob qui décrit la LB
  //

C_OBJECT:C1216($MonObjet)

C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222($tabNomsEntêtes;0)
ARRAY TEXT:C222($tabNomsCols;0)
ARRAY POINTER:C280($tabVarCols;0)
ARRAY POINTER:C280($tabVarEntêtes;0)
ARRAY BOOLEAN:C223($tabColsVisibles;0)
ARRAY POINTER:C280($tabStyles;0)

LISTBOX GET ARRAYS:C832(*;ZNomListe;$tabNomsCols;$tabNomsEntêtes;$tabVarCols;\
$tabVarEntêtes;$tabColsVisibles;$tabStyles)

OB SET:C1220($MonObjet;"NumTable";2)
$FT:=Size of array:C274($tabVarCols)
OB SET:C1220($MonObjet;"NbColonne";$FT)
For ($Salé;1;$FT)
	$AttributCourant:="Colonne"+String:C10($Salé;"00")  // Attribut de ranf 1 formaté de façon à rendre le tri efficace
	$PtObjet:=Get pointer:C304("$ObCol"+String:C10($Salé))
	C_OBJECT:C1216($PtObjet->)
	$Titre:=OBJECT Get title:C1068($tabVarEntêtes{$Salé}->)
	$Taille:=LISTBOX Get column width:C834($tabVarEntêtes{$Salé}->)
	RESOLVE POINTER:C394($tabVarCols{$Salé};$NomVariable;$NumTableChamp;$NumChamp)
	If ($NomVariable#"TbNumEnr")  // on ne tient pas compte du tableau des numéros d'enregistrement
		If ($NomVariable#"")  // C'est un tableau on est GestionTableau
			  // Retrouvons le champ d'après le nom du tableau : "Tb"+chaine($NumTable)+"_"+chaine($NumChamp)
			$Chaine:=Substring:C12($NomVariable;3)  // élimination de "Tb"
			$Pos:=Position:C15("_";$Chaine)
			$NumTableChamp:=Num:C11(Substring:C12($Chaine;1;($pos-1)))
			$NumChamp:=Num:C11(Substring:C12($Chaine;($pos+1)))
		Else 
			$NumTableChamp:=Table:C252($tabVarCols{$Salé})
			$NumChamp:=Field:C253($tabVarCols{$Salé})
			RESOLVE POINTER:C394($tabVarCols{$Salé};$NomVariable;$NumTableChamp;$NumChamp)
		End if 
		RESOLVE POINTER:C394($tabVarEntêtes{$Salé};$NomVariableET;$NumTableNulle;$NumChampNul)
		OB SET:C1220($PtObjet->;"ColNom";$tabNomsCols{$Salé}\
			;"ColNumTable";$NumTableChamp\
			;"ColNumChamp";$NumChamp\
			;"ColNomVarET";$NomVariableET\
			;"ColTaille";$Taille\
			;"ColTitre";$Titre)
		OB SET:C1220($MonObjet;$AttributCourant;$PtObjet->)
	End if 
End for 

$0:=$MonObjet
