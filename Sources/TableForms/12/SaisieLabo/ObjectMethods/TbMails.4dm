
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		$Adresse:=TbMails{TbMails}
		$L:=Find in array:C230(TbMails;$Adresse)
		If (Find in array:C230(TbMails;$Adresse;($L+1))>0)
			ALERT:C41("Désolé, l'adresse "+$Adresse+" existe déjà...")
			LISTBOX DELETE ROWS:C914(*;"ListBoxMail";TbMails)
		Else 
			$pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,4})+)$"
			If (Match regex:C1019($pattern;$Adresse;1)=False:C215)
				ALERT:C41("Désolé, l'adresse "+$Adresse+" n'est pas de type mail...")
				LISTBOX DELETE ROWS:C914(*;"ListBoxMail";TbMails)
			End if 
		End if 
		
End case 
