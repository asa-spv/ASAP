$Menu:="Méthode;Milieu;Milieu d'isolement;Fabricant"
$L:=Pop up menu:C542($Menu)
Case of 
	: ($L=1)
		colonne2{colonne2}:="Méthode"
	: ($L=2)
		colonne2{colonne2}:="Milieu"
	: ($L=3)
		colonne2{colonne2}:="Milieu d'isolement"
	: ($L=4)
		colonne2{colonne2}:="Fabricant"
End case 