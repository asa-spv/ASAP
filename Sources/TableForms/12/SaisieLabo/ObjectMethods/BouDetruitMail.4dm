C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxMail";$C;$L)
If ($L=0)
	ALERT:C41("Désignez la l'adresse mail à supprimer...")
Else 
	LISTBOX DELETE ROWS:C914(*;"ListBoxMail";$L)
End if 