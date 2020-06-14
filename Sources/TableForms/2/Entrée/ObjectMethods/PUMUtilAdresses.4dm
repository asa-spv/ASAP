
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		  // enregistrement des éventuelles modifications
		SAVE RECORD:C53([XLocalisations:8])
		
		  // Recherche d'une autre [XLocalisations]
		$LocalisationCourante:=PUMUtilAdresses{PUMUtilAdresses}
		QUERY:C277([XLocalisations:8];[XLocalisations:8]TypeLocalisation:15=$LocalisationCourante;*)
		QUERY:C277([XLocalisations:8]; & [XLocalisations:8]UUIDUtilisateur:2=[XUtilisateurs:2]UUID:1)
		If (Records in selection:C76([XLocalisations:8])=0)
			CREATE RECORD:C68([XLocalisations:8])
			[XLocalisations:8]UUIDUtilisateur:2:=[XUtilisateurs:2]UUID:1
			[XLocalisations:8]TypeLocalisation:15:=$LocalisationCourante
		End if 
		
End case 
