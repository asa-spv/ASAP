$evt:=Form event code:C388

If ($evt=Sur données modifiées:K2:15)
	$L:=Find in array:C230(<>TbNomTableBase;TbNomTable{TbNomTable})
	$Propriété:="ET"+String:C10(<>TbNumTableBase{$L})
	OB GET ARRAY:C1229(ObjetET;$Propriété;TbNomAffiche)
	$Propriété:="NC"+String:C10(<>TbNumTableBase{$L})
	OB GET ARRAY:C1229(ObjetET;$Propriété;TbNomStructure)
	$TT:=Size of array:C274(TbNomAffiche)
	ARRAY LONGINT:C221(TbNumChampAffiche;$TT)
	For ($Salé;1;$TT)
		$L:=Find in array:C230(<>TbNomChampBase;TbNomStructure{$Salé})
		TbNumChampAffiche{$Salé}:=<>TbNumChampBase{$l}
	End for 
	
End if 