
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/02/16, 07:52:56
  // ----------------------------------------------------
  // Méthode : DlgPrincipal.BouAjouteParticipation
  // Description
  // MO de BouAjouteParticipation de l'écran de gestion des rapports de "DlgPrincipal"
  //  Ajoute un laboratoire à la campagne courante (<>PUMCampagne{<>PUMCampagne})
  // Paramètres
  // ----------------------------------------------------
  // 

$dem:=Num:C11(Request:C163("Quel n° ajouter à la liste ???"))
If (RapAjouteOK ($Dem))
	$mess:="Ajouter le laboratoire n°"+String:C10($Dem)+" à la liste???"
	CONFIRM:C162($mess)
	If (OK=1)
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=String:C10($dem);*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=<>PUMCampagne{<>PUMCampagne})
		If (Records in selection:C76([CampagneParticipations:17])=0)
			$Id:="Historique connexion du labo "+String:C10($dem)+" pour le RAEMA "+<>PUMCampagne{<>PUMCampagne}
			CREATE RECORD:C68([CampagneParticipations:17])
			[CampagneParticipations:17]UUIDPersonne:2:=$Id
			[CampagneParticipations:17]UUID:1:=String:C10($dem)
			[CampagneParticipations:17]NumCampagne:3:=<>PUMCampagne{<>PUMCampagne}
		Else 
			OB SET:C1220([CampagneParticipations:17]Arguments:5;"ParticipeKO";True:C214)
		End if 
		SAVE RECORD:C53([CampagneParticipations:17])
		RapInitTbRecupRapports (True:C214)
		WebHistoireConnexion (String:C10($dem);7;False:C215;<>PUMCampagne{<>PUMCampagne})
	End if 
End if 