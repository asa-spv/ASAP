C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area

C_LONGINT:C283($StartSel;$EndSel)
C_POINTER:C301($PtrRichTextArea)
C_TEXT:C284($Expression)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$ZoneName)

If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	Case of 
			
		: (Form event code:C388=Sur chargement:K2:1)
			
		: (Form event code:C388=Sur clic:K2:4)
			
			GET HIGHLIGHT:C209($PtrRichTextArea->;$StartSel;$EndSel)
			If (False:C215)
				$Expression:=Request:C163("Expression")
				If (ok=1)
					ST INSERT EXPRESSION:C1281($PtrRichTextArea->;$Expression;$StartSel;$EndSel)
				End if 
			Else 
				ST INSERT EXPRESSION:C1281($PtrRichTextArea->;"VarAdresse";$StartSel;$EndSel)
			End if 
		: (Form event code:C388=Sur libération:K2:2)
			
	End case 
	
End if 