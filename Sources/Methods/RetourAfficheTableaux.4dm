//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 15/03/17, 14:26:11
  // ----------------------------------------------------
  // Méthode : RetourAfficheTableaux
  // Description
  // Affiche les tableaux de la revue de direction
  //
  // Paramètres : $1=type de Raema  $2 = ligne du PUMDomaine
  // ----------------------------------------------------
$type:=$1
$A:=Num:C11($type="Gel")*"A"
$ligne:=$2
$RaemaEnCours:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33))
VarNumRaema1:=String:C10(Num:C11($RaemaEnCours)-1)+$A
VarNumRaema2:=String:C10(Num:C11($RaemaEnCours)-2)+$A
VarNumRaema3:=String:C10(Num:C11($RaemaEnCours)-3)+$A
VarNumRaema4:=String:C10(Num:C11($RaemaEnCours)-4)+$A
VarTbRevDir1:="RAEMA "+VarNumRaema1+<>ZCR+"Dernière campagne n"
VarTbRevDir2:="RAEMA "+VarNumRaema2+<>ZCR+"Campagne (n-1)"
VarTbRevDir3:="RAEMA "+VarNumRaema3+<>ZCR+"Campagne (n-2)"
VarTbRevDir4:="RAEMA "+VarNumRaema4+<>ZCR+"Campagne (n-3)"
If ($ligne=1)
	RetourCalculTableauRevDir 
Else 
	RetourCalculTableauRevDir ($ligne)
End if 