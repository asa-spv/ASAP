C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area

C_LONGINT:C283($StartSel;$EndSel)

C_POINTER:C301($PtrButton)
C_LONGINT:C283($Value)
C_POINTER:C301($PtrRichTextArea)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$ZoneName)
If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	ModifForme:=True:C214
	$PtrButton:=Self:C308
	$Value:=$PtrButton->
	
	$Value:=0
	$PtrButton->:=$Value
	
	GET HIGHLIGHT:C209($PtrRichTextArea->;$StartSel;$EndSel)
	ST SET ATTRIBUTES:C1093($PtrRichTextArea->;$StartSel;$EndSel;Attribut style gras:K65:1;$Value;Attribut style italique:K65:2;$Value;Attribut style souligné:K65:4;$Value;Attribut style barré:K65:3;$Value)
	
End if 