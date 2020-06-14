$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		C_LONGINT:C283($Salé;$FT)
		
		OnAChangéParticipation:=True:C214
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=CampagneMars;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=CampagneOctobre;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
		$FT:=Records in selection:C76([CampagneParticipations:17])
		For ($Salé;1;$FT)
			If (PUMProforma>1)
				OB SET:C1220([CampagneParticipations:17]Arguments:5;"Proforma";PUMProforma{PUMProforma})
				OB SET:C1220([Personnes:12]Arguments:7;"Proforma";PUMProforma{PUMProforma})
			Else 
				OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"Proforma")
				OB REMOVE:C1226([Personnes:12]Arguments:7;"Proforma")
			End if 
			SAVE RECORD:C53([CampagneParticipations:17])
		End for 
		
		  //ASAPActualiseTbParticipation (CampagneMars;"Proforma";PUMProforma{PUMProforma})
		  //ASAPActualiseTbParticipation (CampagneOctobre;"Proforma";PUMProforma{PUMProforma})
		
		ZAmnistiePartielle (->[CampagneParticipations:17])
		
		  //  VarArguments:=JSON Stringify([CampagneParticipations]Arguments)
End case 