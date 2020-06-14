$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (PUMTransporteur>0)
			VarMaiTransport:=PUMTransporteur{PUMTransporteur}
			$Proprio:="RGTransporteur"+CampagneMai
			If (VarMaiTransport#"")
				OB SET:C1220([Personnes:12]Arguments:7;$Proprio;VarMaiTransport)
			Else 
				OB REMOVE:C1226([Personnes:12]Arguments:7;$Proprio)
			End if 
		End if 
End case 
