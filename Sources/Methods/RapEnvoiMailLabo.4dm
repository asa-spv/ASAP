//%attributes = {}
  // RapEnvoiMailLabo
C_DATE:C307($VarDateDebCamp)
$OC:=True:C214
$NumCampagne:=<>PUMCampagne{<>PUMCampagne}
$L:=Find in array:C230(<>TbCampagnesNumCampagne;$NumCampagne)
$VarDateDebCamp:=<>TbCampagnesDateLimiteReponse{$L}
If ($VarDateDebCamp>(Current date:C33-30))
	$Mess:="Je m'étonne qu'on envoie les mails de récupération des rapports du RAEMA "
	$Mess:=$Mess+$NumCampagne+" moins d'un mois après le lancement de la campagne !!???"
	ALERT:C41($Mess)
	CONFIRM:C162("Voulez-vous VRAIMENT lancer les mails de récupération des rapports du RAEMA "+$NumCampagne)
	$OC:=(OK=1)
End if 

If (Length:C16(VarTexteCourriel)<600)
	ALERT:C41("Le texte du mail "+<>ZGuil+"Laboratoire OK"+<>ZGuil+" est incomplet.")
	$OC:=False:C215
End if 

If ($OC)
	RapEnvoyerLesMails 
End if 