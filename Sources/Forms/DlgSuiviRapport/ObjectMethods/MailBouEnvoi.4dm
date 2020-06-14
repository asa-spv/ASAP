$OC:=True:C214
If (Size of array:C274(TbRapportsRetenus)>10)
	CONFIRM:C162("Il y a plus de 10 rapports retenus : \nVoulez-vous REELLEMENT continuer ???";"Non, bien sûr";"Si, si")
	$OC:=(OK=0)
End if 
If ($OC)
	$NumCampagne:=<>PUMCampagne{<>PUMCampagne}
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
	$VarDateDebCamp:=[RAEMACampagnes:20]DateEnvoiColis:3
	If ($VarDateDebCamp>(Current date:C33-30))
		VarRAEMAEcart:="Je m'étonne qu'on veuille envoyer les mails de récupération des rapports de campa"+"gne du RAEMA "
		VarRAEMAEcart:=VarRAEMAEcart+$NumCampagne+" moins d'un mois après le lancement de la campagne !!???"
	End if 
	VarNbLaboRetenu:=Size of array:C274(TbRapportsRetenus)
	VarNbLaboMail:=Size of array:C274(TbRapMailNonEnvoi)
	
	FORM GOTO PAGE:C247(2)
End if 
