//%attributes = {}
  //  RapEnvoyerLesMails
  // MO du bouton d'envoi des mails de "DlgRapEnvoiMail"

C_LONGINT:C283($Salé;$FT;$L)
C_TEXT:C284($VarTexteCourriel)
$VarTexteCourriel:=VarTexteCourriel
$Visible:=(Count parameters:C259=0)
If ($Visible)  // Envoi en première intention : on boucle sur les tableaux <>ZoneRapNonEnvMail et <>ZoneRapLabRetenus
	ZFenetreModaleAuCentre (500;60)
	ChercheDonneesCourielSortant 
	ARRAY TEXT:C222(TbNLOK;0)
	ARRAY TEXT:C222(TbNLKO;0)
	ARRAY TEXT:C222(TbMailCopie;0)
	$NumCampagne:=<>PUMCampagne{<>PUMCampagne}
	
	$FT:=Size of array:C274(TbRapMailNonEnvoi)
	If ($FT>0)  // laboratoires à informer de la disponibilité de leur rapport
		$Dispo:=<>ZCR2+"Envois des mails de disponibilité"
		APPEND TO ARRAY:C911(TbNLOK;$Dispo)
		APPEND TO ARRAY:C911(TbNLKO;$Dispo)
		For ($Salé;1;$FT)
			$NumLaboA:=String:C10(TbRapMailNonEnvoi{$Salé})
			$Mess:=<>ZCR2+"   Envoi du courriel de disponibilité au labo n°"+$NumLaboA+" pour la campagne n°"+$NumCampagne+<>ZCR2
			MESSAGE:C88($Mess)
			$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumLaboA)
			If ($l>0)
				$Email:=<>TbPAEmailRAEMA{$L}
				$Envoi:=False:C215
				If ($Email#"")
					If (Length:C16($VarTexteCourriel)<600)
						$Mess:="l'envoi concerne le laboratoire de rang "+String:C10($Salé)+" et les laboratoires suivants n'ont pas reçu le mail."
						ALERT:C41("Le texte du mail "+<>ZGuil+"Laboratoire OK"+<>ZGuil+" est incomplet : "+$Mess)
						$Salé:=$FT  // Fin de la boucle
					Else 
						$Envoi:=EnvoiMailDiscretVintage (VarServeurSMTP;VarExpéditeur;$VarTexteCourriel;$Email;->TbMailCopie;VarObjetCourriel)
						If ($Envoi)
							WebHistoireConnexion ($NumLaboA;7;True:C214;$NumCampagne)
							APPEND TO ARRAY:C911(TbNLOK;$NumLaboA)
							$UUIDLabo:=<>TbPerUUID{$L}
							READ WRITE:C146([CampagneParticipations:17])
							QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
							QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=$UUIDLabo)
							OB SET:C1220([CampagneParticipations:17]Arguments:5;"MailDisponibilitéEnvoyé";True:C214)
							OB SET:C1220([CampagneParticipations:17]Arguments:5;"DateMailDisponibilité";Current date:C33)
							SAVE RECORD:C53([CampagneParticipations:17])
						Else 
							WebHistoireConnexion ($NumLaboA;7;False:C215;$NumCampagne)
							APPEND TO ARRAY:C911(TbNLKO;$NumLaboA)
						End if 
					End if 
				End if 
			End if 
			DELAY PROCESS:C323(Current process:C322;100)
		End for 
		ZAmnistiePartielle (->[CampagneParticipations:17])
	End if 
	
	$FT:=Size of array:C274(TbRapportsRetenus)
	If ($FT>0)  // laboratoires à informer de la rétention de leur rapport
		$Retention:=<>ZCR2+"Envois des mails de rétention"
		APPEND TO ARRAY:C911(TbNLOK;$Retention)
		APPEND TO ARRAY:C911(TbNLKO;$Retention)
		For ($Salé;1;$FT)
			$NumLaboA:=String:C10(TbRapportsRetenus{$Salé})
			$Mess:=<>ZCR2+"   Envoi du courriel de rétention au labo n°"+$NumLaboA+" pour la campagne n°"+$NumCampagne+<>ZCR2
			MESSAGE:C88($Mess)
			$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumLaboA)
			If ($l>0)
				$Email:=<>TbPAEmailRAEMA{$L}
				$Envoi:=False:C215
				If ($Email#"")
					$Envoi:=EnvoiMailDiscretVintage (VarServeurSMTP;VarExpéditeur;VarTexteCourriel2;$Email;->TbMailCopie;VarObjetCourriel2)
				End if 
				If ($Envoi)
					WebHistoireConnexion ($NumLaboA;7;True:C214;$NumCampagne)
					APPEND TO ARRAY:C911(TbNLOK;$NumLaboA)
					QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
					QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=$UUIDLabo)
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"MailDisponibilitéEnvoyé";True:C214)
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"DateMailDisponibilité";Current date:C33)
					SAVE RECORD:C53([CampagneParticipations:17])
					
				Else 
					WebHistoireConnexion ($NumLaboA;7;False:C215;$NumCampagne)
					APPEND TO ARRAY:C911(TbNLKO;$NumLaboA)
				End if 
				DELAY PROCESS:C323(Current process:C322;100)
			End if 
		End for 
		ZAmnistiePartielle (->[CampagneParticipations:17])
		
	End if 
	
	
	CLOSE WINDOW:C154
	  // Informons l'ASA de l'étendu de l'envoi du courriel
	$TT:=Size of array:C274(TbNLKO)
	$TTT:=Size of array:C274(TbNLOK)
	$s:=Num:C11($TT>1)*"s"
	If ($TT>0)
		$Corps:="Envoi de "+String:C10($TT)+" courriel"+$s+" non réalisé : laboratoire "+ZTableauVersTexte (->TbNLKO;", ")
		If (Size of array:C274(TbNLOK)>0)
			$Corps:="Envoi de "+String:C10($TTT)+" courriel"+$s+" réalisé : laboratoire "+ZTableauVersTexte (->TbNLOK;", ")
		Else 
			$Corps:="Aucun envoi n'a été réalisé"
		End if 
	Else 
		$Corps:="Envoi de "+String:C10($TTT)+" courriel"+$s+" entièrement réalisé : laboratoire "+ZTableauVersTexte (->TbNLOK;", ")
	End if 
	$Corps:=$Corps+<>ZCR+"Le serveur Web de l'ASA"
	$Sujet:="Envoi des mails contenant le lien de téléchargement des rapports RAEMA"
	  //ChercheDonneesCourielSortant 
	  //ZBlobVersVariable (->[XData]XBlob;->TbMailCopie;->VarSignatureCourriel;->TbMailRes;->TbMailAR;->TbMailMAJC;->TbMailEnvoi;->TbMailMAJL)
	$Envoi:=EnvoiMailDiscretVintage (VarServeurSMTP;VarExpéditeur;$Corps;"asa-spv@wanadoo.fr";->TbMailEnvoi;$Sujet)
Else 
	  // Envoi invisible = relance
End if 