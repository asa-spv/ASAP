C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area

C_LONGINT:C283($StartSel;$EndSel)
C_POINTER:C301($PtrRichTextArea)
C_POINTER:C301($PtrColorMenuRef)

C_TEXT:C284($RTA_MenuColor)
C_TEXT:C284($Color_t)
C_LONGINT:C283($Color_i)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$ZoneName)
$PtrColorMenuRef:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_FrontColorMenuRef")

If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	  // menu is build "on load" if the dynamic var is present
	  // or "on clicked" if the dynamic var has been removed
	
	If ((Form event code:C388=Sur chargement:K2:1) & (Not:C34(Is nil pointer:C315($PtrColorMenuRef)))) | ((Form event code:C388=Sur clic:K2:4) & (Is nil pointer:C315($PtrColorMenuRef)))
		
		$RTA_MenuColor:=Create menu:C408
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#000000")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_0.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#202020")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_1.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#800062")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_2.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#60009C")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_3.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#00149C")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_4.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#005CB6")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_5.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#008870")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_6.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#0E801C")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_7.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#6B8605")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_8.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#BE7800")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_9.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"#BE0E00")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_10.png")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;"(-")
		
		APPEND MENU ITEM:C411($RTA_MenuColor;" ")
		SET MENU ITEM PARAMETER:C1004($RTA_MenuColor;-1;"ColorPicker")
		SET MENU ITEM ICON:C984($RTA_MenuColor;-1;"file:RTA4D/Colors/FrontColor_Picker.png")
		
	End if 
	
	  // Still "on load" IF the dynamic var is present
	  // => Save the reference of the menu
	If ((Form event code:C388=Sur chargement:K2:1) & (Not:C34(Is nil pointer:C315($PtrColorMenuRef))))
		$PtrColorMenuRef->:=$RTA_MenuColor
	End if 
	
	  // on Clicked 
	If (Form event code:C388=Sur clic:K2:4)
		
		If (Not:C34(Is nil pointer:C315($PtrColorMenuRef)))
			$RTA_MenuColor:=$PtrColorMenuRef->
		Else 
			  // just been build above
		End if 
		
		$Color_t:=Dynamic pop up menu:C1006($RTA_MenuColor)
		
		If ($Color_t#"")
			GET HIGHLIGHT:C209($PtrRichTextArea->;$StartSel;$EndSel)
			
			Case of 
				: ($Color_t="colorPicker")
					$color_i:=Select RGB color:C956(0x00202020)  //almost black 
					ST SET ATTRIBUTES:C1093($PtrRichTextArea->;$StartSel;$EndSel;Attribut couleur texte:K65:7;$color_i)
				Else 
					$Color_t:=Replace string:C233($Color_t;" ";"")
					ST SET ATTRIBUTES:C1093($PtrRichTextArea->;$StartSel;$EndSel;Attribut couleur texte:K65:7;$Color_t)
			End case 
			
		End if 
		
	End if 
	
	  // IF menu has been build "on load" it can be released "on unload"
	  // otherwise it must be released "on clicked"
	
	If ((Form event code:C388=Sur libération:K2:2) & (Not:C34(Is nil pointer:C315($PtrColorMenuRef)))) | ((Form event code:C388=Sur clic:K2:4) & (Is nil pointer:C315($PtrColorMenuRef)))
		
		RELEASE MENU:C978($RTA_MenuColor)
		
	End if 
	
End if 