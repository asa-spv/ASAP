If (TbNomValeurFr>0)
	C_LONGINT:C283($Salé;$FT)
	CREATE RECORD:C68([RAEMAValeurs:23])
	[RAEMAValeurs:23]NomEn:5:="New Valeur"
	[RAEMAValeurs:23]NomFr:4:="Nouvelle Valeur"
	If (TbNomValeurFr=1)
		[RAEMAValeurs:23]Identifiant:3:=TbNR{TbNR}
	Else 
		[RAEMAValeurs:23]Identifiant:3:=TbIdentifiantValeur{TbNomValeurFr-1}+"a"
	End if 
	[RAEMAValeurs:23]UUIDLigne:2:=[RAEMALignes:22]UUID:1
	SAVE RECORD:C53([RAEMAValeurs:23])
	RaemaSchemaAfficheValeurs 
Else 
	ALERT:C41("Désignez d'abord la valeur après laquelle en insérer une nouvelle...")
End if 
