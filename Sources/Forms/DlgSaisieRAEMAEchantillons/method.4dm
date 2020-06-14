$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		If (Size of array:C274(TbNumEchRaema1)=0)
			RaemaEchFabriqueTbSeries 
		End if 
		OBJECT SET VISIBLE:C603(BouImporteNumEch;(Size of array:C274(TbNumEchRaema)=0))
		
End case 
