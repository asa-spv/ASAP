$MCE:=Macintosh command down:C546
$NumRaemaActuel:=<>PUMCampagne{<>PUMCampagne}
$OC:=True:C214
If (TbRapMailNonParticipation>0)
	$Lab:=String:C10(TbRapMailNonParticipation{TbRapMailNonParticipation})
	If (Not:C34($MCE))
		$mess:="Mettre le laboratoire n°"+$Lab+" vers la droite ???"
		CONFIRM:C162($mess)
		$OC:=(OK=1)
	End if 
	If ($OC)
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=$Lab;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$NumRaemaActuel)
		If ([CampagneParticipations:17]TexteParticipation:4="@envoi du mail@")
			OB SET:C1220([CampagneParticipations:17]Arguments:5;"ParticipeKO";False:C215)
			SAVE RECORD:C53([CampagneParticipations:17])
			RapInitTbRecupRapports (True:C214)
			WebHistoireConnexion ($Lab;12;True:C214;$NumRaemaActuel)
		Else 
			ALERT:C41("Je ne peux remettre comme participant un laboratoire qui n'a pas envoyé de réponse...")
		End if 
	End if 
Else 
	ALERT:C41("Désignez un laboratoire dans la colonne des laboratoires non participants")
End if 


