
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		If (VarTransPart#"")
			OB SET:C1220([Personnes:12]Arguments:7;"TransPart";VarTransPart)
		Else 
			OB REMOVE:C1226([Personnes:12]Arguments:7;"TransPart")
			CaCTransPart:=0
		End if 
End case 
