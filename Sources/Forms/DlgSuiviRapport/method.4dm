$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		C_TEXT:C284(VarTexteCourriel;VarTexteCourriel2)
		RapInitTbRecupRapports 
		$VarNumCampagne:=<>PUMCampagne{<>PUMCampagne}
		<>PUMCampagne:=Find in array:C230(<>PUMCampagne;<>NumCampagneEnCoursRecup)
		VarRAEMAEnCours:="RAEMA n°"+<>PUMCampagne{<>PUMCampagne}
		VarRAEMAEcart:=""
		  //$NomEnrRaema:="Raema n°"+<>PUMCampagne{<>PUMCampagne}
		  //CHERCHER([XData];[XData]XNom=$NomEnrRaema;*)
		  //CHERCHER([XData]; & [XData]XType="Rae")
		  //$VarDateDebCamp:=[XData]XDateSup
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$VarNumCampagne)
		$VarDateDebCamp:=[RAEMACampagnes:20]DateEnvoiColis:3
		If ($VarDateDebCamp>(Current date:C33-30))
			VarRAEMAEcart:="Je m'étonne qu'on veuille envoyer les mails de récupération des rapports de campagne du RAEMA "
			VarRAEMAEcart:=VarRAEMAEcart+<>PUMCampagne{<>PUMCampagne}+" moins d'un mois après le lancement de la campagne !!???"
		End if 
		
		
		SET TIMER:C645(60*60*5)  // toutes les 5 mn
		
		
	: (Form event code:C388=Sur minuteur:K2:25)
		RapActualisePriseRapport 
		
		
	: ($evt=Sur libération:K2:2)
		READ WRITE:C146([XData:1])
		QUERY:C277([XData:1];[XData:1]XNom:2="Texte du courriel";*)
		QUERY:C277([XData:1]; & [XData:1]XType:3="Rap")
		[XData:1]XTexte:9:=VarTexteCourriel
		[XData:1]XTexteSup:10:=VarObjetCourriel
		SAVE RECORD:C53([XData:1])
		
		QUERY:C277([XData:1];[XData:1]XNom:2="Texte du courriel2";*)
		QUERY:C277([XData:1]; & [XData:1]XType:3="Rap")
		[XData:1]XTexte:9:=VarTexteCourriel2
		[XData:1]XTexteSup:10:=VarObjetCourriel2
		SAVE RECORD:C53([XData:1])
		ZAmnistiePartielle (->[XData:1])
End case 
