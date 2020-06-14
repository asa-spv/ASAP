//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/10/19, 11:56:44
  // ----------------------------------------------------
  // Méthode : WebTraduitTexte
  // Description
  // Méthode qui affiche dans le Web, la valeur traduite
  // Paramètre : $1=valeur de référence  $2=Langue
  // ----------------------------------------------------

$Resultat:=""
$L:=Find in array:C230(TbRef;$1)
If ($L<0)
	$Resultat:=$1
Else 
	Case of 
		: ($2="A")
			$Resultat:=TbEn{$L}
		Else 
			$Resultat:=TbFr{$L}
	End case 
End if 
$0:=$Resultat