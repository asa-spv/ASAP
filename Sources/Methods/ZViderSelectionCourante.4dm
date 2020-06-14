//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/01/18, 08:39:14
  // ----------------------------------------------------
  // Méthode : ZViderSelectionCourante
  // Description
  //  Méthode qui vide la sélection courante de la table passée en paramètre
  //
  // Paramètre $1= Pt sur la table à vider
  // ----------------------------------------------------
$Pt:=$1

REDUCE SELECTION:C351($Pt->;0)