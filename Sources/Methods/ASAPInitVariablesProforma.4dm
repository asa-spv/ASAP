//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 17/08/19, 19:26:34
  // ----------------------------------------------------
  // Méthode : ASAPInitVariablesProforma
  // Description
  //   Méthode qui initialise avant édition 
  //   les variables utiles aux factures proforma
  // ----------------------------------------------------
$evt:=Form event code:C388
Case of 
	: ($evt=Sur impression corps:K2:18)
		$NomContact:=OB Get:C1224([Personnes:12]Arguments:7;"NomContact";Est un texte:K8:3)
		$VarPhoneF:=OB Get:C1224([Personnes:12]Arguments:7;"PhonePro";Est un texte:K8:3)
		VarNomTel:=$NomContact+<>ZCR+$VarPhoneF
		RELATE MANY:C262([Personnes:12]UUID:1)
		$Adr:=""
		If ([PersonnesAdresses:11]LigneAdresse1:3#"")
			$Adr:=$Adr+[PersonnesAdresses:11]LigneAdresse1:3+<>ZCR
		End if 
		If ([PersonnesAdresses:11]LigneAdresse2:4#"")
			$Adr:=$Adr+[PersonnesAdresses:11]LigneAdresse2:4+<>ZCR
		End if 
		If ([PersonnesAdresses:11]LigneAdresse3:5#"")
			$Adr:=$Adr+[PersonnesAdresses:11]LigneAdresse3:5+<>ZCR
		End if 
		If ([PersonnesAdresses:11]CodePostal:6#"")
			$Adr:=$Adr+[PersonnesAdresses:11]CodePostal:6+" - "+[PersonnesAdresses:11]Ville:7
		End if 
		If ([PersonnesAdresses:11]Pays:8#"") & ([PersonnesAdresses:11]Pays:8#"France")
			$Adr:=$Adr+<>ZCR+[PersonnesAdresses:11]Pays:8
		End if 
		VarAdresse:=$Adr
		VarEORI:=OB Get:C1224([Personnes:12]Arguments:7;"EORI";Est un texte:K8:3)
		
		$Description:=OBJECT Get title:C1068(*;"Texte6")
		$Transporteur:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"Transporteur";Est un texte:K8:3)
		If ($Transporteur="SIFA")
			$Description:=Replace string:C233($Description;"EEE";"FRANCE";*)
		End if 
		OBJECT SET TITLE:C194(*;"Texte6";$Description)
		
End case 