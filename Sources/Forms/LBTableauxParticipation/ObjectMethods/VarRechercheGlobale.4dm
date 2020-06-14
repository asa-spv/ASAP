
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		$Pt:=OBJECT Get pointer:C1124
		$Pt->:=""
		
	: ($evt=Sur après frappe clavier:K2:26)
		$Test:="@"+Get edited text:C655+"@"
		If (Length:C16($Test)>3)
			QUERY:C277(ZPtTable->;ZPtChamp->=$Test)
			ZFenetreActualiseTitre 
		End if 
		
End case 

