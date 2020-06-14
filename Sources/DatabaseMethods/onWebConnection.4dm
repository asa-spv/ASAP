C_TEXT:C284($1;$2;$3;$4;$5;$6;NavigateurLabo)
ON ERR CALL:C155("aaaErreur")
NavigateurLabo:=$2
  // RaemaQuelNavigateur ($2)
ZAmnistieInternationale 
IP:=$3
$Mess:=$1

If (Macintosh command down:C546)
	TRACE:C157
End if 

If ($Mess="/@")
	$Mess:=Substring:C12($Mess;2)
End if 

NumCampagneEnCoursInfoOK:=<>NumCampagneEnCoursInfoOK
Case of 
		
	: ($Mess="raemadate")  // Demande de la date de début de campagne
		$L:=Find in array:C230(<>TbCampagnesNumCampagne;<>NumCampagneEnCoursSaisie)
		$Envoi:=String:C10(<>TbCampagnesDateEnvoiColis{$L})
		WEB SEND TEXT:C677($Envoi)
		
	: ($Mess="FileLeTbDeDilution@")  // contrôle de la dilution
		ResControleDil ($Mess)
		
	: ($Mess="ControleEch@")  // contrôle de l'existence des numéros échantillons
		ResControleEch ($Mess)
		
	: ($Mess="ControleSer@")  // contrôle de la compatibilité des séries des numéros échantillons
		ResControleSer ($Mess)
		
	: ($Mess="flipflop@")  // traitement de l'apparition / disparition des champs
		  // ainsi que (CdC R63) de l'affectation des milieux et fabricants f(méthode) 
		ResFlipFlop ($Mess)
		
	: ($Mess="/") | ($Mess="index.shtml")
		WEB SEND FILE:C619("index.shtml")
		
	: ($Mess="w2@")
		$NomFichier:=Substring:C12($Mess;3)
		WEB SEND FILE:C619($NomFichier)
		
	: ($Mess="mw2@")
		$NomMéthode:=Substring:C12($Mess;4)
		EXECUTE METHOD:C1007($NomMéthode)
		
	: ($Mess="WebDevisRecevoir@")
		$UUID:=Substring:C12($Mess;17)
		$Res:=0
		EXECUTE METHOD:C1007("WebDevisRecevoir";$Res;$UUID)
		
	: ($Mess="EC_@")  //  Appel de l'espace client
		WebAppelEspaceClient ($Mess)
		
	: ($Mess="DevisGel@")
		$UUID:=Substring:C12($Mess;9)
		WebDevisEcritPage ($UUID)
		
	: ($Mess="espaceclient@")  //  Appel de l'espace client
		$Langue:=$Mess[[13]]
		$UUID:=Substring:C12($Mess;14)
		WEB SEND TEXT:C677(WebEcritHTMLEspaceClient ($UUID;$Langue))
		
	: ($Mess="DonneesPersonnelles@")  //  Appel des données personnels dans l'espace client
		$Langue:=$Mess[[20]]
		$LigneTbGnx:=Substring:C12($Mess;53)
		$UUID:=Substring:C12($Mess;21)
		WebDonneesPersonnellesClient ($Mess;$Langue;$UUID;$LigneTbGnx)
		
	: ($Mess="téléchargement@")  //  Appel de l'EC depuis le tableau de droite
		WebTelechargeEspaceClientASAP ($Mess)
		
		
	: ($Mess="PGtéléchargements@")  //  Appel de l'EC depuis la partie gauche
		WebProposeLesDocDispo ($Mess)
		
	: ($Mess="RapP2MF@")
		TypeDemande:=Substring:C12($Mess;8)
		EXECUTE METHOD:C1007("RapP2MF")
		
	: ($Mess="RechercheLesTheses")
		  // WebTrouveLesThèses
		
	: ($Mess="asacontact@")
		WebAsaContact ($Mess)
		
	: ($Mess="EnregistreAsa")
		  // AsaDia2WebEnregistre
		
		
	: ($Mess="@VerifAdherent@")
		  // Web_VerifMdp
		
	: ($Mess="@Formulaire@")
		  // Web_RecupFormulaire
		
	: ($Mess="@ConfirmerMdP@")
		  // Web_ConfirmeMdp
		
	: ($Mess="MettreIciLa chaineAJAX")
		ResAjaxDate 
		
	: ($Mess="pdf/Rapports/@")  // Téléchargement sur page complète
		RapAjax ($Mess)
		
	: ($Mess="breve@")
		  //  WebVisuBreve($Mess)
		
	: ($Mess="rep@")  // Réponse du quizz
		  //  WebReponseQuizz($Mess)
		
	: ($Mess="devisid@")  // Devis identification
		WebDevisIdentification ($Mess)
		
	: ($Mess="calculedevis@")  //  calcul du devis
		WebDevisCalcul ($Mess)
		
	: (NavigateurLabo="put / http@")
		WEB SEND TEXT:C677("présent")
		
	Else 
		
		WEB SEND FILE:C619("oups.shtml")
		
End case 

ON ERR CALL:C155("")
ZAmnistieInternationale 