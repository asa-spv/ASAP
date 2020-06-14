$RaemaEnCours:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);2)
VarNumRaema1:=String:C10(Num:C11($RaemaEnCours)-1)+"A"
VarNumRaema2:=String:C10(Num:C11($RaemaEnCours)-2)+"A"
VarNumRaema3:=String:C10(Num:C11($RaemaEnCours)-3)+"A"
VarNumRaema4:=String:C10(Num:C11($RaemaEnCours)-4)+"A"
VarTbRevDir1:="RAEMA "+VarNumRaema1+<>ZCR+"Dernière campagne n"
VarTbRevDir2:="RAEMA "+VarNumRaema2+<>ZCR+"Campagne (n-1)"
VarTbRevDir3:="RAEMA "+VarNumRaema3+<>ZCR+"Campagne (n-2)"
VarTbRevDir4:="RAEMA "+VarNumRaema4+<>ZCR+"Campagne (n-3)"
If (PumDomaine=1)
	RetourCalculTableauRevDir 
Else 
	RetourCalculTableauRevDir (PumDomaine)
End if 