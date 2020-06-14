$evt:=Form event code:C388

Case of 
		
	: ($evt=Sur clic:K2:4)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(ZZonelettre;$C;$L)
		If ($L>0)
			GOTO RECORD:C242([CourrielsTypes:28];TbNumEnrLT{$L})
			VarSujet:=[CourrielsTypes:28]NomLettre:2
			LISTBOX SELECT ROW:C912(*;"DestLBCourrielAdh";1)
			ASAPCourrielsMontreTextes 
			OBJECT SET VISIBLE:C603(*;"BouEnvoi";True:C214)
			VarRechCT:=""
		Else 
			ALERT:C41("Merci de désigner le courriel-type à employer...")
		End if 
End case 
