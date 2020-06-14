C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"LBCT";$C;$L)
If ($L>0)
	CONFIRM:C162("Désirez-vous VRAIMENT supprimer le courriel-type "+ZZonelettre{$L}+"???")
	If (OK=1)
		READ WRITE:C146([CourrielsTypes:28])
		GOTO RECORD:C242([CourrielsTypes:28];TbNumEnrLT{$L})
		DELETE RECORD:C58([CourrielsTypes:28])
		ZAmnistiePartielle (->[CourrielsTypes:28])
		ASAPCourrielsAfficheCT 
		LISTBOX DELETE ROWS:C914(*;"LBCT";$L)
		
	End if 
Else 
	
	ALERT:C41("Désignez le courriel type à supprimer de la liste...")
End if 
