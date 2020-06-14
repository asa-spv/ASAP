PRINT SETTINGS:C106(2)  // Permet de passer au deuxième écran pour pouvoir faire une impression PDF
If (OK=1)
	_O_PAGE SETUP:C299("ImpressionTbConsultatif")
	If (PUMDomaine=1)
		$Domaine:=" pour toutes les domaines"
	Else 
		$Domaine:=" pour le domaine "+PUMDomaine{PUMDomaine}
	End if 
	VarTitre:="Tableau récapitulatif du Groupe Consultatif "+$Domaine+" du "+String:C10(VarDateDebut)+" au "+String:C10(VarDateFin)
	
	contexte:="ET"
	$H:=Print form:C5("ImpressionTbConsultatif")
	$TT:=Size of array:C274(TbRASA)
	$VarImp2:=0
	$VarImp3:=0
	$VarImp4:=0
	$VarImp5:=0
	$VarImp6:=0
	$VarImp7:=0
	$VarImp8:=0
	$VarImp9:=0
	$VarImp10:=0
	$VarImp11:=0
	For ($salé;1;$TT)
		VarImp1:=TbCampagnesConcernees{$salé}
		VarImp2:=TbRASA{$salé}
		VarImp3:=TbRADILVA{$salé}
		VarImp4:=TbRTotal{$salé}
		VarImp5:=TbRIASA{$salé}
		VarImp6:=TbRIADILVA{$salé}
		VarImp7:=TbRITotal{$salé}
		VarImp8:=TbDIASA{$salé}
		VarImp9:=TbDIADILVA{$salé}
		VarImp10:=TbDITotal{$salé}
		VarImp11:=VarImp4+VarImp7+VarImp10
		$VarImp2:=$VarImp2+VarImp2
		$VarImp3:=$VarImp3+VarImp3
		$VarImp4:=$VarImp4+VarImp4
		$VarImp5:=$VarImp5+VarImp5
		$VarImp6:=$VarImp6+VarImp6
		$VarImp7:=$VarImp7+VarImp7
		$VarImp8:=$VarImp8+VarImp8
		$VarImp9:=$VarImp9+VarImp9
		$VarImp10:=$VarImp10+VarImp10
		$VarImp11:=$VarImp11+VarImp11
		contexte:="ligne"
		$H:=Print form:C5("ImpressionTbConsultatif")
	End for 
	VarImp1:="Total"
	VarImp2:=$VarImp2
	VarImp3:=$VarImp3
	VarImp4:=$VarImp4
	VarImp5:=$VarImp5
	VarImp6:=$VarImp6
	VarImp7:=$VarImp7
	VarImp8:=$VarImp8
	VarImp9:=$VarImp9
	VarImp10:=$VarImp10
	VarImp11:=$VarImp11
	$H:=Print form:C5("ImpressionTbConsultatif")
	
	PAGE BREAK:C6
End if 