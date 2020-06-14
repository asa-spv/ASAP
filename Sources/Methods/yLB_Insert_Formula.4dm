//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 29/12/16, 18:00:22
  // ----------------------------------------------------
  // Méthode : LB_Insert_Formula
  // Description
  // 
  // Paramètres
  // ----------------------------------------------------
  //
  // $1 : Nom LB
  // $2 : Nom formule
  // $3 : Formule
  // $4 : type du format retour de la formule (is text, is real, ...)
  // {$5} : Titre de la colonne
  // {$6} : Taille de la colonne
  // {$7} : Saisissable ou non. Faux par défaut
  // {$8} : Alignement
  // {$9} : Format d'affichage


  // exemple
  //$formula:="[Adherents]Nom +choose:C955 ([Adherents]NomMere#\"\";\" / \"+ [Adherents]NomMere;\"\")"
  //$formula:=$formula+"+ char:C90(13) +[Adherents]PrenomPere+choose:C955 ([Adherents]PrenomMere#\"\";\" / \"+ [Adherents]PrenomMere;\"\")"
  //LB_Insert_Formula ($NomLB;"Formule2";$formula;Is text;"Famille";200;False)

C_TEXT:C284($1;$2;$NomLB;$VarName)
C_TEXT:C284($3;$formula)
C_LONGINT:C283($4;$Nature)
C_TEXT:C284($5;$Titre)
C_LONGINT:C283($6;$Size;$Col)
C_BOOLEAN:C305($7;$Enterable)
C_LONGINT:C283($8;$Alignment;$header)
C_TEXT:C284($9;$Format)

ASSERT:C1129(Count parameters:C259>=4;"Au moins 4 paramètres sont attendus dans "+Method called on event:C705)

$NomLB:=$1
$VarName:=$2
$formula:=$3
$Nature:=$4
$HVarname:="H"+$VarName
$col:=LISTBOX Get number of columns:C831(*;$NomLB)+1

LISTBOX INSERT COLUMN FORMULA:C970(*;$NomLB;$col;$VarName;$formula;Est un texte:K8:3;$HVarname;$header)
OBJECT SET ENTERABLE:C238(*;$VarName;False:C215)

If (Count parameters:C259>4)
	$Titre:=$5
	OBJECT SET TITLE:C194(*;$HVarname;$Titre)
End if 

If (Count parameters:C259>5)
	$Size:=$6
	If ($Size#0)
		LISTBOX SET COLUMN WIDTH:C833(*;$VarName;$Size)
	End if 
End if 

If (Count parameters:C259>6)
	$Enterable:=$7
	OBJECT SET ENTERABLE:C238(*;$VarName;$Enterable)
End if 

If (Count parameters:C259>7)
	$Alignment:=$8
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$VarName;$Alignment)
End if 

If (Count parameters:C259>8)
	$Format:=$9
	OBJECT SET FORMAT:C236(*;$VarName;$Format)
End if 