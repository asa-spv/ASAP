C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area


C_LONGINT:C283($StartSel;$EndSel)
C_LONGINT:C283($FontSize)

C_POINTER:C301($PtrPopFontSizes)
C_POINTER:C301($PtrRichTextArea)

$PtrPopFontSizes:=OBJECT Get pointer:C1124(Objet courant:K67:2)
$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$ZoneName)
If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	C_LONGINT:C283($size)
	C_POINTER:C301($_size_p)
	
	Case of 
			
		: (Form event code:C388=Sur chargement:K2:1)
			
			APPEND TO ARRAY:C911($PtrPopFontSizes->;7)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;8)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;9)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;10)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;11)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;12)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;13)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;14)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;18)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;22)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;24)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;28)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;36)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;48)
			APPEND TO ARRAY:C911($PtrPopFontSizes->;72)
			
		: (Form event code:C388=Sur données modifiées:K2:15)
			ModifForme:=True:C214
			$FontSize:=$PtrPopFontSizes->{$PtrPopFontSizes->}
			GET HIGHLIGHT:C209($PtrRichTextArea->;$StartSel;$EndSel)
			ST SET ATTRIBUTES:C1093($PtrRichTextArea->;$StartSel;$EndSel;Attribut taille texte:K65:6;$FontSize)
			
	End case 
	
Else 
	ALERT:C41("The name of the zone has been changed! Please, modify the button scripts!")
End if 
