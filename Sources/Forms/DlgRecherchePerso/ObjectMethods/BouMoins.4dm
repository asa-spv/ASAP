C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxRecherche";$C;$L)
If ($L>0)
	LISTBOX DELETE ROWS:C914(*;"ListBoxRecherche";$L)
Else 
	ALERT:C41("Merci de selectionner la ligne à supprimer ...")
End if 