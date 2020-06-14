$gel:=RadGel
$poudre:=RadPoudre
$domaine:=PUMDomaine
PRINT SETTINGS:C106(2)
If (OK=1)
	_O_PAGE SETUP:C299("DlgTableauxRevDirection")
	For ($salé;1;6)
		RetourAfficheTableaux ("poudre";$salé)
		If ($salé=1)
			VarTitre:="Tableaux généraux pour le RAEMA poudre"
		Else 
			VarTitre:="Tableaux pour le RAEMA poudre pour la catégorie "+PUMDomaine{$salé}
		End if 
		$H:=Print form:C5([RetoursFiches:24];"DlgTableauxRevueDirection")
		RetourAfficheTableaux ("gel";$salé)
		If ($salé=1)
			VarTitre:="Tableaux généraux pour le RAEMA gel"
		Else 
			VarTitre:="Tableaux pour le RAEMA gel pour la catégorie "+PUMDomaine{$salé}
		End if 
		$H:=Print form:C5([RetoursFiches:24];"DlgTableauxRevueDirection")
		If ($salé<6)
			PAGE BREAK:C6(>)
		Else 
			PAGE BREAK:C6
		End if 
	End for 
	$type:=(Num:C11($gel)*"Gel")+(Num:C11($Poudre)*"Poudre")
	RetourAfficheTableaux ($type;$domaine)
End if 