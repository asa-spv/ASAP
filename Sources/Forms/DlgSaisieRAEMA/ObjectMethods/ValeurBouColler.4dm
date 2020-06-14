C_LONGINT:C283($Salé;$FT)
If (Size of array:C274(TbNomValeurFr)>0)
	ALERT:C41("Désolé, je ne peux coller un tableau que dans une liste vide...")
Else 
	$FT:=Size of array:C274(TbNECopierValeur)
	ARRAY TEXT:C222($TbIDGerme;$FT)
	ARRAY TEXT:C222($TbIdentifiantValeur;$FT)
	READ WRITE:C146([RAEMAValeurs:23])
	For ($Salé;1;$FT)
		GOTO RECORD:C242([RAEMAValeurs:23];TbNECopierValeur{$Salé})
		DUPLICATE RECORD:C225([RAEMAValeurs:23])
		[RAEMAValeurs:23]UUIDLigne:2:=[RAEMALignes:22]UUID:1
		[RAEMAValeurs:23]Identifiant:3:=[RAEMALignes:22]Identifiant:3+String:C10($Salé;"00")
		[RAEMAValeurs:23]UUID:1:=Generate UUID:C1066
		SAVE RECORD:C53([RAEMAValeurs:23])
	End for 
End if 
RaemaSchemaAfficheValeurs 