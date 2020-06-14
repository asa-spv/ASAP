$evt:=Form event code:C388
If ($evt=Sur nouvelle sélection:K2:29)
	C_LONGINT:C283($C;$L)
	LISTBOX GET CELL POSITION:C971(*;"ListBoxNomsGermes";$C;$L)
	If ($L>0)
		OBJECT SET VISIBLE:C603(*;"BouGermeGel@";(Find in array:C230(TbTousLesNomsDeGermes;<>TbNomGermeSchémaGEL{$L})=-1))
	End if 
End if 