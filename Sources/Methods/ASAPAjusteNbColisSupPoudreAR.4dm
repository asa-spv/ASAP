//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/02/19, 16:04:01
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPAjusteNbColisSupPoudreAR
  // Description
  // Méthode qui note dans les participtions le nombre de colis sup poudre avec rapport

READ WRITE:C146([CampagneParticipations:17])
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)  // toutes les participation au tritre d'un PSAR
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDLabo;[CampagneParticipations:17]NumCampagne:3;$TbNumCampagne)
$FT:=Size of array:C274($TbUUIDLabo)
For ($Salé;1;$FT)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=$TbUUIDLabo{$Salé};*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$TbNumCampagne{$Salé})
	$SFT:=Records in selection:C76([CampagneParticipations:17])
	$NbCSAR:=$SFT-1
	For ($Fumé;1;$SFT)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"NbreColisSupAvecRapport";$NbCSAR)
		SAVE RECORD:C53([CampagneParticipations:17])
		NEXT RECORD:C51([CampagneParticipations:17])
	End for 
End for 
ASAPFabriqueTbParticipe 
ZAmnistieInternationale 

