//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 15:48:55
  // ----------------------------------------------------
  // Paramètres
  // $1 = Nom de l'object
  // $0 = Valeur numérique (entier long)
  // ----------------------------------------------------
  // Méthode : ZObjet_Get_Num
  // Description
  //  

C_TEXT:C284($1;$Object)
C_LONGINT:C283($0)

$Object:=$1
$0:=(OBJECT Get pointer:C1124(Objet nommé:K67:5;$Object))->