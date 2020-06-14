//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 12:23:54
  // ----------------------------------------------------
  // Paramètres
  // $1 = Nom de l'objet
  // $2 = Texte à ajouter dans l'objet. Si numérique, appeler ZObjet_Set_Num
  // {$3} = Fixer Titre, sinon Fixer texte
  // ----------------------------------------------------
  // Méthode : ZObjet_Set_Info
  // Description
  //  

C_TEXT:C284($1;$2;$Object;$LeTexte)

$Object:=$1
$LeTexte:=$2

If (Count parameters:C259=3)
	$Titre:=$3
	OBJECT SET TITLE:C194(*;$Object;$LeTexte)
	
Else 
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;$Object))->:=$LeTexte
	
End if 