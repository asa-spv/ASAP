If ([Personnes:12]Caduc:8)
	$Message:="Rendre caduc ce laboratoire aura pour effet de le faire disparaître de la liste affichée "
	$Message:=$Message+"et de ne plus lui permettre de participer au RAEMA."
	ALERT:C41($Message)
	CONFIRM:C162("Vouvez-vous VRAIMENT rendre ce laboratoire caduc ???")
	If (OK=0)
		[Personnes:12]Caduc:8:=False:C215
	End if 
End if 
