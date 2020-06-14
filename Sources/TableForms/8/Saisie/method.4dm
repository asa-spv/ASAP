
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		If ([XLocalisations:8]Pays:16="")
			[XLocalisations:8]Pays:16:="FRANCE"
		End if 
		
		
End case 
