  //  RapChangeColonneRet
$MCE:=Macintosh command down:C546
$NumRaemaActuel:=<>PUMCampagne{<>PUMCampagne}
If (TbRapportsNonPris>0)
	$Lab:=String:C10(TbRapportsNonPris{TbRapportsNonPris})
	If (Not:C34($MCE))
		$mess:="Déplacer le laboratoire n°"+$Lab+" vers la liste des non obtenus vers les retenus "
		CONFIRM:C162($mess)
	Else 
		OK:=1
	End if 
	If (OK=1)
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=$Lab;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$NumRaemaActuel)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"RapportPris";False:C215)
		  // Il faudrait probablement supprimer le rapport du dossier
		SAVE RECORD:C53([CampagneParticipations:17])
		RapInitTbRecupRapports (True:C214)
		WebHistoireConnexion ($Lab;9;False:C215;$NumRaemaActuel)
	End if 
Else 
	ALERT:C41("Désignez un laboratoire dans la colonne des rapports SVP...")
End if 
