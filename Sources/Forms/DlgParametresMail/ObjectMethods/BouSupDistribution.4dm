C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxDistribution";$C;$L)
If ($L>0)
	CONFIRM:C162("Voulez-vous VRAIMENT supprimer "+TbMailsDistribution{$L}+" de la liste ???")
	If (OK=1)
		LISTBOX DELETE ROWS:C914(*;"ListBoxDistribution";$L)
	End if 
Else 
	ALERT:C41("Merci de désigner l'adresse à supprimer")
End if 