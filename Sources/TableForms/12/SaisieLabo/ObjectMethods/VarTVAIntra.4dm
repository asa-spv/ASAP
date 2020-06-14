$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		If (VarTVAIntra="")
			OB REMOVE:C1226([Personnes:12]Arguments:7;"NumTVAIntraCom")
		Else 
			OB SET:C1220([Personnes:12]Arguments:7;"NumTVAIntraCom";VarTVAIntra)
		End if 
		
End case 
