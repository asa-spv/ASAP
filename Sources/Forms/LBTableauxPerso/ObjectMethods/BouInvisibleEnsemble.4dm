
If (GestionTableau)
	CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
End if 
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)  // Utile en cas de gestion de liste pour  Ajouter à sélection
$Menu:="Afficher les caducs;Mars;Octobre;RAEMA de l’année;RAEMA Gel n-1;Colis sup n-1;Boite isotherme n-1;Pas inscrit RAEMA Gel"
$VarChoixUtilisateur:=Pop up menu:C542($Menu)
$OC:=True:C214
Case of 
	: ($VarChoixUtilisateur=1)  // Afficher les caducs
		QUERY:C277([Personnes:12];[Personnes:12]Caduc:8=True:C214;*)
		QUERY:C277([Personnes:12]; & [Personnes:12]TypePersonne:5="laboratoire")
		ASAPPerFabriqueTb (True:C214)
		
	: ($VarChoixUtilisateur=2)  // Mars
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);1)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMars)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		ASAPPerFabriqueTb 
		
	: ($VarChoixUtilisateur=3)  // Octobre
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);3)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		ASAPPerFabriqueTb 
		
	: ($VarChoixUtilisateur=4)  // RAEMA de l’année
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);1)
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);3)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMars;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		ASAPPerFabriqueTb 
		
	: ($VarChoixUtilisateur=5)  // Inscrit au RAEMA Gel en année n-1
		$AnnéeDernière:=(Year of:C25(Current date:C33)-1)
		$Année:=Num:C11(Request:C163("A quelle année voulez-vous comparer la liste de cette année ?";String:C10($AnnéeDernière)))
		$NumRaemaMaiAvant:=RaemaTrouveNumCampagneParAn ($Année;2)
		$NumRaemaDécembreAvant:=RaemaTrouveNumCampagneParAn ($Année;4)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMaiAvant;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembreAvant)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"AnnéeDernière")
		$NumRaemaMaiMaintenant:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);2)
		$NumRaemaDécembreMaintenant:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);4)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMaiMaintenant;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembreMaintenant)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"AnnéeEnCours")
		DIFFERENCE:C122("AnnéeDernière";"AnnéeEnCours";"NonInscrit")
		USE SET:C118("NonInscrit")
		ASAPPerFabriqueTb 
		
	: ($VarChoixUtilisateur=6)  // Colis sup en année n-1
		$AnnéeDernière:=(Year of:C25(Current date:C33)-1)
		$Année:=Num:C11(Request:C163("A quelle année voulez-vous comparer la liste de cette année ?";String:C10($AnnéeDernière)))
		$NumRaemaMarsAvant:=RaemaTrouveNumCampagneParAn ($Année;1)
		$NumRaemaOctobreAvant:=RaemaTrouveNumCampagneParAn ($Année;3)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAvant;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAvant)
		QUERY SELECTION BY ATTRIBUTE:C1424([CampagneParticipations:17];[CampagneParticipations:17]Arguments:5;"NbreColisSupSansRapport";#;Null:C1517;*)
		QUERY SELECTION BY ATTRIBUTE:C1424([CampagneParticipations:17]; | ;[CampagneParticipations:17]Arguments:5;"NbreColisSupAvecRapport";#;Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"AnnéeDernière")
		$NumRaemaMarsAprès:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);1)
		$NumRaemaOctobreAprès:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);3)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAprès;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAprès)
		QUERY SELECTION BY ATTRIBUTE:C1424([CampagneParticipations:17];[CampagneParticipations:17]Arguments:5;"NbreColisSupSansRapport";#;Null:C1517;*)
		QUERY SELECTION BY ATTRIBUTE:C1424([CampagneParticipations:17]; | ;[CampagneParticipations:17]Arguments:5;"NbreColisSupAvecRapport";#;Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"AnnéeEnCours")
		DIFFERENCE:C122("AnnéeDernière";"AnnéeEnCours";"SansColis")
		USE SET:C118("SansColis")
		ASAPPerFabriqueTb 
		
	: ($VarChoixUtilisateur=7)  // Boite isotherme en année n-1
		$AnnéeDernière:=(Year of:C25(Current date:C33)-1)
		$Année:=Num:C11(Request:C163("A quelle année voulez-vous comparer la liste de cette année ?";String:C10($AnnéeDernière)))
		$NumRaemaMarsAvant:=RaemaTrouveNumCampagneParAn ($Année;1)
		$NumRaemaOctobreAvant:=RaemaTrouveNumCampagneParAn ($Année;3)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAvant;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAvant)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"BoîteIsotherme";#;Null:C1517)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"AnnéeDernière")
		$NumRaemaMarsAprès:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);1)
		$NumRaemaOctobreAprès:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);3)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMarsAprès;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobreAprès)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];[CampagneParticipations:17]Arguments:5;"BoîteIsotherme";#;Null:C1517;*)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"AnnéeEnCours")
		DIFFERENCE:C122("AnnéeDernière";"AnnéeEnCours";"SansColis")
		USE SET:C118("SansColis")
		ASAPPerFabriqueTb 
		
	: ($VarChoixUtilisateur=8)  // Pas inscrit au RAEMA Gel
		$NumRaemaMars:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);1)
		$NumRaemaOctobre:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);3)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMars;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaOctobre)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"RAEMAPoudre")
		$NumRaemaMaiMaintenant:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);2)
		$NumRaemaDécembreMaintenant:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33);4)
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumRaemaMaiMaintenant;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=$NumRaemaDécembreMaintenant)
		RELATE ONE SELECTION:C349([CampagneParticipations:17];[Personnes:12])
		CREATE SET:C116([Personnes:12];"RAEMAGel")
		DIFFERENCE:C122("RAEMAPoudre";"RAEMAGel";"NonInscritGel")
		USE SET:C118("NonInscritGel")
		ASAPPerFabriqueTb 
		
	Else 
		$OC:=False:C215
End case 

If ($OC)
	
	
	If (GestionTableau)
		CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
	End if 
	
	
	LISTBOX SELECT ROW:C912(*;"Lb_Tableaux";0;lk supprimer de sélection:K53:3)
	ZNbEnr:=Size of array:C274(TbPerNum)
	ZFenetreActualiseTitre 
End if 