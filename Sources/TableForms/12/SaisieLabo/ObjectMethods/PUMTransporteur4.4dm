$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (PUMTransporteur>0)
			VarDécembreTransport:=PUMTransporteur{PUMTransporteur}
			$Proprio:="RGTransporteur"+CampagneDécembre
			If (VarDécembreTransport#"")
				OB SET:C1220([Personnes:12]Arguments:7;$Proprio;VarDécembreTransport)
			Else 
				OB REMOVE:C1226([Personnes:12]Arguments:7;$Proprio)
			End if 
		End if 
End case 