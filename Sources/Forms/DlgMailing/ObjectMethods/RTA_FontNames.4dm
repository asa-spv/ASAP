C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area


C_LONGINT:C283($StartSel;$EndSel)
C_TEXT:C284($FontName)

C_POINTER:C301($PtrPopFontNames)
C_POINTER:C301($PtrRichTextArea)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$ZoneName)
If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	$PtrPopFontNames:=OBJECT Get pointer:C1124(Objet courant:K67:2)
	
	Case of 
		: (Form event code:C388=Sur chargement:K2:1)
			
			FONT LIST:C460($PtrPopFontNames->)
			$PtrPopFontNames->{0}:="-"
			
		: (Form event code:C388=Sur données modifiées:K2:15)
			ModifForme:=True:C214
			$FontName:=$PtrPopFontNames->{$PtrPopFontNames->}
			GET HIGHLIGHT:C209($PtrRichTextArea->;$StartSel;$EndSel)
			ST SET ATTRIBUTES:C1093($PtrRichTextArea->;$StartSel;$EndSel;Attribut nom de police:K65:5;$FontName)
			
	End case 
	
End if 
