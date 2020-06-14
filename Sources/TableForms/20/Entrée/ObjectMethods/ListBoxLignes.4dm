If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283($C;$L)
	LISTBOX GET CELL POSITION:C971(*;"ListBoxLignes";$C;$L)
	If ($L>0)
		GOTO SELECTED RECORD:C245([RAEMALignes:22];$L)
		RELATE MANY:C262([RAEMALignes:22]UUID:1)
		ORDER BY:C49([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3;>)
	End if 
End if 