If (TbNomLigneFr>0)
	C_LONGINT:C283($Salé;$FT)
	CREATE RECORD:C68([RAEMALignes:22])
	[RAEMALignes:22]NomEn:5:="New ligne"
	[RAEMALignes:22]NomFr:4:="Nouvelle ligne"
	If (TbNomLigneFr=1)
		[RAEMALignes:22]Identifiant:3:=TbNR{TbNR}
	Else 
		[RAEMALignes:22]Identifiant:3:=TbIdentifiantLigne{TbNomLigneFr-1}+"a"
	End if 
	[RAEMALignes:22]UUIDGerme:2:=[RAEMAGermes:21]UUID:1
	SAVE RECORD:C53([RAEMALignes:22])
	RaemaSchemaAfficheLignes 
Else 
	ALERT:C41("Désignez d'abord la ligne après laquelle insérer une valeur...")
End if 
