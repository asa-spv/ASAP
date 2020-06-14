//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 12:23:54
  // ----------------------------------------------------
  // Paramètres
  // $1 = Nom de l'objet
  // $0 = Texte à récupérer dans l'objet
  // ----------------------------------------------------
  // Méthode : ZObjet_Get_Info
  // Description
  //  

C_TEXT:C284($1;$0;$Object)

$Object:=$1
$0:=(OBJECT Get pointer:C1124(Objet nommé:K67:5;$Object))->