$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		ZVerrouAttendre (->[RAEMAValeurs:23])
		OB SET:C1220([RAEMAValeurs:23]Arguments:6;"TipsEn";VarTipsEn)
		SAVE RECORD:C53([RAEMAValeurs:23])
		ZAmnistiePartielle (->[RAEMAValeurs:23];True:C214)
End case 
