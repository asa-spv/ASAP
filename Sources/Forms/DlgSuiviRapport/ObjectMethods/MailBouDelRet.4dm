
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/02/16, 07:52:56
  // ----------------------------------------------------
  // Méthode : DlgPrincipal.BouDelRet
  // Description
  // MO de BouAjouteParticipation de l'écran de gestion des rapports de "DlgPrincipal"
  //  Ajoute un laboratoire à la campagne courante (<>PUMCampagne{<>PUMCampagne})
  // Paramètres
  // ----------------------------------------------------
  // 
If (TbRapportsRetenus>0)
	$Dem:=TbRapportsRetenus{TbRapportsRetenus}
	$mess:="Enlever le laboratoire n°"+String:C10($Dem)+" à la liste???"
	CONFIRM:C162($mess)
	If (OK=1)
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=String:C10($dem);*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=<>PUMCampagne{<>PUMCampagne})
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"ParticipeKO";True:C214)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"HorsWeb";False:C215)
		
		
		SAVE RECORD:C53([CampagneParticipations:17])
		DELETE FROM ARRAY:C228(TbRapportsRetenus;TbRapportsRetenus)
	End if 
Else 
	ALERT:C41("Désignez le laboratoire à enlever des retenus")
End if 