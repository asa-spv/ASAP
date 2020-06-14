C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(ListBoxCP;$C;$L)
If ($L>0)
	  // actualisation de [ParticipationRAEMA]
	READ WRITE:C146([CampagneParticipations:17])
	GOTO RECORD:C242([CampagneParticipations:17];TbNumEnrParticuliers{$L})
	OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"IndiceCasParticulier")
	SAVE RECORD:C53([CampagneParticipations:17])
	ZAmnistiePartielle (->[CampagneParticipations:17])
	LISTBOX DELETE ROWS:C914(ListBoxCP;$L)
Else 
	ALERT:C41("Merci de séléctionner le labo à ôter des cas particuliers")
End if 