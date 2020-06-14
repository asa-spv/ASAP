$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		OB SET:C1220([Personnes:12]Arguments:7;"Prénom";VarPrénom)
		  // TbPerNom{TbPerNom}:=[Personnes]NomLong+" "+VarPrénom
		VarAnnonceAdh:=VarPrénom+" "+[Personnes:12]NomLong:2
		SET WINDOW TITLE:C213(VarAnnonceAdh)
End case 