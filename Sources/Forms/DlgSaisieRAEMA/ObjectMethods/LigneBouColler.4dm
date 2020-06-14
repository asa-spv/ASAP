C_LONGINT:C283($Salé;$FT)
If (Size of array:C274(TbNomLigneFr)>0)
	ALERT:C41("Désolé, je ne peux coller un tableau que dans une liste vide...")
Else 
	$FT:=Size of array:C274(TbNECopierLigne)
	ARRAY TEXT:C222($TbIDGerme;$FT)
	ARRAY TEXT:C222($TbIdentifiantLigne;$FT)
	READ WRITE:C146([RAEMALignes:22])
	For ($Salé;1;$FT)
		GOTO RECORD:C242([RAEMALignes:22];TbNECopierLigne{$Salé})
		DUPLICATE RECORD:C225([RAEMALignes:22])
		[RAEMALignes:22]UUIDGerme:2:=[RAEMAGermes:21]UUID:1
		[RAEMALignes:22]Identifiant:3:=[RAEMAGermes:21]Identifiant:3+String:C10($Salé;"00")
		[RAEMALignes:22]UUID:1:=Generate UUID:C1066
		SAVE RECORD:C53([RAEMALignes:22])
	End for 
End if 
RaemaSchemaAfficheLignes 