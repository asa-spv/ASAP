
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		C_LONGINT:C283($C;$L)
		C_POINTER:C301($Pt)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxLoto";$C;$L;$Pt)
		If ($L<0)
			ALERT:C41("Merci de cliquer sur un n° de laboratoire")
		Else 
			$NumLaboA:=$Pt->{$L}
			If ($NumLaboA="")
				ALERT:C41("Merci de cliquer sur un n° de laboratoire")
			Else 
				ALERT:C41("Vous avez désigné le laboratoire n°"+$NumLaboA)
			End if 
		End if 
End case 
