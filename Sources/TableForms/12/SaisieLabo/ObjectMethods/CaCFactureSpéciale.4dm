If (CaCFactureSpeciale=0)
	OB REMOVE:C1226([Personnes:12]Arguments:7;"FacturationSpeciale")
Else 
	OB SET:C1220([Personnes:12]Arguments:7;"FacturationSpeciale";"Vrai")
End if 