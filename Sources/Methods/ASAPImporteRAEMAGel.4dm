//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 10:20:33
  // ----------------------------------------------------
  // Méthode : ASAPImporteRAEMAGel
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------


$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"Raemagel@")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux RAEMA gel")
	Else 
		READ WRITE:C146([CampagneGelGermes:25])
		ALL RECORDS:C47([CampagneGelGermes:25])
		DELETE SELECTION:C66([CampagneGelGermes:25])
		READ WRITE:C146([CampagneParticipations:17])
		
		  // le rapport de non confomité
		$Rapport:=""
		ARRAY LONGINT:C221($TbNumLaboPb;0)
		ARRAY TEXT:C222($TbComLaboPb;0)
		
		$Pos:=Position:C15("_";Ligne)
		$TT:=Num:C11(Substring:C12(Ligne;($Pos+1)))
		$debutLigne:=Substring:C12(Ligne;1;($Pos-1))
		$FT:=Num:C11(Substring:C12($debutLigne;9))
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		For ($Fumé;1;$FT)
			ARRAY TEXT:C222($TbDescription;$TT)  // recueil des valeurs exportées
			$SFT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$SFT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$SFT+1}:=Ligne
			  //$TbDescription{1} = IDComplement
			  //$TbDescription{2} = NumRaema
			  //$TbDescription{3} = NomDuGerme
			  //$TbDescription{4} = Periode
			  //$TbDescription{5} = AnCampagne
			  //$TbDescription{6} = NbrePotAvecRapport
			  //$TbDescription{7} = NbrePotSansRapport
			  //$TbDescription{8} = ID
			$AnCampagneN:=Num:C11((Num:C11(Length:C16($TbDescription{5})=2)*"20")+$TbDescription{5})
			$Période:=2+(Num:C11($TbDescription{4}#"Mai")*2)
			$NumCampagne:=RaemaTrouveNumCampagneParAn ($AnCampagneN;$Période)
			If ($NumCampagne>="62")  // On ignore avant le 62A  
				$NumLaboA:=$TbDescription{2}
				$NumLaboN:=Num:C11($NumLaboA)
				
				  // trouve t'on le numéro de labo dans les tableaux généraux des personnes
				$L:=Find in array:C230(<>TbPerNumLaboRAEMA;$NumLaboN)  // Test pour un laboratoire normal ou maître
				$L2:=ASAPTestLaboRaemaLié ($NumLaboA)  // Test pour un n° de rapport lié
				If ($L>0) | ($L2>0)  // Recherche fructueuse
					  // il reste à trouver les [WebConnexions]UUIDParticipation, [WebConnexions]CodeConnexion
					If ($L>0)  // c'est un laboratoire maître
						$CodeConnexion:=<>TbPerIdentificateur{$L}
						$UUIDLabo:=<>TbPerUUID{$L}
						$Test:=$NumLaboA+"_"+$NumCampagne+"_"
					Else   // c'est un n° de rapport lié
						$CodeConnexion:=ASAPTrouveCodeRaemaLié ($L2;$NumLaboA)
						$UUIDLabo:=<>TbPerUUID{$L2}
						$Test:=<>TbPerNumLaboRAEMAA{$L2}+"_"+$NumCampagne+"_"+$CodeConnexion
					End if 
					$L3:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
					If ($L3>0)  // il a trouvé l'Identifiant de Participation
						$UUIDParticipation:=<>TbLotoUUIDParticipation{$L3}
						
						
						QUERY:C277([CampagneGelGermes:25];[CampagneGelGermes:25]NomDuGerme:3=$TbDescription{3};*)
						QUERY:C277([CampagneGelGermes:25]; & [CampagneGelGermes:25]UUIDParticipation:2=$UUIDParticipation)
						If (Records in selection:C76([CampagneGelGermes:25])=0)
							CREATE RECORD:C68([CampagneGelGermes:25])
							[CampagneGelGermes:25]NomDuGerme:3:=$TbDescription{3}
							[CampagneGelGermes:25]UUIDParticipation:2:=$UUIDParticipation
						End if 
						[CampagneGelGermes:25]NbreColisSupAvecRapport:5:=Num:C11($TbDescription{6})
						[CampagneGelGermes:25]NbreColisSupSansRapport:4:=Num:C11($TbDescription{7})
						[CampagneGelGermes:25]NumCampagne:6:=$NumCampagne
						SAVE RECORD:C53([CampagneGelGermes:25])
						
					Else   // il n'a pas trouvé trace de la participation
						$Com:="Le germe"+<>ZGuil+$TbDescription{3}+<>ZGuil+" n'a pas pu être rattachée à un enregistrement"
						$Com:=$Com+" de [CampagneParticipations] car la ligne "+$Test+" n'a pas été trouvée."
						$LCom:=Find in array:C230($TbNumLaboPb;$NumLaboN)
						If ($LCom<0)
							APPEND TO ARRAY:C911($TbNumLaboPb;$NumLaboN)
							APPEND TO ARRAY:C911($TbComLaboPb;$Com)
						Else 
							$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
						End if 
					End if 
					
				Else   // il n'a pas trouvé trace du laboratoire
					$Com:="Le laboratoire qui existait lors de la campagne "+$NumCampagne+" avec le n° de RAEMA "+$NumLaboA+" n'est plus dans la liste ASAP."
					$LCom:=Find in array:C230($TbNumLaboPb;$NumLaboN)
					If ($LCom<0)
						APPEND TO ARRAY:C911($TbNumLaboPb;$NumLaboN)
						APPEND TO ARRAY:C911($TbComLaboPb;$Com)
					Else 
						$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
					End if 
					
				End if 
			End if 
			
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
			
		End for 
		
		CLOSE DOCUMENT:C267($Doc)
		
		ALERT:C41("Import achevé")
		
		SORT ARRAY:C229($TbNumLaboPb;$TbComLaboPb;>)
		$FT:=Size of array:C274($TbComLaboPb)
		$Rapport:=""
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+String:C10($TbNumLaboPb{$Salé})+<>ZCR+$TbComLaboPb{$Salé}+<>ZCR2
		End for 
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
	End if 
End if 
ZAmnistieInternationale 
ASAPFabriqueTbParticipe 