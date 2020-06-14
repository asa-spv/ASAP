If (ZZoneCli>0)
	GOTO SELECTED RECORD:C245([Personnes:12];ZZoneCli)
	If (Not:C34(MailAdherent))
		GOTO SELECTED RECORD:C245([Factures:15];ZZoneCli)
	End if 
	ASAPCourrielsRenseigneChamps (TbMailPerUUID{ZZoneCli})
	$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text")
	$PtrRichTextArea->:=[CourrielsTypes:28]TexteType:5
	ST COMPUTE EXPRESSIONS:C1285($PtrRichTextArea->)
	LeMessageBrut:=ST Get plain text:C1092($PtrRichTextArea->;ST Expressions 4D comme valeurs:K78:9)
	OBJECT SET VISIBLE:C603(*;"RTA_Text";Not:C34(TbBrut{TbBrut}))
	OBJECT SET VISIBLE:C603(LeMessageBrut;TbBrut{TbBrut})
End if 