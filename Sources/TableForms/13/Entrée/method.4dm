
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY LONGINT:C221($TbNumEnrRaemaRetenu;0)
		ZBlobVersVariable (->[WebConnexions:13]BlobConnexion:11;->TbNumEch;->TbNumEchT;->$TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbCorpsMail;->TbPJ)
		
		$Pt:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"VarNumRAEMA")
		$Pt->:=WebTrouveValeurParNom ([WebConnexions:13]CodeConnexion:4;-><>TbPerIdentificateur;-><>TbPerNumLaboRAEMA)
End case 
