//%attributes = {}
If (GestionTableau)
	C_LONGINT:C283($Salé;$FT)
	  // gestion suppressions de lignes 
	$FT:=Size of array:C274(TbNumEnr)
	For ($Salé;1;$FT)
		$Rang:=$FT-$Salé+1
		If (Lb_Tableaux{$Rang})
			LISTBOX DELETE ROWS:C914(*;"Lb_Tableaux";$Rang)
		End if 
	End for 
Else 
	CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)
	DIFFERENCE:C122(ZNomEnsembleAvant;"$ZFichesSurlignees";"ceusses maintenant")
	USE SET:C118("ceusses maintenant")
	CLEAR SET:C117("ceusses maintenant")
End if 




