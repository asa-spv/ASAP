//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 05/12/16, 10:51:57
  // ----------------------------------------------------
  // Méthode : RaemaGenereNumSerie
  // Description
  // Génération des numéros d'chantillons d'une série
  //
  // Paramètres : $1= $SerieMin $2=$SerieMax $3=rang
  // ----------------------------------------------------
$SerieMin:=2*($1-1)
$SerieMax:=$SerieMin+1
$Rang:=$2
ARRAY TEXT:C222($tbSerieEnCours;0)
For ($Salé;1;450)
	Repeat 
		  // Avant le rang
		$MaxAvantN:=Num:C11("9"*($Rang-1))
		$MinAvantN:=10^($Rang-2)
		$AvantA:=String:C10(ZBaseNombreHasardEncadré ($MinAvantN;$MaxAvantN))
		  // Le rang
		$ChiffreRangA:=String:C10(ZBaseNombreHasardEncadré ($SerieMin;$SerieMax))
		  // Après le rang
		$MaxApresN:=Num:C11("9"*(6-$Rang))
		$MinApresN:=0
		$Format:="0"*(6-$Rang)
		$ApresA:=String:C10(ZBaseNombreHasardEncadré ($MinApresN;$MaxApresN);$Format)
		$NumPropose:=$AvantA+$ChiffreRangA+$ApresA
		$L:=Find in array:C230(TbNumEchRaema;$NumPropose)
		CompteurHesitation:=CompteurHesitation+Num:C11($L>0)
	Until ($L=-1)
	APPEND TO ARRAY:C911(TbNumEchRaema;$NumPropose)
	APPEND TO ARRAY:C911($tbSerieEnCours;$NumPropose)
End for 
$NomFichier:="Série "+String:C10($1)+" du RAEMA "+TbNR{TbNR}+".doc"
$ContenuFichier:=ZTableauVersTexte (->$tbSerieEnCours)
$CDPJ:=Get 4D folder:C485(Dossier base:K5:14)+"Dossier PJ"+<>ZSéparateur+$NomFichier
If (Test path name:C476($CDPJ)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CDPJ)
End if 
$Doc:=Create document:C266($CDPJ)
SEND PACKET:C103($Doc;$ContenuFichier)
CLOSE DOCUMENT:C267($Doc)

  //CHERCHER([XData];[XData]XNom="Données courriel";*)
  //CHERCHER([XData]; & [XData]XType="MWb")
  //$Sujet:="Liste des numéros d'échantillons pour la série n°"+Chaîne($1)+" du RAEMA n°"+TbNR{TbNR}
  //$Corps:=$Sujet+<>ZCR+"--"+<>ZCR+"Le serveur Web"
  //TABLEAU TEXTE($TbMailCopie;0)  // A actualiser si nécessaire  (saisieraema@orange.fr ?)
  //  // $OK:=EnvoiMailDiscretVintage ([XData]XObjet.NomFAM.ServeurEnvoi;[XData]XObjet.NomFAM.AdresseEnvoi;$Corps;"cegeheme@wanadoo.fr";->$TbMailCopie;$Sujet;$CDPJ)
  //// $OK:=EnvoiMailDiscretVintage ([XData]XObjet.NomFAM.ServeurEnvoi;[XData]XObjet.NomFAM.AdresseEnvoi;$Corps;"asa-spv@wanadoo.fr";->$TbMailCopie;$Sujet;$CDPJ)
  //  // Envoi du message récapitulatif
  //$transporter:=ASAPCreationtransporter  
  //$Sujet:="Liste des numéros d'échantillons pour la série n°"+Chaîne($1)+" du RAEMA n°"+TbNR{TbNR}
  //$Destinataire:=(Num($Test)*"cegeheme@wanadoo.fr")+(Num($Test=Faux)*"asa-spv@wanadoo.fr")
  //$email:=Créer objet
  //$email.subject:=$Sujet
  //$email.from:=$transporter.user
  //$email.to:="cegeheme@wanadoo.fr"
  //$email.textBody:=$Sujet+<>ZCR+"--"+<>ZCR+"Le serveur Web"

  //$status:=$transporter.send($email)
  //Si ($status.success)  // L'envoi a été effectué
  //ALERTE("Les mails contenant les numéros d'échantillon de la campagne "+TbNR{TbNR}+" ont été envoyés avec succès")
  //Sinon 
  //ALERTE("Les mails contenant les numéros d'échantillon de la campagne "+TbNR{TbNR}+" n'ont pas été envoyés avec succès")
  //Fin de si 