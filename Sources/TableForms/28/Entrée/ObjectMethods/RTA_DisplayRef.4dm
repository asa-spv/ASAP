C_TEXT:C284($ZoneName)
C_TEXT:C284($ButtonName)

$ZoneName:="RTA_Text"  // change THIS if you change the name of the area
$ButtonName:="RTA_DisplayRef"

C_LONGINT:C283($StartSel;$EndSel)
C_LONGINT:C283($CurrentVal)

C_POINTER:C301($PtrRichTextArea)
C_POINTER:C301($PtrBtnDisplayRef)



$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$ZoneName)
$PtrBtnDisplayRef:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$ButtonName)

If (Not:C34(Is nil pointer:C315($PtrRichTextArea))) & (Not:C34(Is nil pointer:C315($PtrBtnDisplayRef)))
	Case of 
			
		: (Form event code:C388=Sur chargement:K2:1)
			
		: (Form event code:C388=Sur clic:K2:4)
			
			$CurrentVal:=$PtrBtnDisplayRef->
			ST SET OPTIONS:C1289($PtrRichTextArea->;1;$CurrentVal)
			
			If ($CurrentVal=1)
				OBJECT SET FORMAT:C236(*;$ButtonName;";#/RTA4D/Functions/mask_On.png")
			Else 
				OBJECT SET FORMAT:C236(*;$ButtonName;";#/RTA4D/Functions/mask_Off.png")
			End if 
			
		: (Form event code:C388=Sur libération:K2:2)
			
	End case 
	
End if 