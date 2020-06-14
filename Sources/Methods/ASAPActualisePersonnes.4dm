//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/02/19, 17:57:47
  // ----------------------------------------------------
  // Méthode : ASAPActualisePersonnes
  // Description
  // Méthode rattrapage des données de [Personnes]
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($CodeRL)
READ WRITE:C146([Personnes:12])
ALL RECORDS:C47([Personnes:12])

$Ft:=Records in selection:C76([Personnes:12])
For ($Salé;1;$FT)
	[Personnes:12]ChampRecherche:6:=ASAPPerCreationChampRecherche 
	
	  // Raema liés
	OB REMOVE:C1226([Personnes:12]Arguments:7;"TbCodesRAEMALiés")
	ARRAY TEXT:C222($TbCodesRL;0)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
	QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
	If (Records in selection:C76([CampagneParticipations:17])>0)
		$SFT:=Records in selection:C76([CampagneParticipations:17])
		For ($Fumé;1;$SFT)
			$CodeRL:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"CodeRaemaLié")
			If (Find in array:C230($TbCodesRL;$CodeRL)<0)
				APPEND TO ARRAY:C911($TbCodesRL;$CodeRL)
			End if 
			NEXT RECORD:C51([CampagneParticipations:17])
		End for 
		If (Size of array:C274($TbCodesRL)>0)
			OB SET:C1220([Personnes:12]Arguments:7;"TbCodesRAEMALiés";ZTableauVersTexte (->$TbCodesRL;" "))
		End if 
	End if 
	SAVE RECORD:C53([Personnes:12])
	NEXT RECORD:C51([Personnes:12])
End for 

ASAPActualiseLoto 

ZAmnistieInternationale 