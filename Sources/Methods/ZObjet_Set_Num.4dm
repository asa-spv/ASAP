//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 12:23:54
  // ----------------------------------------------------
  // Paramètres
  // $1 = Nom de l'objet
  // $2 = Valeur numérique. Si texte, appeler ZObjet_Set_Info
  // ----------------------------------------------------
  // Méthode : ZObjet_Set_Num
  // Description
  //  

C_TEXT:C284($1;$Object)
C_LONGINT:C283($2;$Valeur)

$Object:=$1
$Valeur:=$2

(OBJECT Get pointer:C1124(Objet nommé:K67:5;$Object))->:=$Valeur
