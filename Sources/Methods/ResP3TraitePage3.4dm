//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/11/15, 08:23:33
  // ----------------------------------------------------
  // Méthode : ResP3TraitePage3
  // Description
  // ResP3TraitePage3 <= ResP3MF
  // permet de traiter la page des résultats
  // ----------------------------------------------------

  // recueil et traitement du commentaire 
  // ResRaemaGelCommentaire A VOIR
C_LONGINT:C283($Salé;$FT;$Fumé;$SFT;$Sec;$SSFT;$NbreValeurATraiter)
$H1:=Milliseconds:C459

If (ResP3ControleDates )  // Dates cohérentes
	$NbreTabFichierEnvoi:=0
	  // Début des tableaux de description en clair TbNomsChamps et sous forme de fichier TbPJMailRaema exploitable statistiquement
	APPEND TO ARRAY:C911(TbPJMailRaema;NumLaboActuelA)  // le n° Raema du laboratoire
	APPEND TO ARRAY:C911(TbNomsChamps;"N° de Raema")  // l'en-tête correspondante du tableau
	$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+1
	
	  // Début de la PJ qui décrit les résultats dans l'AR
	If (LangueCourante="A")
		VarResumeRes:="Germ / method"+<>ZTab+"sample number"+<>ZTab+"Result"+<>ZCR
	Else 
		VarResumeRes:="Germe / méthode"+<>ZTab+"N° échantillon"+<>ZTab+"Résultat"+<>ZCR
	End if 
	
	  // Traitement des lignes des tableaux généraux de la campagne  
	$FT:=Size of array:C274(<>TbNumCampagne)
	ARRAY TEXT:C222(TbNomDesGermes;0)  // Initialisation du tableau des têtes de chapitres (Germe anciennement Page) 
	For ($salé;1;$FT)
		  // Annonce du Germe dans le corps du mail
		$NomDuGermePrécédent:=(Num:C11(LangueCourante="A")*<>TbNomGermeA{$Salé-1})+(Num:C11(LangueCourante="F")*<>TbNomGermeF{$Salé-1})
		$NomDuGermeCourant:=(Num:C11(LangueCourante="A")*<>TbNomGermeA{$Salé})+(Num:C11(LangueCourante="F")*<>TbNomGermeF{$Salé})
		$NouveauGerme:=($NomDuGermePrécédent#$NomDuGermeCourant)
		$NomDeLigneCourante:=(Num:C11(LangueCourante="A")*<>TbNomLigneA{$Salé})+(Num:C11(LangueCourante="F")*<>TbNomLigneF{$Salé})
		$IndiceLigneCourante:=Replace string:C233(<>TbRefLigne{$Salé};NumCampagneCourante;"")
		$PasEscamotable:=(<>TbEscamotable{$Salé}="")
		
		  // Est-ce que le germe a été coché dans P2 ?
		$GermeChoisi:=True:C214
		If ($NouveauGerme)
			$NomP3:=(Num:C11(<>TbMultiple{$Salé}="")*"Champ")+(Num:C11(<>TbMultiple{$Salé}#"")*"PUM")+$IndiceLigneCourante
			$GermeChoisi:=(Find in array:C230(TbNomsP3;$NomP3)>0)
			If ($GermeChoisi=False:C215)  // Le nouveau germe n'a pas été choisi
				$Salé:=ResP3GermeNonChoisi ($Salé;$NomDuGermeCourant)
			Else 
				APPEND TO ARRAY:C911(TbTexteResume;(<>ZCR+$NomDuGermeCourant))  // Notons le nom du germe dans le texte du corps de mail
			End if 
		End if 
		
		If ($GermeChoisi)  // Le germe a été choisi
			  // Envisageons tous les cas de figure possibles
			If (<>TbNomLigneF{$Salé}="@xxx@") & (RaemaPoudre)  // Ligne d'un échantillon
				$NomChamp:="Champ"+Replace string:C233(<>TbRefLigne{$Salé};NumCampagneCourante;"")
				
				If (<>TbNomLigneF{$Salé}="Dilution@")  // Echantillon avec dilution
					ARRAY TEXT:C222($TbDilutions;5)
					ARRAY TEXT:C222($TbDilutionsTriées;5)
					For ($Fumé;1;5)
						$Rang:=$Salé+$Fumé-1
						$NomChamp:="Champ"+Replace string:C233(<>TbRefLigne{$Rang};NumCampagneCourante;"")
						$TbDilutions{$Fumé}:=WebTrouveValeurParNom ($NomChamp;->TbNomsP3;->TbValeursP3)
						$xxx:=String:C10($Fumé)+"xxx"
						$IntituleDilutionFr:=Replace string:C233(<>TbNomLigneF{$Rang};$xxx;TbNumEch{$Fumé})
						$IntituleDilutionAn:=Replace string:C233(<>TbNomLigneA{$Rang};$xxx;TbNumEch{$Fumé})
						$NomDeLigneCourante:=(Num:C11(LangueCourante="A")*$IntituleDilutionAn)+(Num:C11(LangueCourante="F")*$IntituleDilutionFr)
						If ($TbDilutions{$Fumé}="")  // Il n'a pas rempli
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+RaemaTraducUtiliseTableau (74)+<>ZCRWeb  // Valeur non spécifiée
						Else 
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+$TbDilutions{$Fumé}+<>ZCRWeb  // Valeur spécifiée
						End if 
						  // VarResumeRes:=VarResumeRes+$NomDuGermeCourant+<>ZTab+TbNumEch{$Fumé}+<>ZTab+$TbDilutions{$Fumé}+<>ZCR
						$LigneTriée:=Find in array:C230(TbNumEchT;TbNumEch{$Fumé})
						$TbDilutionsTriées{$LigneTriée}:=$TbDilutions{$Fumé}
						APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
					End for 
					  // Attribution des valeurs de dilution à TbPJMailRaema
					For ($Fumé;1;5)
						$AjoutPJ:=(Num:C11($TbDilutionsTriées{$Fumé}#"")*$TbDilutionsTriées{$Fumé})+(Num:C11($TbDilutionsTriées{$Fumé}="")*"NaN")
						APPEND TO ARRAY:C911(TbPJMailRaema;$AjoutPJ)
					End for 
					$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+5
					
					  // Passons aux échantillons
					$Salé:=$Salé+5
					ARRAY TEXT:C222($TbEch;5)
					ARRAY TEXT:C222($TbEchTriés;5)
					VarResumeRes:=VarResumeRes+$NomDuGermeCourant+$Methode+<>ZCR
					For ($Fumé;1;5)
						$Rang:=$Salé+$Fumé-1
						$NomChamp:="Champ"+Replace string:C233(<>TbRefLigne{$Rang};NumCampagneCourante;"")
						$TbEch{$Fumé}:=WebTrouveValeurParNom ($NomChamp;->TbNomsP3;->TbValeursP3)
						$xxx:=String:C10($Fumé)+"xxx"
						$NomDeLigneCourante:=(Num:C11(LangueCourante="A")*Replace string:C233(<>TbNomLigneA{$Rang};$xxx;TbNumEch{$Fumé}))
						$NomDeLigneCourante:=$NomDeLigneCourante+(Num:C11(LangueCourante="F")*Replace string:C233(<>TbNomLigneF{$Rang};$xxx;TbNumEch{$Fumé}))
						If ($TbEch{$Fumé}="")  // Il n'a pas rempli
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+RaemaTraducUtiliseTableau (74)+<>ZCRWeb  // Valeur non spécifiée
						Else 
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+$TbEch{$Fumé}+<>ZCRWeb  // Valeur spécifiée
						End if 
						VarResumeRes:=VarResumeRes+<>ZTab+TbNumEch{$Fumé}+<>ZTab+$TbEch{$Fumé}+<>ZCR
						$LigneTriée:=Find in array:C230(TbNumEchT;TbNumEch{$Fumé})
						$TbEchTriés{$LigneTriée}:=$TbEch{$Fumé}
						APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
					End for 
					  // Attribution des valeurs de concentration à la PJ
					For ($Fumé;1;5)
						$AjoutPJ:=(Num:C11($TbEchTriés{$Fumé}#"")*$TbEchTriés{$Fumé})+(Num:C11($TbEchTriés{$Fumé}="")*"NaN")
						APPEND TO ARRAY:C911(TbPJMailRaema;$AjoutPJ)
					End for 
					$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+5
					$Salé:=$Salé+4
					
				Else   // Pas de dilution donc germes avec présence / absence dans PUM : il faut remettre les échantillons dans le bon ordre
					
					ARRAY TEXT:C222($TbEch;5)
					ARRAY TEXT:C222($TbEchTriés;5)
					VarResumeRes:=VarResumeRes+$NomDuGermeCourant+$Methode+<>ZCR
					For ($Fumé;1;5)
						$NbValeurs:=Num:C11(<>TbNbValeurs{$Salé})
						$Salé:=$Salé+$NbValeurs-1  // Ajustement de la ligne aux nombres de valeurs possibles du PUM
						$Rang:=$Salé+$Fumé-1
						$NomChamp:="PUM"+Replace string:C233(<>TbRefLigne{$Rang};NumCampagneCourante;"")
						$TbEch{$Fumé}:=WebTrouveValeurParNom ($NomChamp;->TbNomsP3;->TbValeursP3)
						$xxx:=String:C10($Fumé)+"xxx"
						$NomDeLigneCourante:=(Num:C11(LangueCourante="A")*Replace string:C233(<>TbNomLigneA{$Rang};$xxx;TbNumEch{$Fumé}))
						$NomDeLigneCourante:=$NomDeLigneCourante+(Num:C11(LangueCourante="F")*Replace string:C233(<>TbNomLigneF{$Rang};$xxx;TbNumEch{$Fumé}))
						If ($TbEch{$Fumé}="")  // Il n'a pas rempli
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+RaemaTraducUtiliseTableau (74)+<>ZCRWeb  // Valeur non spécifiée
						Else 
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+$TbEch{$Fumé}+<>ZCRWeb  // Valeur spécifiée
						End if 
						VarResumeRes:=VarResumeRes+<>ZTab+TbNumEch{$Fumé}+<>ZTab+$TbEch{$Fumé}+<>ZCR
						$LigneTriée:=Find in array:C230(TbNumEchT;TbNumEch{$Fumé})
						$TbEchTriés{$LigneTriée}:=$TbEch{$Fumé}
						APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
					End for 
					  // Attribution des valeurs de dilution
					For ($Fumé;1;5)
						$LPUM:=Num:C11(Substring:C12($TbEchTriés{$Fumé};1;4))
						$AjoutPJ:=(Num:C11($LPUM>0)*String:C10($LPUM))+(Num:C11($LPUM<1)*"NaN")
						APPEND TO ARRAY:C911(TbPJMailRaema;$AjoutPJ)
					End for 
					$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+5
					$Salé:=$Salé+4
				End if 
				
			Else   // Ligne autre que celle d'un échantillon
				If (<>TbMultiple{$Salé}="")  // Le schéma prévoit une réponse dans le champ de la colonne 3
					$Champ:=Replace string:C233(<>TbRefLigne{$Salé};NumCampagneCourante;"Champ")
					$L:=Find in array:C230(TbNomsP3;$Champ)
					ValeurProposée:=TbValeursP3{$L}  // Recueillons sa valeur
					Case of 
						: (ValeurProposée="")  // Rien de noté
							APPEND TO ARRAY:C911(TbPJMailRaema;"NaN")
							$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+1
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+RaemaTraducUtiliseTableau (74)+<>ZCRWeb  // Valeur non spécifiée
							APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
							If ($PasEscamotable)  // Inutile de l'alarmer si la ligne n'est pas visible
								PasBien:=True:C214
								$MotifAttention:=RaemaTraducUtiliseTableau (79)+$NomDeLigneCourante
								APPEND TO ARRAY:C911(TbMotifAttention;$MotifAttention)
							End if 
							
						: (<>TbNomLigneF{$Salé}="@date@") | (<>TbNomLigneF{$Salé}="@/a@")  // C'est une date
							$DateValeur:=Date:C102(ValeurProposée)
							Case of 
								: (ValeurProposée="")  // Il n'a pas rempli la date
									APPEND TO ARRAY:C911(TbPJMailRaema;"NaN")
									$AjoutCorpMail:=$NomDeLigneCourante+" : "+RaemaTraducUtiliseTableau (74)+<>ZCRWeb  // Valeur non spécifiée
									APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
									PasBien:=True:C214
									$MotifAttention:=RaemaTraducUtiliseTableau (79)+$NomDeLigneCourante
									APPEND TO ARRAY:C911(TbMotifAttention;$MotifAttention)
									
								: ($DateValeur=!00-00-00!)  // il a rempli avec une date qui n'existe pas
									MauvaisSyntaxe:=True:C214
									MotifRefus:=MotifRefusD ($NomDeLigneCourante)
									
								Else 
									APPEND TO ARRAY:C911(TbPJMailRaema;String:C10($DateValeur-!1904-01-01!))
									$AjoutCorpMail:=$NomDeLigneCourante+" : "+ValeurProposée+<>ZCRWeb  // Valeur  spécifiée
									APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
									
							End case 
							$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+1
							
						Else   // C'est un numérique 
							
							If (String:C10(Num:C11(ValeurProposée))#ValeurProposée) & (ValeurProposée#"") & ($PasEscamotable)
								  // Erreur numérique
								MauvaisSyntaxe:=True:C214
								MotifRefus:=MotifRefusN ($NomDeLigneCourante)
							Else 
								APPEND TO ARRAY:C911(TbPJMailRaema;ValeurProposée)
								$AjoutCorpMail:=$NomDeLigneCourante+" : "+ValeurProposée+<>ZCRWeb  // Valeur  spécifiée
								APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
							End if 
							$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+1
					End case 
					
				Else   // Le schéma prévoit une réponse sous forme de PUM ou CaC dans la colonne 2 et une précision dans  la colonne 3
					$NbValeurs:=Num:C11(<>TbNbValeurs{$Salé})
					If (<>TbMultiple{$Salé}="M")  // Le schéma prévoit une réponse sous forme de PUM ou CaC dans la colonne 2
						$PUM:=Replace string:C233(<>TbRefLigne{$Salé};NumCampagneCourante;"PUM")
						$L:=Find in array:C230(TbNomsP3;$PUM)
						If ($L>0)
							ValeurProposée:=TbValeursP3{$L}  // Recueillons sa valeur
						End if 
						If (<>TbNomLigneF{$Salé}="Méthode@")  // Notons le nom de la méthode dans le champ descriptif de la PJ à l'AR
							$Methode:=(Num:C11(LangueCourante="A")*" by the method ")+(Num:C11(LangueCourante="F")*" par la méthode ")
							$Methode:=$Methode+WebTrouveValeurParNom (("PUM"+$IndiceLigneCourante);->TbNomsP3;->TbValeursP3)
						End if 
						$RangPUMN:=Num:C11(Substring:C12(ValeurProposée;1;4))+1
						If ($RangPUMN=1)  // Il n'a pas choisi dans le PUM
							$AjoutPJ:="NaN"
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+RaemaTraducUtiliseTableau (74)+<>ZCRWeb  // Valeur non  spécifiée
							$MotifAttention:=RaemaTraducUtiliseTableau (79)+$NomDeLigneCourante
							APPEND TO ARRAY:C911(TbMotifAttention;$MotifAttention)
						Else 
							$AjoutPJ:=String:C10($RangPUMN)
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+ValeurProposée+<>ZCRWeb  // Valeur  spécifiée
						End if 
						APPEND TO ARRAY:C911(TbPJMailRaema;$AjoutPJ)
						APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
						$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+1
						
						
					Else   // Multiple non PUM = Case à cocher
						$NbreDeCase:=Num:C11(<>TbNbValeurs{$Salé})
						$CodeCases:=""
						$TexteCases:=(Num:C11(LangueCourante="A")*<>TbNomLigneA{$Salé})+(Num:C11(LangueCourante="F")*<>TbNomLigneF{$Salé})+" : "
						For ($Fumé;1;$NbreDeCase)
							$Rang:=$Salé+$Fumé-1
							$Ponctuation:=(Num:C11($Fumé<$NbreDeCase)*", ")+(Num:C11($Fumé=$NbreDeCase)*".")
							$NomCase:="case"+Replace string:C233(<>TbRefLigne{$Rang};NumCampagneCourante;"")+String:C10($Fumé)
							$IntituleCase:=(Num:C11(LangueCourante="A")*<>TbNomValeurA{$Rang})+(Num:C11(LangueCourante="F")*<>TbNomValeurF{$Rang})
							If (Find in array:C230(TbNomsP3;$NomCase)>0)
								$CodeCases:=$CodeCases+"1"
								$TexteCases:=$TexteCases+$IntituleCase+"(+)"+$Ponctuation
							Else 
								$CodeCases:=$CodeCases+"0"
								$TexteCases:=$TexteCases+$IntituleCase+"(-)"+$Ponctuation
							End if 
						End for 
						APPEND TO ARRAY:C911(TbPJMailRaema;$CodeCases)
						APPEND TO ARRAY:C911(TbTexteResume;$TexteCases)
						$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+1
					End if 
					
					  // Dans les deux cas, notons le champ de précision s'il existe
					$Champ:=Replace string:C233(<>TbRefLigne{$Salé};NumCampagneCourante;"Champ")
					$L:=Find in array:C230(TbNomsP3;$Champ)
					If ($L>0)
						$Valeur:=TbValeursP3{$L}
						If ($Valeur="")
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+RaemaTraducUtiliseTableau (74)+<>ZCRWeb  // Valeur  non spécifiée = 74
							$AjoutPJ:="NaN"
						Else 
							$AjoutCorpMail:=$NomDeLigneCourante+" : "+$Valeur+RaemaTraducUtiliseTableau (73)+<>ZCRWeb  // Valeur  non spécifiée = 74
							$AjoutPJ:=Replace string:C233($Valeur;<>ZTab;" ")
							$AjoutPJ:=Replace string:C233($AjoutPJ;<>ZCR;" ")
						End if 
						APPEND TO ARRAY:C911(TbPJMailRaema;$AjoutPJ)  // Ajoutons sa valeur épurée des concurents des séparateurs de valeurs
						APPEND TO ARRAY:C911(TbTexteResume;$AjoutCorpMail)
						$NbreTabFichierEnvoi:=$NbreTabFichierEnvoi+1
					End if 
					$Salé:=$Salé+$NbValeurs-1
				End if 
			End if 
		End if 
		
		If (MauvaisSyntaxe)
			$Salé:=$FT  // sortie de boucle pour signaler la chose tout de suite
		End if 
		
	End for 
	
	$H2:=Milliseconds:C459
	  // ALERTE(Chaîne($H2-$H1))
	WebActualiseConnexionSaisie (NumLaboActuelA;4)  // écriture la connexion Web avec envoi
	
	Case of 
		: (MauvaisSyntaxe)  // erreur de syntaxe : obligeons le à rectifier
			$Ecran:=RaemaTraducUtiliseTableau (82)  // Texte d'alerte en différentes langues
			WEB SEND FILE:C619($Ecran)
			
		: (PasBien)  //Manque de saisie : signalons la chose à l'utilisateur
			ResP3TraitementLignesP3OkKo 
			
		Else   // TVB : envoyons le mail à l'asa pour information en retour
			ResP3EnvoiMailAsa 
			
	End case 
End if 
