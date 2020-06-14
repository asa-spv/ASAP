

  // ----------------------------------------------------
  // Nom utilisateur (OS) : cgm
  // Date et heure : 12/02/14, 15:26:49
  // ----------------------------------------------------
  // Méthode : DlgPrincipal.BouCourVersGauche
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

If (Macintosh command down:C546)
	CONFIRM:C162("Voulez-vous VRAIMENT déplacer vers la gauche TOUS le laboratoires ???")
	If (OK=0)
		ALERT:C41("Bon, alors je ne fais rien...")
	Else 
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=<>PUMCampagne{<>PUMCampagne})
		APPLY TO SELECTION:C70([CampagneParticipations:17];RapRemetCourrielsAGauche )
		RapInitTbRecupRapports (True:C214)
	End if 
Else 
	RapChangeColonne (->TbRapMailEnvoi)
End if 



