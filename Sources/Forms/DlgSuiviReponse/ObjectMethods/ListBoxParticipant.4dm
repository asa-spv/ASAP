$evt:=Form event code:C388
If ($evt=Sur nouvelle sélection:K2:29)
	  // $lc:=TbParticipantN{TbParticipantN}
	  //CHERCHER([ParticipationRAEMA];[ParticipationRAEMA]NumLaboEntier=$lc;*)
	  //CHERCHER([ParticipationRAEMA]; & [ParticipationRAEMA]NumCampagne=VarNumRaema)
	  //VarHistorique:=[ParticipationRAEMA]TexteParticipation1
	
	VarHistorique:=TbTexteParticipation{TbParticipantA}  // TbHistorique défini dans RaemaSuiviAfficheTbParticipantN
	
End if 