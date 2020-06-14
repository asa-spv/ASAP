//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 28/07/18, 06:46:18
  // ----------------------------------------------------
  // Paramètre aucy-un
  // ----------------------------------------------------
  // Méthode : RaemaSchemaDupliquer
  // Description
  // // Méthode qui duplique les enregistrements des tables 
  // [RAEMACampagnes], [RAEMAGermes], [RAEMALignes]; [RAEMAValeurs]
  // Sur le modèle du RAEMA affiché en proposant un numéro plausible

C_LONGINT:C283($salé;$FT;$AnN;$NumN;$J1)
C_BOOLEAN:C305($Parité;$Gel)

$CampagneCopiée:=TbNR{TbNR}
$TestCampagneCopiée:=$CampagneCopiée+"@"

$Gel:=($CampagneCopiée="@A")
  // Recrutement des enregistrements à copier
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$CampagneCopiée)
$Compteur:=1
Repeat 
	$ProchRaema:=String:C10(Num:C11(TbNR{TbNR})+$Compteur)+(Num:C11($Gel)*"A")
	$Compteur:=$Compteur+1
	$L:=Find in array:C230(TbNR;$ProchRaema)
Until ($L<0)  // le premier n° de RAMA de même type et non existant

$Dem:=Request:C163("Quel n° donner à cette campagne?";$ProchRaema)
If (OK=1) & ($Dem#"")
	If (Find in array:C230(TbNR;$Dem)>0)
		ALERT:C41("Le numéro de campagne "+$Dem+" existe déjà...")
	Else 
		$TestNouvelleCampagne:=$Dem+"@"
		  // Construisons les enregistrements des [RAEMAValeurs]
		  // Duplication du [RAEMACampagnes]
		DUPLICATE RECORD:C225([RAEMACampagnes:20])
		  // Actualisation des champs sensibles
		$AnN:=RaemaTrouveAnParNumCampagne ($Dem)
		$NumN:=Num:C11($Dem)
		$Parité:=($NumN%2=0)
		Case of 
			: (($Parité) & ($Dem#"@A"))  // 1er RAEMA Poudre
				$DatePremJourMars:=Date:C102("01/03/"+String:C10($AnN))
				$NumJ:=Day number:C114($DatePremJourMars)  // Le premier jour de Mars
				$J1:=(Num:C11($NumJ>3)*(10-$NumJ))+(Num:C11($NumJ<=3)*(3-$NumJ))
				$DateDébut:=$DatePremJourMars+$J1  // Le premier mardi
				
			: (($Parité=False:C215) & ($Dem#"@A"))  // 2e RAEMA Poudre
				$DatePremJourOctobre:=Date:C102("01/10/"+String:C10($AnN))
				$NumJ:=Day number:C114($DatePremJourOctobre)  // Le premier jour de Mars
				$J1:=(Num:C11($NumJ>3)*(10-$NumJ))+(Num:C11($NumJ<=3)*(3-$NumJ))
				$DateDébut:=$DatePremJourOctobre+$J1  // Le premier mardi
				
			: (($Parité) & ($Dem="@A"))  // 1er RAEMA gel
				$DateDerJourMai:=Date:C102("31/05/"+String:C10($AnN))  // Le dernier jour de Mai
				$NumJ:=Day number:C114($DateDerJourMai)  // N° du jour
				$J1:=(Num:C11($NumJ>=3)*(3-$NumJ))+(Num:C11($NumJ<=3)*(-4-$NumJ))
				$DateDébut:=$DateDerJourMai+$J1  // Le dernier mardi
				
			: (($Parité=False:C215) & ($Dem="@A"))  // 2e RAEMA gel
				$DateDerJourNovembre:=Date:C102("30/11/"+String:C10($AnN))
				$NumJ:=Day number:C114($DateDerJourNovembre)  // Le premier jour de Mars
				$J1:=(Num:C11($NumJ>=3)*(3-$NumJ))+(Num:C11($NumJ<=3)*(-4-$NumJ))
				$DateDébut:=$DateDerJourNovembre+$J1  // Le premier mardi
				
		End case 
		
		[RAEMACampagnes:20]NumCampagne:2:=$Dem
		[RAEMACampagnes:20]DateEnvoiColis:3:=$DateDébut
		[RAEMACampagnes:20]DateLimiteReponse:4:=$DateDébut+21
		[RAEMACampagnes:20]DateMiseEnLigne:5:=!00-00-00!
		[RAEMACampagnes:20]NbParticipants:6:=0
		OB SET:C1220([RAEMACampagnes:20]Arguments:7;"N° des échantillons";"")  // Vidage des N° des échantillons
		OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";"")  // Vidage des Niveaux de contamination
		SAVE RECORD:C53([RAEMACampagnes:20])
		
		
		  // DUPLICATION DES ENREGISTREMENTS
		  // Duplication des [RAEMAGermes]
		If ($Gel)
			QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$TestCampagneCopiée)
		Else 
			QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$TestCampagneCopiée;*)
			QUERY:C277([RAEMAGermes:21]; & [RAEMAGermes:21]Identifiant:3#($CampagneCopiée+"A@"))
		End if 
		LONGINT ARRAY FROM SELECTION:C647([RAEMAGermes:21];$TbNumEnrGerme)
		$FT:=Size of array:C274($TbNumEnrGerme)
		For ($Salé;1;$FT)
			GOTO RECORD:C242([RAEMAGermes:21];$TbNumEnrGerme{$salé})
			DUPLICATE RECORD:C225([RAEMAGermes:21])
			[RAEMAGermes:21]Identifiant:3:=Replace string:C233([RAEMAGermes:21]Identifiant:3;$CampagneCopiée;$Dem)  // Actualisation de l'identifiant
			SAVE RECORD:C53([RAEMAGermes:21])
		End for 
		
		  // Duplication des [RAEMALignes]
		If ($Gel)
			QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=$TestCampagneCopiée)
		Else 
			QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=$TestCampagneCopiée;*)
			QUERY:C277([RAEMALignes:22]; & [RAEMALignes:22]Identifiant:3#($CampagneCopiée+"A@"))
		End if 
		LONGINT ARRAY FROM SELECTION:C647([RAEMALignes:22];$TbNumEnrLigne)
		$FT:=Size of array:C274($TbNumEnrLigne)
		For ($Salé;1;$FT)
			GOTO RECORD:C242([RAEMALignes:22];$TbNumEnrLigne{$salé})
			DUPLICATE RECORD:C225([RAEMALignes:22])
			[RAEMALignes:22]Identifiant:3:=Replace string:C233([RAEMALignes:22]Identifiant:3;$CampagneCopiée;$Dem)  // Actualisation de l'identifiant
			SAVE RECORD:C53([RAEMALignes:22])
		End for 
		
		  // Duplication des [RAEMAValeurs]
		If ($Gel)
			QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$TestCampagneCopiée)
		Else 
			QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$TestCampagneCopiée;*)
			QUERY:C277([RAEMAValeurs:23]; & [RAEMAValeurs:23]Identifiant:3#($CampagneCopiée+"A@"))
		End if 
		LONGINT ARRAY FROM SELECTION:C647([RAEMAValeurs:23];$TbNumEnrValeur)
		$FT:=Size of array:C274($TbNumEnrValeur)
		For ($Salé;1;$FT)
			GOTO RECORD:C242([RAEMAValeurs:23];$TbNumEnrValeur{$salé})
			DUPLICATE RECORD:C225([RAEMAValeurs:23])
			[RAEMAValeurs:23]Identifiant:3:=Replace string:C233([RAEMAValeurs:23]Identifiant:3;$CampagneCopiée;$Dem)  // Actualisation de l'identifiant
			SAVE RECORD:C53([RAEMAValeurs:23])
		End for 
		
		  // On a toute la nouvelle campagne mais les liens entre les tables, basés sur les UUID sont à rétablir
		
		  // Rétablissement du lien entre [RAEMACampagnes] et [RAEMALignes]
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$Dem)  // Rappel du [RAEMACampagnes]
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
		
		RaemaSchemaAffichePUMTbNR 
		TbNR:=Find in array:C230(TbNR;$Dem)
		RaemaSchemaPUMCampagne 
		
	End if 
	
Else 
	
	ALERT:C41("Bon, alors je ne fais rien..")
	
End if 