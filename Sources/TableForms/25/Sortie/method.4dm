$evt:=Form event code:C388
If ($evt=Sur affichage corps:K2:22)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=[CampagneGelGermes:25]UUIDParticipation:2)
	VarNumLaboCGG:=ASAPTrouveNumeroLaboParUUID ([CampagneParticipations:17]UUIDPersonne:2)
End if 
