

$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		C_LONGINT:C283($Salé;$FT)
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=CampagneMai;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=CampagneDécembre;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
		$FT:=Records in selection:C76([CampagneParticipations:17])
		$Proprio:="RGProforma"
		For ($Salé;1;$FT)
			If (PUMProformaGel>1)
				OB SET:C1220([CampagneParticipations:17]Arguments:5;$Proprio;PUMProformaGel{PUMProformaGel})
			Else 
				OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;$Proprio)
			End if 
			SAVE RECORD:C53([CampagneParticipations:17])
		End for 
		  // ASAPActualiseTbParticipation (CampagneMai;"RGProforma";PUMProformaGel{PUMProformaGel})
		  // ASAPActualiseTbParticipation (CampagneDécembre;"RGProforma";PUMProformaGel{PUMProformaGel})
		ZAmnistiePartielle (->[CampagneParticipations:17])
End case 
