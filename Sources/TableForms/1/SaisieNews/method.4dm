$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		If ([XData:1]XAlpha:8="")
			[XData:1]XNom:2:="News de "+<>ZQuiVaLa
			[XData:1]XType:3:="MsgNews"
			[XData:1]XAlpha:8:=<>ZQuiVaLa
			[XData:1]XDate:4:=Current date:C33
			[XData:1]XTexteSup:10:=String:C10([XData:1]XDate:4)+" à "+String:C10(Current time:C178)
		End if 
		
End case 
