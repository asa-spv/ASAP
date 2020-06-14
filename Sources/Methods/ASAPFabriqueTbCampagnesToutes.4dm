//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/08/18, 08:19:08
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbCampagnesToutes
  // Description
  // // fabrique le tableau de toutes les campagnes du RAEMA

$MCE:=Macintosh command down:C546

$NomMéthodeCourante:=Current method name:C684
$NomMéthodeMAJ:=$NomMéthodeCourante+"MAJ"
If (<>ZClient) & (Count parameters:C259=0)
	$Prc:=Execute on server:C373($NomMéthodeCourante;0)
Else 
	ASAPInitTbGenerauxCampagnes 
	ALL RECORDS:C47([RAEMACampagnes:20])
	SELECTION TO ARRAY:C260([RAEMACampagnes:20]DateEnvoiColis:3;<>TbCampagnesDateEnvoiColis\
		;[RAEMACampagnes:20]DateLimiteReponse:4;<>TbCampagnesDateLimiteReponse\
		;[RAEMACampagnes:20]DateMiseEnLigne:5;<>TbCampagnesDateMiseEnLigne\
		;[RAEMACampagnes:20]NbParticipants:6;<>TbCampagnesNbParticipants\
		;[RAEMACampagnes:20]NumCampagne:2;<>TbCampagnesNumCampagne\
		;[RAEMACampagnes:20]UUID:1;<>TbCampagnesUUID\
		;[RAEMACampagnes:20]Arguments:7;<>TbCampagnesArguments)
	LONGINT ARRAY FROM SELECTION:C647([RAEMACampagnes:20];<>TbNumEnrRaemaCampagne)
	  // Ajout du contenu du champ [RAEMACampagnes]Arguments
	  // Rang
	  // N° des échantillons
	  // TbF
	  // TbA
	  // Niveaux de contamination
	  // Sous accréditation
	  // Disponibilité du rapport individuel
	  // NbreLignePJ
	
	$FT:=Size of array:C274(<>TbCampagnesArguments)
	ARRAY LONGINT:C221(<>TbCampagnesRang;$FT)
	ARRAY LONGINT:C221(<>TbCampagnesNbGermes;$FT)
	ARRAY TEXT:C222(<>TbCampagnesNumEchEnvoi;$FT)
	ARRAY TEXT:C222(<>TbCampagnesContamination;$FT)
	For ($Salé;1;$FT)
		<>TbCampagnesRang{$Salé}:=OB Get:C1224(<>TbCampagnesArguments{$Salé};"Rang";Est un numérique:K8:4)
		<>TbCampagnesNumEchEnvoi{$Salé}:=OB Get:C1224(<>TbCampagnesArguments{$Salé};"N° des échantillons";Est un texte:K8:3)
		<>TbCampagnesContamination{$Salé}:=OB Get:C1224(<>TbCampagnesArguments{$Salé};"Niveaux de contamination";Est un texte:K8:3)
		QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]UUIDCampagne:2=<>TbCampagnesUUID{$Salé})
		<>TbCampagnesNbGermes{$Salé}:=Records in selection:C76([RAEMAGermes:21])-1  // -1 pour tenir compte du premier chapitre CONDITIONS GENERALESqui n'est pas un germe 
	End for 
	
	SORT ARRAY:C229(<>TbCampagnesNumCampagne;<>TbCampagnesDateEnvoiColis;<>TbCampagnesDateLimiteReponse;<>TbCampagnesDateMiseEnLigne\
		;<>TbCampagnesNbParticipants;<>TbCampagnesUUID;<>TbCampagnesRang;<>TbCampagnesNbGermes;<>TbCampagnesNumEchEnvoi\
		;<>TbCampagnesContamination;<>TbCampagnesArguments;>)
	
	
	If ($MCE)  // Il demande à mettre le tableau dans le PP
		
		$ET:="<>TbCampagnesNumCampagne"+<>ZTab+"<>TbCampagnesDateEnvoiColis"+<>ZTab+"<>TbCampagnesDateLimiteReponse"+<>ZTab+"<>TbCampagnesDateMiseEnLigne"
		$ET:=$ET+<>ZTab+"<>TbCampagnesNbParticipants"+<>ZTab+"<>TbCampagnesRang"+<>ZTab+"<>TbCampagnesNbGermes"+<>ZTab+"<>TbCampagnesUUID"+<>ZCR
		$ET:=$ET+"N° campagne"+<>ZTab+"Date de début"+<>ZTab+"Date limite de réponse"+<>ZTab+"Date de mise en ligne"
		$ET:=$ET+<>ZTab+"Nb Participants"+<>ZTab+"Rang"+<>ZTab+"Nb Germes"+<>ZTab+"UUIDCampagne"+<>ZCR
		  // La campagne
		ARRAY TEXT:C222($TbNumCampagne;$FT)
		ARRAY TEXT:C222($TbDateDebut;$FT)
		ARRAY TEXT:C222($TbDateLimite;$FT)
		ARRAY TEXT:C222($TbDateMiseEnLigne;$FT)
		ARRAY TEXT:C222($TbNbParticipants;$FT)
		ARRAY TEXT:C222($TbRang;$FT)
		ARRAY TEXT:C222($TbNbGermes;$FT)
		ARRAY TEXT:C222($TbUUID;$FT)
		$Rapport:=$ET
		For ($Salé;1;$FT)
			$DateMiseEnLigne:=(Num:C11(<>TbCampagnesDateMiseEnLigne{$Salé}=!00-00-00!)*"-")\
				+(Num:C11(<>TbCampagnesDateMiseEnLigne{$Salé}#!00-00-00!)*String:C10(<>TbCampagnesDateMiseEnLigne{$Salé}))
			$NbParticipants:=(Num:C11(<>TbCampagnesNbParticipants{$Salé}=0)*"-")\
				+(Num:C11(<>TbCampagnesNbParticipants{$Salé}#0)*String:C10(<>TbCampagnesNbParticipants{$Salé}))
			$Rang:=(Num:C11(<>TbCampagnesRang{$Salé}=0)*"-")\
				+(Num:C11(<>TbCampagnesRang{$Salé}#0)*String:C10(<>TbCampagnesRang{$Salé}))
			
			$Rapport:=$Rapport+<>TbCampagnesNumCampagne{$Salé}+<>ZTab+String:C10(<>TbCampagnesDateEnvoiColis{$Salé})+<>ZTab
			$Rapport:=$Rapport+String:C10(<>TbCampagnesDateLimiteReponse{$Salé})+<>ZTab+$DateMiseEnLigne+<>ZTab
			$Rapport:=$Rapport+$NbParticipants+<>ZTab+$Rang+<>ZTab
			$Rapport:=$Rapport+String:C10(<>TbCampagnesNbGermes{$Salé})+<>ZTab+<>TbCampagnesUUID{$Salé}+<>ZCR
		End for 
		  // FIXER TEXTE DANS CONTENEUR($Rapport)
	End if 
	If (Application type:C494=4D Server:K5:6)
		EXECUTE ON CLIENT:C651("@";"ASAPFabriqueTbCampagneToutesMAJ")
	End if 
End if 