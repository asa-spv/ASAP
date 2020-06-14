
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (CaCTransportPayant=1)
			OB SET:C1220([Personnes:12]Arguments:7;"TransportPayant";"Vrai")
			GOTO OBJECT:C206(VarPrixTransport)
		Else 
			OB REMOVE:C1226([Personnes:12]Arguments:7;"TransportPayant")
			OB REMOVE:C1226([Personnes:12]Arguments:7;"PrixTransporteur")
			VarPrixTransport:=0
		End if 
		OBJECT SET VISIBLE:C603(VarPrixTransport;(CaCTransportPayant=1))
		
End case 
