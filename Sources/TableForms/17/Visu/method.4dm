
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		
		RELATE MANY:C262([CampagneParticipations:17]UUID:1)
		VarNumLabo:=Num:C11(ASAPTrouveNumeroLaboParUUID ([CampagneParticipations:17]UUIDPersonne:2))
		VarNumEnr:=Record number:C243([CampagneParticipations:17])
End case 
