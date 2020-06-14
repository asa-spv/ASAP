$Campagne:=""
$TT:=Size of array:C274(TbAnCampagne)

  //Pour le tableau de booléens de P1 Colonne4B
  // Qui correspond au tableau Texte Colonne4 
For ($Salé;1;$TT)
	If (Colonne4B{$Salé})
		$Campagne:=$Campagne+Colonne4{$Salé}+" "
	End if 
End for 
[RetoursFiches:24]Campagne:7:=$Campagne

For ($Salé;1;$TT)
	If (Colonne5B{$Salé})
		$Campagne:=$Campagne+Colonne5{$Salé}+" "
	End if 
End for 
[RetoursFiches:24]Campagne:7:=$Campagne

For ($Salé;1;$TT)
	If (Colonne6B{$Salé})
		$Campagne:=$Campagne+Colonne6{$Salé}+" "
	End if 
End for 
[RetoursFiches:24]Campagne:7:=$Campagne

For ($Salé;1;$TT)
	If (Colonne7B{$Salé})
		$Campagne:=$Campagne+Colonne7{$Salé}+" "
	End if 
End for 
[RetoursFiches:24]Campagne:7:=$Campagne