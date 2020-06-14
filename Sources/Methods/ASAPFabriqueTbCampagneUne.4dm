//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/08/18, 15:23:29
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbCampagneUne
  // Description
  // 

C_TEXT:C284($Fabricant;$Milieu;$TipsEn;$TipsFr)
C_LONGINT:C283($EC)
C_BOOLEAN:C305($EscamotableB;$EscamotageB)
$MCE:=Macintosh command down:C546  // Permet de mettre dans le PP les tableaux des campagnes
$MCO:=Macintosh option down:C545  // Permet de choisir le n° de campagne

$NomMéthode:=Current method name:C684
$NomMéthodeMAJ:=$NomMéthode+"MAJ"
If (<>ZClient) & (Count parameters:C259=0)
	$EC:=Execute on server:C373($NomMéthode;0)
Else 
	  // Les tableaux interprocess
	ASAPInitTbGenerauxUneCampagne 
	$NumCampagne:=<>NumCampagneEnCoursSaisie
	If ($MCO)
		$NC:=Request:C163("Quel n° de campagne ?";"66")
		$NumCampagne:=(Num:C11($NC="")*$NumCampagne)+(Num:C11($NC#"")*$NC)
	End if 
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
	
	
	
	  // TABLEAUX GENERAUX du SCHEMA des CAMPAGNES
	  // les ET du tableau
	$ET:="N° campagne"+<>ZTab+"N° page"+<>ZTab+"Nom du germe en Fr"+<>ZTab+"Nom du germe en En"
	$ET:=$ET+<>ZTab+"N° ligne"+<>ZTab+"Nom de la ligne en Fr"+<>ZTab+"Nom de la ligne en En"+<>ZTab+"Escamotable"
	$ET:=$ET+<>ZTab+"N° valeur"+<>ZTab+"Nom de la valeur en Fr"+<>ZTab+"Nom de la valeur en En"+<>ZTab+"Escamotage"
	$ET:=$ET+<>ZTab+"Tips en Fr"+<>ZTab+"Tips en En"+<>ZTab+"Milieu"+<>ZTab+"Fabricant"
	$ET:=$ET+<>ZTab+"Multiple"+<>ZTab+"Nb valeurs"+<>ZTab+"Précision"+<>ZCR
	
	$ET:=$ET+"<>TbNumCampagne"+<>ZTab+"<>TbRefGerme"+<>ZTab+"<>TbNomGermeF"+<>ZTab+"<>TbNomGermeA"
	$ET:=$ET+<>ZTab+"<>TbRefLigne"+<>ZTab+"<>TbNomLigneF"+<>ZTab+"<>TbNomLigneA"+<>ZTab+"<>TbEscamotable"
	$ET:=$ET+<>ZTab+"<>TbRefValeur"+<>ZTab+"<>TbNomValeurF"+<>ZTab+"<>TbNomValeurA"+<>ZTab+"<>TbEscamotage"
	$ET:=$ET+<>ZTab+"<>TbTipsFr"+<>ZTab+"<>TbTipsEn"+<>ZTab+"<>TbMilieu"+<>ZTab+"<>TbFabricant"
	$ET:=$ET+<>ZTab+"<>TbMultiple"+<>ZTab+"<>TbNbValeurs"+<>ZTab+"<>TbPrecision"+<>ZCR
	
	
	
	FIRST RECORD:C50([RAEMACampagnes:20])
	$FT:=Records in selection:C76([RAEMACampagnes:20])
	For ($Salé;1;$FT)
		$NumCampagne:=[RAEMACampagnes:20]NumCampagne:2
		
		QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]UUIDCampagne:2=[RAEMACampagnes:20]UUID:1)
		$SFT:=Records in selection:C76([RAEMAGermes:21])
		For ($Fumé;1;$SFT)
			$RefGerme:=[RAEMAGermes:21]Identifiant:3
			$NomGermeF:=[RAEMAGermes:21]NomFr:4
			$NomGermeA:=[RAEMAGermes:21]NomEn:5
			
			QUERY:C277([RAEMALignes:22];[RAEMALignes:22]UUIDGerme:2=[RAEMAGermes:21]UUID:1)
			$SSFT:=Records in selection:C76([RAEMALignes:22])
			For ($Sec;1;$SSFT)
				
				$RefLigne:=[RAEMALignes:22]Identifiant:3
				$NomLigneF:=[RAEMALignes:22]NomFr:4
				$NomLigneA:=[RAEMALignes:22]NomEn:5
				$EscamotableB:=OB Get:C1224([RAEMALignes:22]Arguments:6;"Escamotable";Est un booléen:K8:9)
				$EscamotableA:=Num:C11($EscamotableB)*"X"
				
				QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]UUIDLigne:2=[RAEMALignes:22]UUID:1)
				$SSSFT:=Records in selection:C76([RAEMAValeurs:23])
				If ($SSSFT=0)
					APPEND TO ARRAY:C911(<>TbNumCampagne;$NumCampagne)
					APPEND TO ARRAY:C911(<>TbRefGerme;$RefGerme)
					APPEND TO ARRAY:C911(<>TbNomGermeF;$NomGermeF)
					APPEND TO ARRAY:C911(<>TbNomGermeA;$NomGermeA)
					APPEND TO ARRAY:C911(<>TbRefLigne;$RefLigne)
					APPEND TO ARRAY:C911(<>TbNomLigneF;$NomLigneF)
					APPEND TO ARRAY:C911(<>TbNomLigneA;$NomLigneA)
					APPEND TO ARRAY:C911(<>TbRefValeur;"")
					APPEND TO ARRAY:C911(<>TbNomValeurF;"")
					APPEND TO ARRAY:C911(<>TbNomValeurA;"")
					APPEND TO ARRAY:C911(<>TbTipsFr;"")
					APPEND TO ARRAY:C911(<>TbTipsEn;"")
					APPEND TO ARRAY:C911(<>TbMilieu;"")
					APPEND TO ARRAY:C911(<>TbFabricant;"")
					APPEND TO ARRAY:C911(<>TbEscamotable;$EscamotableA)
					APPEND TO ARRAY:C911(<>TbEscamotage;"")
					APPEND TO ARRAY:C911(<>TbMultiple;"")
					APPEND TO ARRAY:C911(<>TbNbValeurs;"")
					APPEND TO ARRAY:C911(<>TbPrecision;"")
				Else 
					$MultipleB:=OB Get:C1224([RAEMALignes:22]Arguments:6;"ChoixMultiple";Est un booléen:K8:9)
					$MultipleA:=(Num:C11($MultipleB)*"C")+(Num:C11(Not:C34($MultipleB))*"M")
					For ($i;1;$SSSFT)
						$RefValeur:=[RAEMAValeurs:23]Identifiant:3
						$NomValeurF:=[RAEMAValeurs:23]NomFr:4
						$NomValeurA:=[RAEMAValeurs:23]NomEn:5
						$TipsFr:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"TipsFr";Est un texte:K8:3)
						$TipsEn:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"TipsEn";Est un texte:K8:3)
						$Milieu:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Milieu";Est un texte:K8:3)
						$Fabricant:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Fabricant";Est un texte:K8:3)
						$EscamotageB:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Escamotage";Est un booléen:K8:9)
						$EscamotageA:=Num:C11($EscamotageB)*"X"
						$Précision:=Num:C11(OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Précision";Est un booléen:K8:9))
						$PrécisionA:=String:C10($Précision;"X;;")
						APPEND TO ARRAY:C911(<>TbNumCampagne;$NumCampagne)
						APPEND TO ARRAY:C911(<>TbRefGerme;$RefGerme)
						APPEND TO ARRAY:C911(<>TbNomGermeF;$NomGermeF)
						APPEND TO ARRAY:C911(<>TbNomGermeA;$NomGermeA)
						APPEND TO ARRAY:C911(<>TbRefLigne;$RefLigne)
						APPEND TO ARRAY:C911(<>TbNomLigneF;$NomLigneF)
						APPEND TO ARRAY:C911(<>TbNomLigneA;$NomLigneA)
						APPEND TO ARRAY:C911(<>TbRefValeur;$RefValeur)
						APPEND TO ARRAY:C911(<>TbNomValeurF;$NomValeurF)
						APPEND TO ARRAY:C911(<>TbNomValeurA;$NomValeurA)
						APPEND TO ARRAY:C911(<>TbTipsFr;$TipsFr)
						APPEND TO ARRAY:C911(<>TbTipsEn;$TipsEn)
						APPEND TO ARRAY:C911(<>TbMilieu;$Milieu)
						APPEND TO ARRAY:C911(<>TbFabricant;$Fabricant)
						APPEND TO ARRAY:C911(<>TbEscamotable;$EscamotableA)
						APPEND TO ARRAY:C911(<>TbEscamotage;$EscamotageA)
						APPEND TO ARRAY:C911(<>TbMultiple;$MultipleA)
						APPEND TO ARRAY:C911(<>TbNbValeurs;String:C10($SSSFT))
						APPEND TO ARRAY:C911(<>TbPrecision;$PrécisionA)
						NEXT RECORD:C51([RAEMAValeurs:23])
					End for 
				End if 
				NEXT RECORD:C51([RAEMALignes:22])
			End for 
			NEXT RECORD:C51([RAEMAGermes:21])
		End for 
		NEXT RECORD:C51([RAEMACampagnes:20])
	End for 
	MULTI SORT ARRAY:C718(<>TbRefLigne;>;<>TbRefValeur;>;<>TbNumCampagne;<>TbRefGerme;<>TbNomGermeF;<>TbNomGermeA\
		;<>TbNomLigneF;<>TbNomLigneA;<>TbNomValeurF;<>TbNomValeurA;<>TbTipsFr;<>TbTipsEn;<>TbMilieu;<>TbFabricant\
		;<>TbEscamotable;<>TbEscamotage;<>TbMultiple;<>TbNbValeurs;<>TbPrecision)
	
	  // Calcul du nombre d'élements à placer dans le fichier récapitulatifs de la saisie en PJ des mails
	$FT:=Size of array:C274(<>TbPrecision)
	$NbreValeur:=1  // Le n° de laboratoire + version
	For ($Salé;1;$FT)
		If (<>TbNbValeurs{$Salé}="")
			$NbreValeur:=$NbreValeur+1
		Else 
			$SFT:=Num:C11(<>TbNbValeurs{$Salé})
			$Précision:=0
			For ($Fumé;1;$SFT)
				$Rang:=$salé+$Fumé-1
				If (<>TbPrecision{$Rang}#"")
					$Précision:=1
					$Fumé:=$SFT
				End if 
			End for 
			$NbreValeur:=$NbreValeur+1+$Précision
			$Salé:=$Salé+Num:C11(<>TbNbValeurs{$Salé})-1
		End if 
	End for 
	READ WRITE:C146([RAEMACampagnes:20])
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursSaisie)
	OB SET:C1220([RAEMACampagnes:20]Arguments:7;"NbreLignePJ";$NbreValeur)
	SAVE RECORD:C53([RAEMACampagnes:20])
	ZAmnistiePartielle (->[RAEMACampagnes:20])
	
	If ($MCE)
		$FT:=Size of array:C274(<>TbRefLigne)
		$Rapport:=$ET
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+<>TbNumCampagne{$Salé}+<>ZTab+<>TbRefGerme{$Salé}+<>ZTab+<>TbNomGermeF{$Salé}+<>ZTab+<>TbNomGermeA{$Salé}
			$Rapport:=$Rapport+<>ZTab+<>TbRefLigne{$Salé}+<>ZTab+<>TbNomLigneF{$Salé}+<>ZTab+<>TbNomLigneA{$Salé}+<>ZTab+<>TbEscamotable{$Salé}
			$Rapport:=$Rapport+<>ZTab+<>TbRefValeur{$Salé}+<>ZTab+<>TbNomValeurF{$Salé}+<>ZTab+<>TbNomValeurA{$Salé}+<>ZTab+<>TbEscamotage{$Salé}
			$Rapport:=$Rapport+<>ZTab+<>TbTipsFr{$Salé}+<>ZTab+<>TbTipsEn{$Salé}+<>ZTab+<>TbMilieu{$Salé}+<>ZTab+<>TbFabricant{$Salé}
			$Rapport:=$Rapport+<>ZTab+<>TbMultiple{$Salé}+<>ZTab+<>TbNbValeurs{$Salé}+<>ZTab+<>TbPrecision{$Salé}+<>ZCR
		End for 
		SET TEXT TO PASTEBOARD:C523($Rapport)
	End if 
	
	
	If (Application type:C494=4D Server:K5:6)
		EXECUTE ON CLIENT:C651("@";"ASAPFabriqueTbCampagneUneMAJ")
	End if 
End if 

