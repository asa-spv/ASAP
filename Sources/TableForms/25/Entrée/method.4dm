
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=[CampagneGelGermes:25]UUIDParticipation:2)
		$L:=Find in array:C230(<>TbPerUUID;[CampagneParticipations:17]UUIDPersonne:2)
		VarNumLabo:=<>TbPerNumLaboRAEMA{$L}
		VarNomLabo:=<>TbPerNomLong{$L}
End case 
