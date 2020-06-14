
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/02/16, 07:51:13
  // ----------------------------------------------------
  // Méthode : DlgPrincipal.BouEnleveParticipation
  // Description
  // BouEnleveParticipation de l'écran de gestion des rapports de "DlgPrincipal"
  // Enlève la participation d'un laboratoire qui a répondu
  // ----------------------------------------------------

$MCE:=Macintosh command down:C546
$NumRaemaActuel:=<>PUMCampagne{<>PUMCampagne}
If (TbRapMailNonEnvoi>0)
	$Lab:=String:C10(TbRapMailNonEnvoi{TbRapMailNonEnvoi})
	If (Not:C34($MCE))
		$mess:="Enlever le laboratoire n°"+$Lab+" de la liste???"
		CONFIRM:C162($mess)
	Else 
		OK:=1
	End if 
	If (OK=1)
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=$Lab;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$NumRaemaActuel)
		If ([CampagneParticipations:17]TexteParticipation:4="@analyses et envoi du mail@")
			ALERT:C41("Le laboratoire n°"+$Lab+" ne peut être enlevé de la liste car il a envoyé ses résultats")
		Else 
			OB SET:C1220([CampagneParticipations:17]Arguments:5;"ParticipeKO";True:C214)
			SAVE RECORD:C53([CampagneParticipations:17])
			RapInitTbRecupRapports (True:C214)
			WebHistoireConnexion ($Lab;12;False:C215;$NumRaemaActuel)
		End if 
	End if 
Else 
	ALERT:C41("Désignez un laboratoire dans la colonne des courriels "+"non obtenus")
End if 