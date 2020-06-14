C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(ListBoxParticipant;$C;$L)
If ($L>0)
	If (Find in array:C230(TbCasParticuliersA;TbParticipantA{$L})=-1)
		APPEND TO ARRAY:C911(TbCasParticuliersA;TbParticipantA{$L})
		APPEND TO ARRAY:C911(TbCasParticuliersN;Num:C11(TbParticipantA{$L}))
		APPEND TO ARRAY:C911(TbNumEnrParticuliers;TbNumEnrLP{$l})
		
		  // actualisation de [ParticipationRAEMA]
		READ WRITE:C146([CampagneParticipations:17])
		GOTO RECORD:C242([CampagneParticipations:17];TbNumEnrLP{$l})
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"IndiceCasParticulier";PUMMotifsCP)
		SAVE RECORD:C53([CampagneParticipations:17])
		ZAmnistiePartielle (->[CampagneParticipations:17])
		MULTI SORT ARRAY:C718(TbCasParticuliersN;>;TbCasParticuliersA;>;TbNumEnrParticuliers)
		
	Else 
		ALERT:C41("Le labo est déjà noté comme cas particulier")
	End if 
	
End if 