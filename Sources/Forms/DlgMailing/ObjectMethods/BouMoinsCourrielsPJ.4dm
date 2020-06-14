C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxCourrielsPJ";$C;$L)
If ($L>0)
	LISTBOX DELETE ROWS:C914(*;"ListBoxCourrielsPJ";$L)
Else 
	ALERT:C41("Désignez le PJ à supprimer de la liste...")
End if 
