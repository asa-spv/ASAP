
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		
		OB SET:C1220([RAEMAValeurs:23]Arguments:6;"Milieu";PUMMilieu{PUMMilieu})
		SAVE RECORD:C53([RAEMAValeurs:23])
		
End case 
