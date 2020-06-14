
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ZBlobVersVariable (->[XData:1]XBlob:13;->TbBlob1;->TbBlob2;->TbBlob3)
	: ($evt=Sur validation:K2:3)
		
End case 
