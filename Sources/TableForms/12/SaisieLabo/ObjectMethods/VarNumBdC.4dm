
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
			If (VarNumBdC#"")
				OB SET:C1220([CampagneParticipations:17]Arguments:5;"NumBonCommandePoudre";VarNumBdC)
			Else 
				OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"NumBonCommandePoudre")
			End if 
			SAVE RECORD:C53([CampagneParticipations:17])
			NEXT RECORD:C51([CampagneParticipations:17])
		End for 
		  //ASAPActualiseTbParticipation (CampagneMars;"NumBonCommandePoudre";VarNumBdC)
		  //ASAPActualiseTbParticipation (CampagneOctobre;"NumBonCommandePoudre";VarNumBdC)
		
		ZAmnistiePartielle (->[CampagneParticipations:17])
End case 
