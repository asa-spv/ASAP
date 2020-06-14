C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxPersonnesCourriels";$C;$L)
If ($L>0)
	GOTO SELECTED RECORD:C245([PersonnesCourriels:31];$L)
	If ([PersonnesCourriels:31]ObjetCourriel:8.TexteBrut)
		[PersonnesCourriels:31]CorpsCourriel:7:=ST Get plain text:C1092([PersonnesCourriels:31]CorpsCourriel:7)
	End if 
End if 