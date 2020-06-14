Case of 
		
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		  // you have to choose between these options !
		  // ***** EITHER ***** static clock (declared as time) 
		  // *****   OR  ***** dynamic clck (declared as longint)
		
		
		If (True:C214)  //   dynamic clock sample
			
			Self:C308->:=0  // dynamic clock will display current time (0 = no time shift, 3600 = one hour time shift... etc))
			
		Else   // static clock sample
			
			Self:C308->:=?09:30:00?  // static clock -> will display 09:30:00
			
		End if 
		
		
End case 

