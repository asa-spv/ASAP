
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		C_LONGINT:C283($NumTable;$Salé;$FT)
		
		  // Calcul du nombre de [Personnes] de la ligne
		$L:=TbLiaison  // Ligne concernée
		
		$Critère:=TbProprio{$L}
		$ComparateurCourant:=TbComparateur{$L}
		$ValeurCourante:=TbValeurs{$L}
		If ($Critère#"") & ($ComparateurCourant#"") & ($ValeurCourante#"")
			Case of 
				: ($ComparateurCourant="Est")
					$Opérateur:="="
					
				: ($ComparateurCourant="contient")
					$Opérateur:="="
					$ValeurCourante:="@"+$ValeurCourante+"@"
					
				: ($ComparateurCourant="N'est pas")
					$Opérateur:="#"
					
				: ($ComparateurCourant="ne contient pas")
					$Opérateur:="#"
					$ValeurCourante:="@"+$ValeurCourante+"@"
					
					
				: ($ComparateurCourant="Est plus grand que")
					$Opérateur:=">"
					
				: ($ComparateurCourant="Est plus grand ou égal à")
					$Opérateur:=">="
					
				: ($ComparateurCourant="Est plus petit que")
					$Opérateur:="<"
					
				: ($ComparateurCourant="Est plus petit ou égal à")
					$Opérateur:="<="
					
			End case 
			
			If (Find in array:C230(<>PUMPerProprio;$Critère)>0)  // C'est une propriété
				If ($ValeurCourante="")
					QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;$Critère;$Opérateur;Null:C1517)
				Else 
					QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;$Critère;$Opérateur;$ValeurCourante)
				End if 
			Else   // Ce n'est pas une propriété
				Case of 
					: ($Critère="N° RAEMA")  // recherche dans [Personnes]NomLong ou [Personnes]NomCourt
						$L2:=Find in array:C230(<>TbPerNumLaboRAEMAA;$ValeurCourante)
						Case of 
							: ($Opérateur="#")
								QUERY:C277([Personnes:12];[Personnes:12]UUID:1#<>TbPerUUID{$L2})
								
							: ($Opérateur="=")
								QUERY:C277([Personnes:12];[Personnes:12]UUID:1=<>TbPerUUID{$L2})
								
								
							Else 
								$ValeurCouranteN:=Num:C11($ValeurCourante)
								$FT:=Size of array:C274(<>TbPerNumLaboRAEMA)
								ARRAY TEXT:C222($TbUUIDRetenues;0)
								For ($Salé;1;$FT)
									Case of 
										: ($Opérateur=">")
											If (<>TbPerNumLaboRAEMA{$Salé}>$ValeurCouranteN)
												APPEND TO ARRAY:C911($TbUUIDRetenues;<>TbPerUUID{$Salé})
											End if 
											
										: ($Opérateur=">=")
											If (<>TbPerNumLaboRAEMA{$Salé}>=$ValeurCouranteN)
												APPEND TO ARRAY:C911($TbUUIDRetenues;<>TbPerUUID{$Salé})
											End if 
											
										: ($Opérateur="<")
											If (<>TbPerNumLaboRAEMA{$Salé}<$ValeurCouranteN)
												APPEND TO ARRAY:C911($TbUUIDRetenues;<>TbPerUUID{$Salé})
											End if 
											
										: ($Opérateur="=")
											If (<>TbPerNumLaboRAEMA{$Salé}<=$ValeurCouranteN)
												APPEND TO ARRAY:C911($TbUUIDRetenues;<>TbPerUUID{$Salé})
											End if 
											
									End case 
								End for 
								QUERY WITH ARRAY:C644([Personnes:12]UUID:1;$TbUUIDRetenues)
								
						End case 
						
					: ($Critère="Identificateur")  // recherche par [Personnes]Identificateur
						If ($Opérateur="#")
							QUERY:C277([Personnes:12];[Personnes:12]Identificateur:4#$ValeurCourante)
						Else 
							QUERY:C277([Personnes:12];[Personnes:12]Identificateur:4=$ValeurCourante)
						End if 
						
						
					: ($Critère="Facturation spéciale")  // recherche dans [Personnes]Arguments;"FacturationSpeciale"
						If ($ValeurCourante="oui") | ($ValeurCourante="vrai")
							$ValeurCourante:="Vrai"
						Else 
							$ValeurCourante:="Faux"
						End if 
						QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;"FacturationSpeciale";$Opérateur;$ValeurCourante)
						
					: ($Critère="Nom de contact")  // recherche dans [Personnes]Arguments;"NomContact"
						QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;"NomContact";$Opérateur;$ValeurCourante)
						
						
					: ($Critère="Nom du laboratoire")  // recherche dans [Personnes]NomLong ou [Personnes]NomCourt
						$Critère:="NomCourt"
						$L2:=0
						Repeat 
							$L2:=Find in array:C230(<>TbNomChampBase;$Critère;($L2+1))
							$Pt:=<>TbPtChampBase{$L2}
							$NumTable:=Table:C252($Pt)
						Until ($NumTable=Table:C252(->[Personnes:12]))
						QUERY:C277([Personnes:12];$Pt->;$Opérateur;$ValeurCourante;*)
						
						$Critère:="NomLong"
						$L2:=0
						Repeat 
							$L2:=Find in array:C230(<>TbNomChampBase;$Critère;($L2+1))
							$Pt:=<>TbPtChampBase{$L2}
							$NumTable:=Table:C252($Pt)
						Until ($NumTable=Table:C252(->[Personnes:12]))
						QUERY:C277([Personnes:12]; | ;$Pt->;$Opérateur;$ValeurCourante)
						
						
					: ($Critère="Ligne adresse")  // recherche dans [Personnes] qui ont le critère dans une des [PersonnesAdresses]LigneAdressex
						QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]LigneAdresse1:3=$ValeurCourante;*)
						QUERY:C277([PersonnesAdresses:11]; | [PersonnesAdresses:11]LigneAdresse2:4=$ValeurCourante;*)
						QUERY:C277([PersonnesAdresses:11]; | [PersonnesAdresses:11]LigneAdresse3:5=$ValeurCourante)
						RELATE ONE SELECTION:C349([PersonnesAdresses:11];[Personnes:12])
						
					: ($Critère="Code postal")  // recherche dans [Personnes] qui ont le critère dans une des [PersonnesAdresses]CodePostal
						QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]CodePostal:6=$ValeurCourante)
						RELATE ONE SELECTION:C349([PersonnesAdresses:11];[Personnes:12])
						
					: ($Critère="Ville")  // recherche dans [Personnes] qui ont le critère dans une des [PersonnesAdresses]Ville
						QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]Ville:7=$ValeurCourante)
						RELATE ONE SELECTION:C349([PersonnesAdresses:11];[Personnes:12])
						
					: ($Critère="Pays")  // recherche dans [Personnes] qui ont le critère dans une des[PersonnesAdresses]Pays
						QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]Pays:8=$ValeurCourante)
						RELATE ONE SELECTION:C349([PersonnesAdresses:11];[Personnes:12])
						
					: ($Critère="Paye en deux fois")  // recherche dans [Personnes] qui ont le critère PayeDeuxFois dans [Personnes]Arguments
						QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;"PayeDeuxFois";$Opérateur;"Vrai")
						If ($ValeurCourante="Faux")
							CREATE SET:C116([Personnes:12];"$PayeDeuxFois")
							ALL RECORDS:C47([Personnes:12])
							CREATE SET:C116([Personnes:12];"$ToutPersonne")
							DIFFERENCE:C122("$ToutPersonne";"$PayeDeuxFois";"$PayeDeuxFois")
							USE SET:C118("$PayeDeuxFois")
						End if 
						
					: ($Critère="Adresse mail")  // recherche dans [Personnes] qui ont le la propriété EMail, EMailBis, EmailRAEMA ou EmailCompta dans [Personnes]Arguments
						QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;"EMail";$Opérateur;$ValeurCourante;*)
						QUERY BY ATTRIBUTE:C1331([Personnes:12]; | [Personnes:12]Arguments:7;"EMailBis";$Opérateur;$ValeurCourante;*)
						QUERY BY ATTRIBUTE:C1331([Personnes:12]; | [Personnes:12]Arguments:7;"EmailRAEMA";$Opérateur;$ValeurCourante;*)
						QUERY BY ATTRIBUTE:C1331([Personnes:12]; | [Personnes:12]Arguments:7;"EmailCompta";$Opérateur;$ValeurCourante)
						
				End case 
			End if 
			QUERY SELECTION:C341([Personnes:12];[Personnes:12]Caduc:8=False:C215;*)
			QUERY SELECTION:C341([Personnes:12]; & [Personnes:12]TypePersonne:5="laboratoire")
			
			TbNb{$L}:=Records in selection:C76([Personnes:12])
			$NomEnsemble:="ensemble"+String:C10($L)
			CREATE SET:C116([Personnes:12];$NomEnsemble)
			TbEnsemble{$l}:=$NomEnsemble
			
			$FT:=Size of array:C274(TbEnsemble)
			
			If (TbLiaison{1}="ET")
				QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="laboratoire")
			Else 
				ZViderSelectionCourante (->[Personnes:12])
			End if 
			CREATE SET:C116([Personnes:12];"Res")
			For ($Salé;1;$FT)
				$EnsembleCourant:=TbEnsemble{$Salé}
				USE SET:C118($EnsembleCourant)
				$Combine:=TbLiaison{$Salé}
				
				Case of 
					: ($Combine="ET")
						INTERSECTION:C121("Res";$EnsembleCourant;"Res")
						
					: ($Combine="OU")
						UNION:C120("Res";$EnsembleCourant;"Res")
						
					: ($Combine="SAUF")
						DIFFERENCE:C122("Res";$EnsembleCourant;"Res")
						
						
				End case 
				
			End for 
			VarNbEnrTrouvés:=Records in set:C195("Res")
			INTERSECTION:C121(ZNomEnsembleAvant;"Res";"ResSel")
			VarNbEnrTrouvésSel:=Records in set:C195("ResSel")
			
		End if 
End case 
