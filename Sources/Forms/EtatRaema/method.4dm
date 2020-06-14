
C_LONGINT:C283($Fumé;1;$SFT;$Ordre;$larg;$haut;$larg_fix)

  //CHANGER TAILLE(VarEtatRaema;4)
OBJECT GET COORDINATES:C663(VarEtatRaema;$g;$h;$d;$b)
$larg_fix:=$d-$g  //Calcul de la taille de la variable
$haut_préc:=$b-$h
OBJECT GET BEST SIZE:C717(VarEtatRaema;$larg;$haut;$larg_fix)
  //Taille optimale du champ en fonction du contenu
$deplacement:=$haut-$haut_préc
If ($deplacement>0)
	$position:=Get print marker:C708(Corps formulaire:K43:1)
	$pos_finale:=$position+$deplacement
	  //On déplace le taquet Corps et ceux qui le suivent
	SET PRINT MARKER:C709(Corps formulaire:K43:1;$pos_finale;*)
	  //Redimensionnement des zones de texte
	OBJECT MOVE:C664(VarEtatRaema;$g;$h;$d;$haut+$h;*)
End if 