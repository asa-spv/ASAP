If (TbNomValeurFr>0)
	C_LONGINT:C283($Salé;$FT)
	READ WRITE:C146([RAEMAValeurs:23])
	GOTO SELECTED RECORD:C245([RAEMAValeurs:23];TbNomValeurFr)
	CONFIRM:C162("Voulez-vous VRAIMENT supprimer DEFINITIVEMENT le Valeur "+<>ZGuil+" "+TbNomValeurFr{TbNomValeurFr}+" "+<>ZGuil+" ????")
	If (ok=1)
		DELETE RECORD:C58([RAEMAValeurs:23])
		ZAmnistiePartielle (->[RAEMAValeurs:23])
		RaemaSchemaAfficheValeurs 
	End if 
Else 
	ALERT:C41("Désignez d'abord la Valeur à supprimer...")
End if 
