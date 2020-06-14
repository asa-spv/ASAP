C_LONGINT:C283($salé;$FT;$AnN;$NumN;$J1;$Rang)
C_BOOLEAN:C305($Parité;$Gel)

$CampagneActuelle:=TbNR{TbNR}
$Gel:=($CampagneActuelle="@A")
$CampagneACopierSupposée:=String:C10(Num:C11($CampagneActuelle)-2)+(Num:C11($Gel)*"A")
$CampagneACopier:=Request:C163("Quelle campagne voulez-vous copier ?";$CampagneACopierSupposée)
$TestCampagneACopier:=$CampagneACopier+"@"
$TestNouvelleCampagne:=$CampagneActuelle+"@"

  // Recrutement des enregistrements à copier
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$CampagneACopier)
$Compteur:=1

If (OK=1) & ($CampagneACopier#"")
	If (Find in array:C230(TbNR;$CampagneACopier)<0)
		ALERT:C41("Le numéro de campagne "+$CampagneACopier+" n'existe pas...")
	Else 
		ARRAY TEXT:C222($TbF;0)
		ARRAY TEXT:C222($TbA;0)
		ARRAY TEXT:C222($TbD;0)
		ARRAY TEXT:C222($TbFab;0)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbF";$TbF)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbA";$TbA)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbDilution";$TbD)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbFabricant";$TbFab)
		$Rang:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Rang";Est un entier long:K8:6)
		
		If ($Gel)
			QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$TestCampagneACopier)
		Else 
			QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$TestCampagneACopier;*)
			QUERY:C277([RAEMAGermes:21]; & [RAEMAGermes:21]Identifiant:3#($CampagneACopier+"A@"))
		End if 
		LONGINT ARRAY FROM SELECTION:C647([RAEMAGermes:21];$TbNumEnrGerme)
		$FT:=Size of array:C274($TbNumEnrGerme)
		For ($Salé;1;$FT)
			GOTO RECORD:C242([RAEMAGermes:21];$TbNumEnrGerme{$salé})
			DUPLICATE RECORD:C225([RAEMAGermes:21])
			[RAEMAGermes:21]Identifiant:3:=Replace string:C233([RAEMAGermes:21]Identifiant:3;$CampagneACopier;$CampagneActuelle)  // Actualisation de l'identifiant
			SAVE RECORD:C53([RAEMAGermes:21])
		End for 
		
		  // Duplication des [RAEMALignes]
		If ($Gel)
			QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=$TestCampagneACopier)
		Else 
			QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=$TestCampagneACopier;*)
			QUERY:C277([RAEMALignes:22]; & [RAEMALignes:22]Identifiant:3#($CampagneACopier+"A@"))
		End if 
		LONGINT ARRAY FROM SELECTION:C647([RAEMALignes:22];$TbNumEnrLigne)
		$FT:=Size of array:C274($TbNumEnrLigne)
		For ($Salé;1;$FT)
			GOTO RECORD:C242([RAEMALignes:22];$TbNumEnrLigne{$salé})
			DUPLICATE RECORD:C225([RAEMALignes:22])
			[RAEMALignes:22]Identifiant:3:=Replace string:C233([RAEMALignes:22]Identifiant:3;$CampagneACopier;$CampagneActuelle)  // Actualisation de l'identifiant
			SAVE RECORD:C53([RAEMALignes:22])
		End for 
		
		  // Duplication des [RAEMAValeurs]
		If ($Gel)
			QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$TestCampagneACopier)
		Else 
			QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$TestCampagneACopier;*)
			QUERY:C277([RAEMAValeurs:23]; & [RAEMAValeurs:23]Identifiant:3#($CampagneACopier+"A@"))
		End if 
		LONGINT ARRAY FROM SELECTION:C647([RAEMAValeurs:23];$TbNumEnrValeur)
		$FT:=Size of array:C274($TbNumEnrValeur)
		For ($Salé;1;$FT)
			GOTO RECORD:C242([RAEMAValeurs:23];$TbNumEnrValeur{$salé})
			DUPLICATE RECORD:C225([RAEMAValeurs:23])
			[RAEMAValeurs:23]Identifiant:3:=Replace string:C233([RAEMAValeurs:23]Identifiant:3;$CampagneACopier;$CampagneActuelle)  // Actualisation de l'identifiant
			SAVE RECORD:C53([RAEMAValeurs:23])
		End for 
		
		  // On a toute la nouvelle campagne mais les liens entre les tables, basés sur les UUID sont à rétablir
		
		  // Rétablissement du lien entre [RAEMACampagnes] et [RAEMALignes]
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$CampagneActuelle)  // Rappel du [RAEMACampagnes]
		QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$TestNouvelleCampagne)  // Rappel des [RAEMALignes]
		$SFT:=Records in selection:C76([RAEMAGermes:21])
		ARRAY TEXT:C222($TbIDGerme;$SFT)
		For ($Fumé;1;$SFT)
			$TbIDGerme{$Fumé}:=[RAEMACampagnes:20]UUID:1
		End for 
		ARRAY TO SELECTION:C261($TbIDGerme;[RAEMAGermes:21]UUIDCampagne:2)
		
		
		  // Rétablissement du lien entre [RAEMAGermes] et [RAEMALignes]
		QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$TestNouvelleCampagne)  // Rappel des nouveaux germes créés
		SELECTION TO ARRAY:C260([RAEMAGermes:21]Identifiant:3;$TbGermesIdentifiant;[RAEMAGermes:21]UUID:1;$TbUUIDGerme)
		$FT:=Size of array:C274($TbGermesIdentifiant)
		For ($Salé;1;$FT)
			QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=($TbGermesIdentifiant{$salé}+"@"))  // Rappel des lignes
			$SFT:=Records in selection:C76([RAEMALignes:22])
			ARRAY TEXT:C222($TbIDLigne;$SFT)
			For ($Fumé;1;$SFT)
				$TbIDLigne{$Fumé}:=$TbUUIDGerme{$salé}
			End for 
			ARRAY TO SELECTION:C261($TbIDLigne;[RAEMALignes:22]UUIDGerme:2)
		End for 
		
		  // Rétablissement du lien entre [RAEMALignes] et [RAEMAValeurs]
		QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=$TestNouvelleCampagne)  // Rappel des nouvelles lignes créées
		SELECTION TO ARRAY:C260([RAEMALignes:22]Identifiant:3;$TbLignesIdentifiant;[RAEMALignes:22]UUID:1;$TbUUIDLigne)
		$FT:=Size of array:C274($TbLignesIdentifiant)
		For ($Salé;1;$FT)
			QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=($TbLignesIdentifiant{$salé}+"@"))  // Rappel des valeurs éventuellement
			$SFT:=Records in selection:C76([RAEMAValeurs:23])
			ARRAY TEXT:C222($TbIDValeurs;$SFT)
			For ($Fumé;1;$SFT)
				$TbIDValeurs{$Fumé}:=$TbUUIDLigne{$salé}
			End for 
			ARRAY TO SELECTION:C261($TbIDValeurs;[RAEMAValeurs:23]UUIDLigne:2)
		End for 
		
		READ WRITE:C146([RAEMACampagnes:20])
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=TbNR{TbNR})
		OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbF";$TbF)
		OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbA";$TbA)
		OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbDilution";$TbD)
		OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbFabricant";$TbFab)
		OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Rang";$Rang)
		SAVE RECORD:C53([RAEMACampagnes:20])
		ZAmnistiePartielle (->[RAEMACampagnes:20];True:C214)
		  // RaemaSchemaAffichePUMTbNR 
		  // TbNR:=Chercher dans tableau(TbNR;$CampagneActuelle)
		RaemaSchemaPUMCampagne 
	End if 
Else 
	ALERT:C41("Bon, alors je ne fais rien..")
End if 