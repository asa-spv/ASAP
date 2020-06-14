//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 19/06/18, 17:54:50
  // ----------------------------------------------------
  // Méthode : YRemplitObjet
  // Description
  // Méthode qui remplit l'objet dont le pointeur est en paramètre 
  //  avec la propriété en $2 et la valeur en $3 selon la nature 
  // ----------------------------------------------------
C_POINTER:C301($PtObjet;$1)
C_LONGINT:C283($4)
$PtObjet:=$1
$Propriété:=$2
$Valeur:=$3
$OnFixe:=(($Valeur#"") & ($Valeur#"0") & ($Valeur#"FAUX"))
If ($OnFixe)
	OB SET:C1220($PtObjet->;$Propriété;$Valeur)
Else 
	$Arg:=OB Get:C1224($PtObjet->;$Propriété;Est un texte:K8:3)
	If ($Arg#"")
		OB REMOVE:C1226($PtObjet->;$Propriété)
	End if 
End if 
