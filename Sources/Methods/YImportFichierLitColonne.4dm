//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/06/18, 10:19:02
  // ----------------------------------------------------
  // Méthode : YImportFichierLitColonne
  // Description
  // Méthode qui lit un fichier texte ouvert de réference connue ($Doc)
  //  place la valeur dans un tableau texte déjà initialisé
  // raccourcit la chaine de la ligne ($Ligne)
  // Paramètres $1= Pt sur le tableau texte
  //                  $2 = Valeur du compteur
  // ----------------------------------------------------
$Pt:=$1
$Salé:=$2

$Pos:=Position:C15(<>ZTab;Ligne)
$Pt->{$Salé}:=Replace string:C233(Substring:C12(Ligne;1;($Pos-1));Char:C90(10);"")
Ligne:=Substring:C12(Ligne;($Pos+1))