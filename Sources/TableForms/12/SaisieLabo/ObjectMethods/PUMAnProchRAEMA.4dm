$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		VarProchParticipe:=PUMAnProchRAEMA{PUMAnProchRAEMA}
		If (VarProchParticipe#Year of:C25(Current date:C33))
			OB SET:C1220([Personnes:12]Arguments:7;"ProchParticipe";VarProchParticipe)
		End if 
End case 