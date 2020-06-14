PRINT SETTINGS:C106(2)
If (OK=1)
	_O_PAGE SETUP:C299("DlgTableauxRevDirection")
	$TypeRaema:=(RadPoudre*"Poudre")+(RadGel*"Gel")
	If (PUMDomaine=1)
		$Domaine:=" pour toutes les catégories"
	Else 
		$Domaine:=" pour la catégorie "+PUMDomaine{PUMDomaine}
	End if 
	VarTitre:="Tableaux pour le RAEMA "+$TypeRaema+$Domaine
	$H:=Print form:C5([RetoursFiches:24];"DlgTableauxRevueDirection")
	PAGE BREAK:C6
End if 