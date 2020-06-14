SAVE RECORD:C53([PersonnesAdresses:11])
QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]UUIDPersonne:2=[Personnes:12]UUID:1;*)
QUERY:C277([PersonnesAdresses:11]; & [PersonnesAdresses:11]TypeAdresse:9=PUMAdresse{PUMAdresse})
If (Records in selection:C76([PersonnesAdresses:11])=0)
	CREATE RECORD:C68([PersonnesAdresses:11])
	[PersonnesAdresses:11]UUIDPersonne:2:=[Personnes:12]UUID:1
	[PersonnesAdresses:11]TypeAdresse:9:=PUMAdresse{PUMAdresse}
	SAVE RECORD:C53([PersonnesAdresses:11])
End if 
