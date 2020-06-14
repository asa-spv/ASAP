CONFIRM:C162("Désirez-vous modifier la traduction du RAEMA n°"+TbNR{TbNR})
If (OK=1)
	  // RemplitTableauTraduc
	
	
	$Doc:=Open document:C264("")
	If (OK=1)
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		ARRAY TEXT:C222(TbTraducTableauF;0)  // les phrases en français
		ARRAY TEXT:C222(TbTraducTableauA;0)  // les phrases en anglais
		ARRAY LONGINT:C221(TbTraducN;0)  // NUMÉRO DES LIGNES DES TABLEAUX
		For ($Salé;1;1000000)
			If ($Ligne="")
				$Salé:=1000000
			Else 
				APPEND TO ARRAY:C911(TbTraducTableauF;"")
				APPEND TO ARRAY:C911(TbTraducTableauA;"")
				APPEND TO ARRAY:C911(TbTraducN;$Salé)
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Ligne:=Substring:C12($Ligne;($Pos+1))  // éliminons la colonne des rangs
				$Pos:=Position:C15(<>ZTab;$Ligne)
				TbTraducTableauF{$Salé}:=Substring:C12($Ligne;1;($Pos-1))
				$Ligne:=Substring:C12($Ligne;($Pos+1))
				TbTraducTableauA{$Salé}:=Substring:C12($Ligne;1)
				RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
			End if 
		End for 
	End if 
	CLOSE DOCUMENT:C267($Doc)
	
	
End if 