
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		PUMUtilAdresses:=1
		READ WRITE:C146([XLocalisations:8])
		$LocalisationCourante:=PUMUtilAdresses{PUMUtilAdresses}
		QUERY:C277([XLocalisations:8];[XLocalisations:8]TypeLocalisation:15=$LocalisationCourante;*)
		QUERY:C277([XLocalisations:8]; & [XLocalisations:8]UUIDUtilisateur:2=[XUtilisateurs:2]UUID:1)
		If (Records in selection:C76([XLocalisations:8])=0)
			CREATE RECORD:C68([XLocalisations:8])
			[XLocalisations:8]UUIDUtilisateur:2:=[XUtilisateurs:2]UUID:1
			[XLocalisations:8]TypeLocalisation:15:=$LocalisationCourante
		End if 
		FORM GOTO PAGE:C247(3)
End case 
