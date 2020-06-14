ARRAY TEXT:C222($TbNumRAEMAConcernés;4)
For ($Salé;1;4)
	$TbNumRAEMAConcernés{$Salé}:=RaemaTrouveNumCampagneParAn (Num:C11(<>PUMAnRaemaPoudre{<>PUMAnRaemaPoudre});$Salé)
End for 
QUERY WITH ARRAY:C644([CampagneParticipations:17]NumCampagne:3;$TbNumRAEMAConcernés)
ASAPParFabriqueTbEnvoiColis 

PUMNumCampagneSuivi:=0
OBJECT SET VISIBLE:C603(TbNumCampagne;True:C214)