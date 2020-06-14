If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283($C;$L)
	LISTBOX GET CELL POSITION:C971(*;"ListBoxGermes";$C;$L)
	If ($L>0)
		GOTO SELECTED RECORD:C245([RAEMAGermes:21];$L)
		RELATE MANY:C262([RAEMAGermes:21]UUID:1)
		ORDER BY:C49([RAEMALignes:22];[RAEMALignes:22]Identifiant:3;>)
	End if 
End if 