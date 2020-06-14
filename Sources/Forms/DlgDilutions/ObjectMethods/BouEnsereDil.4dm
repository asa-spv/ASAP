
C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxDilution";$C;$L)
If ($L>0)
	LISTBOX INSERT ROWS:C913(*;"ListBoxDilution";$L)
	LISTBOX SELECT ROW:C912(*;"ListBoxDilution";$L)
End if 
