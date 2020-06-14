Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		SET TIMER:C645(-1)
		
	: (Form event code:C388=Sur minuteur:K2:25)
		SET TIMER:C645(0)
		CALL FORM:C1391(Current form window:C827;"ZNewsAffiche")
		SET TIMER:C645(5*60)  // 5 secondes
		
	: (Form event code:C388=Sur libération:K2:2)
		CLOSE WINDOW:C154(Current form window:C827)
		
End case 