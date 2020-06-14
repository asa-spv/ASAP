//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/06/18, 19:26:42
  // ----------------------------------------------------
  // Méthode : ASAPImporteAdherents
  // Description
  // méthode pour récupérer les [Adhérents] de GA
  //  avec dispaching des adresses
  // ----------------------------------------------------
C_TEXT:C284($Var)
C_DATE:C307($Date)
C_TIME:C306($Doc)
C_LONGINT:C283($Fumé;$Pos;$FT;$TT)
  // Import préalable des colis sup avec rapport
  // pour désigner les RAEMA liés
ARRAY TEXT:C222($TbNumRaemaLaboSaisie;0)
ARRAY TEXT:C222($TbNumRaemaLaboOrigine;0)
ARRAY TEXT:C222($TbCodeSaisie;0)
QUERY:C277([XData:1];[XData:1]XNom:2="PoudresSupAR";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="PoudresSupAR")
ZBlobVersVariable (->[XData:1]XBlob:13;->$TbNumRaemaLaboOrigine;->$TbNumRaemaLaboSaisie;->$TbCodeSaisie)
If (Records in selection:C76([XData:1])=0) | (Size of array:C274($TbNumRaemaLaboSaisie)=0)
	ALERT:C41("Il faut d'abord importer les colis sup avec rapport")
Else 
	
	READ WRITE:C146([Personnes:12])  // pour le cas où on modifie un adhérent
	
	$Doc:=Open document:C264("";Mode lecture:K24:5)
	If (OK=1)
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		If (Ligne#"Adhérents@")
			ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux Adhérents de GestAsa")
		Else 
			
			$Pos:=Position:C15("_";Ligne)
			$TT:=Num:C11(Substring:C12(Ligne;($Pos+1)))
			$debutLigne:=Substring:C12(Ligne;1;($Pos-1))
			$FT:=Num:C11(Substring:C12($debutLigne;9))
			
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
			$Rapport:=""
			
			For ($Fumé;1;$FT)
				ARRAY TEXT:C222($TbDescription;$TT)  // recueil des valeurs exportées
				$SFT:=Size of array:C274($TbDescription)-1
				For ($Salé;1;$SFT)
					YImportFichierLitColonne (->$TbDescription;$Salé)
				End for 
				$TbDescription{$SFT+1}:=Ligne
				
				If (Find in array:C230($TbNumRaemaLaboSaisie;$TbDescription{29})<0)  // On élimine ainsi les laboratoires bidons Raema liés 
					$Labo:=($TbDescription{21}="Vrai")  //21 Laboratoire Booléen
					$Individu:=Not:C34($Labo)
					If ($Individu) & ($TbDescription{19}="") & ($TbDescription{31}="")
						$Rapport:=$Rapport+"L'adhérent "+$TbDescription{2}+" n'a pas été importé."+<>ZCR
					Else 
						If ($TbDescription{31}#"")  // laboratoire
							QUERY:C277([Personnes:12];[Personnes:12]Identificateur:4=$TbDescription{31})  //  même code saisie RAEMA
						Else 
							QUERY:C277([Personnes:12];[Personnes:12]NomLong:2=$TbDescription{2};*)  // le nom de l'adhérent
							QUERY BY ATTRIBUTE:C1331([Personnes:12]; & [Personnes:12]Arguments:7;"Prénom";=;$TbDescription{19})  // le prénom de l'adhérent
						End if 
						If (Records in selection:C76([Personnes:12])=0)
							CREATE RECORD:C68([Personnes:12])
						End if 
						  // quelle qu'en soit la nature
						If ($TbDescription{31}="")
							VarNumLaboRAEMA:=0
							VarNumPersonne:=Num:C11($TbDescription{1})
							[Personnes:12]Identificateur:4:=GAInitIdentificateurPersonne 
						Else 
							[Personnes:12]Identificateur:4:=$TbDescription{31}
						End if 
						[Personnes:12]NomCourt:3:=$TbDescription{59}  // 59 NomEnvoi Alpha 35
						[Personnes:12]NomLong:2:=$TbDescription{2}  //2IdentitéAdhérentAlpha 80
						[Personnes:12]TypePersonne:5:=(Num:C11($Labo)*"Laboratoire")+(Num:C11(Not:C34($Labo))*"Individu")
						[Personnes:12]Caduc:8:=($TbDescription{34}="Vrai")
						YRemplitObjet (->[Personnes:12]Arguments:7;"Association";$TbDescription{15})  //15  Association  Alpha 80
						YRemplitObjet (->[Personnes:12]Arguments:7;"BoiteIsotherme";$TbDescription{53})  //53 BoiteIsotherme Entier
						YRemplitObjet (->[Personnes:12]Arguments:7;"Civilités";$TbDescription{20})  //20 Civilités Alpha 12
						YRemplitObjet (->[Personnes:12]Arguments:7;"EMail";$TbDescription{17})  //17 EMail Texte
						YRemplitObjet (->[Personnes:12]Arguments:7;"EMailBis";$TbDescription{42})  //42 EMailBis Texte
						YRemplitObjet (->[Personnes:12]Arguments:7;"PhonePro";$TbDescription{13})  //13 TéléphonePro Réel
						YRemplitObjet (->[Personnes:12]Arguments:7;"FaxPro";$TbDescription{14})  //14 FaxPro Réel
						YRemplitObjet (->[Personnes:12]Arguments:7;"NumFacturation";$TbDescription{16})  //16NumFacturationEntier long
						YRemplitObjet (->[Personnes:12]Arguments:7;"Prénom";$TbDescription{19})  //19 Prénom Alpha 20
						YRemplitObjet (->[Personnes:12]Arguments:7;"NomCourtLabo";$TbDescription{23})  //23 NomCourtLabo Alpha 10
						YRemplitObjet (->[Personnes:12]Arguments:7;"NumClient";$TbDescription{24})  //24 NumClient Alpha 20
						YRemplitObjet (->[Personnes:12]Arguments:7;"MotDePasse";$TbDescription{26})  //26 MotDePasse Alpha 80
						YRemplitObjet (->[Personnes:12]Arguments:7;"EMailInternet";$TbDescription{27})  //27 EMailInternet Texte
						YRemplitObjet (->[Personnes:12]Arguments:7;"Société";$TbDescription{28})  //28 Société Alpha 80
						YRemplitObjet (->[Personnes:12]Arguments:7;"NomContact";$TbDescription{30})  //30 NomContact Alpha 80
						YRemplitObjet (->[Personnes:12]Arguments:7;"NumTVAIntraCom";$TbDescription{32})  //32  NumTVAIntraCom Alpha 20
						YRemplitObjet (->[Personnes:12]Arguments:7;"Portable";$TbDescription{33})  //33 Portable Réel
						  // YRemplitObjet (->[Personnes]Arguments;"Caduc";($TbDescription{34}="Vrai"))  //34 Caduc Booléen
						
						  // OB SUPPRIMER([Personnes]Arguments;"Caduc")
						YRemplitObjet (->[Personnes:12]Arguments:7;"Remarques";$TbDescription{35})  //35 Remarques Texte
						YRemplitObjet (->[Personnes:12]Arguments:7;"TelephonePerso";$TbDescription{36})  //36 TelephonePerso Réel
						YRemplitObjet (->[Personnes:12]Arguments:7;"FaxPerso";$TbDescription{37})  //37 FaxPerso Réel
						YRemplitObjet (->[Personnes:12]Arguments:7;"TelephoneContact";$TbDescription{38})  //38 TelephoneContact Alpha 30
						YRemplitObjet (->[Personnes:12]Arguments:7;"EtatProvince";$TbDescription{39})  //39 EtatProvince Alpha 30
						YRemplitObjet (->[Personnes:12]Arguments:7;"UPSConforme";$TbDescription{40})  //40 UPSConforme Entier
						YRemplitObjet (->[Personnes:12]Arguments:7;"EmailRAEMA";$TbDescription{43})  //43 EmailRAEMA Texte
						YRemplitObjet (->[Personnes:12]Arguments:7;"NbrePoudreSupMars";$TbDescription{44})  //44 NbrePoudreSupMars Entier long
						  // YRemplitObjet (->[Personnes]Arguments;"NumRAEMALié";$TbDescription{45})  //45 NumRAEMALié Alpha 255
						YRemplitObjet (->[Personnes:12]Arguments:7;"CodeFacturation";$TbDescription{46})  //46 CodeFacturation Alpha 20
						YRemplitObjet (->[Personnes:12]Arguments:7;"NbrePoudreSupOctobre";$TbDescription{47})  //47 NbrePoudreSupOctobre Entier
						YRemplitObjet (->[Personnes:12]Arguments:7;"NumBonCommandePoudre";$TbDescription{48})  //48 NumBonCommandePoudre Alpha 55
						YRemplitObjet (->[Personnes:12]Arguments:7;"SansPathogenes";$TbDescription{50})  //50 SansPathogenes Booléen
						YRemplitObjet (->[Personnes:12]Arguments:7;"ModeEnvoiColis";$TbDescription{51})  //51 ModeEnvoiColis Alpha 25
						YRemplitObjet (->[Personnes:12]Arguments:7;"PayeDeuxFois";$TbDescription{52})  //52 PayeDeuxFois Booléen
						YRemplitObjet (->[Personnes:12]Arguments:7;"FacturationSpeciale";$TbDescription{54})  //54 FacturationSpeciale Booléen
						YRemplitObjet (->[Personnes:12]Arguments:7;"FacturationPays";$TbDescription{55})  //55 FacturationPays Alpha 10
						YRemplitObjet (->[Personnes:12]Arguments:7;"NbrePotSupGelSansRapport";$TbDescription{56})  //56 NbrePotSupGelSansRapport Entier
						YRemplitObjet (->[Personnes:12]Arguments:7;"Proforma";$TbDescription{57})  //57 Proforma Alpha 10
						YRemplitObjet (->[Personnes:12]Arguments:7;"NbrePotSupGelAvecRapport";$TbDescription{58})  //58 NbrePotSupGelAvecRapport Entier
						YRemplitObjet (->[Personnes:12]Arguments:7;"NumBonCommandeGel";$TbDescription{60})  //60 NumBonCommandeGel Alpha 55
						YRemplitObjet (->[Personnes:12]Arguments:7;"UUID";$TbDescription{61})  //61 UUID
						YRemplitObjet (->[Personnes:12]Arguments:7;"NonSoumisTVA";$TbDescription{62})  //62 NonSoumisTVA Booléen
						YRemplitObjet (->[Personnes:12]Arguments:7;"NonSoumisCotisation";$TbDescription{63})  //63 NonSoumisCotisation Booléen
						YRemplitObjet (->[Personnes:12]Arguments:7;"PrixTransporteur";$TbDescription{64})  //64 NonSoumisCotisation Booléen
						YRemplitObjet (->[Personnes:12]Arguments:7;"TransportPayant";$TbDescription{65})  //65 NonSoumisCotisation Booléen
						
						
						  // traitement des Raema liés
						If ([Personnes:12]TypePersonne:5="Laboratoire")
							$L:=0
							ARRAY TEXT:C222($TbCodeRL;0)
							ARRAY LONGINT:C221($TbNumLaboRAEMAN;0)
							Repeat 
								$L:=Find in array:C230($TbNumRaemaLaboOrigine;$TbDescription{29};($L+1))
								If ($L>0)
									$NumLaboRAEMAN:=RAEMADemoduleMdPWeb ($TbCodeSaisie{$L})
									If (Find in array:C230($TbNumLaboRAEMAN;$NumLaboRAEMAN)<0)
										APPEND TO ARRAY:C911($TbCodeRL;$TbCodeSaisie{$L})
										APPEND TO ARRAY:C911($TbNumLaboRAEMAN;$NumLaboRAEMAN)
									End if 
								End if 
							Until ($L<0)
							If (Size of array:C274($TbCodeRL)>0)
								$NumRL:=ZTableauVersTexte (->$TbCodeRL;";")
								YRemplitObjet (->[Personnes:12]Arguments:7;"TbCodesRAEMALiés";$NumRL)  //65 NonSoumisCotisation Booléen
							End if 
						End if 
						OB REMOVE:C1226([Personnes:12]Arguments:7;"NumRAEMALiés")
						
						If ([Personnes:12]NomLong:2#"")
							SAVE RECORD:C53([Personnes:12])
						End if 
						  // Traitement des adresse
						
						RELATE MANY:C262([Personnes:12]UUID:1)  // Rappel des adresses
						SELECTION TO ARRAY:C260([PersonnesAdresses:11]TypeAdresse:9;$TbTypeAdresse)
						LONGINT ARRAY FROM SELECTION:C647([PersonnesAdresses:11];$TbNumEnrAdresse)
						
						  // Les adresses personnelles
						$L:=Find in array:C230($TbTypeAdresse;"Personnelle")
						If ($L>0)
							GOTO RECORD:C242([PersonnesAdresses:11];$TbNumEnrAdresse{$L})
						Else 
							If ($TbDescription{3}#"")  // 3 AdressePersonnelle Texte
								CREATE RECORD:C68([PersonnesAdresses:11])
								[PersonnesAdresses:11]UUIDPersonne:2:=[Personnes:12]UUID:1
								[PersonnesAdresses:11]TypeAdresse:9:="Personnelle"
								ARRAY TEXT:C222($TbAdresse;0)
								$AdresseFacturation:=$TbDescription{3}  // 3 AdressePersonnelle Texte
								$Pos:=Position:C15("£";$AdresseFacturation)
								While ($Pos>0)
									APPEND TO ARRAY:C911($TbAdresse;Substring:C12($AdresseFacturation;1;($Pos-1)))
									$AdresseFacturation:=Substring:C12($AdresseFacturation;($Pos+1))
									$Pos:=Position:C15("£";$AdresseFacturation)
								End while 
								APPEND TO ARRAY:C911($TbAdresse;$AdresseFacturation)
								If (Size of array:C274($TbAdresse)>0)
									[PersonnesAdresses:11]LigneAdresse1:3:=$TbAdresse{1}
									If (Size of array:C274($TbAdresse)>1)
										[PersonnesAdresses:11]LigneAdresse2:4:=$TbAdresse{2}
										If (Size of array:C274($TbAdresse)>2)
											[PersonnesAdresses:11]LigneAdresse3:5:=$TbAdresse{3}
										End if 
									End if 
								End if 
								[PersonnesAdresses:11]CodePostal:6:=$TbDescription{4}  // 4 CodePostalPersonnel Alpha 5
								[PersonnesAdresses:11]Ville:7:=$TbDescription{5}  // 5 LocalitéPersonnelle Alpha 80
								[PersonnesAdresses:11]Pays:8:=$TbDescription{12}  //12 PaysAlpha 80
								SAVE RECORD:C53([PersonnesAdresses:11])
							End if 
						End if 
						
						  // Les adresses de livraison
						If ($Labo)
							$L:=Find in array:C230($TbTypeAdresse;"Livraison")
							If ($L>0)
								GOTO RECORD:C242([PersonnesAdresses:11];$TbNumEnrAdresse{$L})
							Else 
								If ($TbDescription{6}#"")  // 6 AdresseProfessionnelle Texte
									CREATE RECORD:C68([PersonnesAdresses:11])
									[PersonnesAdresses:11]UUIDPersonne:2:=[Personnes:12]UUID:1
									[PersonnesAdresses:11]TypeAdresse:9:="Livraison"
									ARRAY TEXT:C222($TbAdresse;0)
									$AdresseFacturation:=$TbDescription{6}  // 6 AdresseProfessionnelle Texte
									$Pos:=Position:C15("£";$AdresseFacturation)
									While ($Pos>0)
										APPEND TO ARRAY:C911($TbAdresse;Substring:C12($AdresseFacturation;1;($Pos-1)))
										$AdresseFacturation:=Substring:C12($AdresseFacturation;($Pos+1))
										$Pos:=Position:C15("£";$AdresseFacturation)
									End while 
									APPEND TO ARRAY:C911($TbAdresse;$AdresseFacturation)
									If (Size of array:C274($TbAdresse)>0)
										[PersonnesAdresses:11]LigneAdresse1:3:=$TbAdresse{1}
										If (Size of array:C274($TbAdresse)>1)
											[PersonnesAdresses:11]LigneAdresse2:4:=$TbAdresse{2}
											If (Size of array:C274($TbAdresse)>2)
												[PersonnesAdresses:11]LigneAdresse3:5:=$TbAdresse{3}
											End if 
										End if 
									End if 
									[PersonnesAdresses:11]CodePostal:6:=$TbDescription{7}  // 7 CodePostalProfessionnel Alpha 5
									[PersonnesAdresses:11]Ville:7:=$TbDescription{8}  // 8 LocalitéProfessionnelle Alpha 80
									[PersonnesAdresses:11]Pays:8:=$TbDescription{12}  //12 PaysAlpha 80
									SAVE RECORD:C53([PersonnesAdresses:11])
								End if 
							End if 
						End if 
						
						  // Les adresses de livraison
						If (Not:C34($Labo))
							$L:=Find in array:C230($TbTypeAdresse;"Professionnelle")
							If ($L>0)
								GOTO RECORD:C242([PersonnesAdresses:11];$TbNumEnrAdresse{$L})
							Else 
								If ($TbDescription{6}#"")  // 6 AdresseProfessionnelle Texte
									CREATE RECORD:C68([PersonnesAdresses:11])
									[PersonnesAdresses:11]UUIDPersonne:2:=[Personnes:12]UUID:1
									[PersonnesAdresses:11]TypeAdresse:9:="Professionnelle"
									ARRAY TEXT:C222($TbAdresse;0)
									$AdresseFacturation:=$TbDescription{6}  // 6 AdresseProfessionnelle Texte
									$Pos:=Position:C15("£";$AdresseFacturation)
									While ($Pos>0)
										APPEND TO ARRAY:C911($TbAdresse;Substring:C12($AdresseFacturation;1;($Pos-1)))
										$AdresseFacturation:=Substring:C12($AdresseFacturation;($Pos+1))
										$Pos:=Position:C15("£";$AdresseFacturation)
									End while 
									APPEND TO ARRAY:C911($TbAdresse;$AdresseFacturation)
									If (Size of array:C274($TbAdresse)>0)
										[PersonnesAdresses:11]LigneAdresse1:3:=$TbAdresse{1}
										If (Size of array:C274($TbAdresse)>1)
											[PersonnesAdresses:11]LigneAdresse2:4:=$TbAdresse{2}
											If (Size of array:C274($TbAdresse)>2)
												[PersonnesAdresses:11]LigneAdresse3:5:=$TbAdresse{3}
											End if 
										End if 
									End if 
									[PersonnesAdresses:11]CodePostal:6:=$TbDescription{7}  // 7 CodePostalProfessionnel Alpha 5
									[PersonnesAdresses:11]Ville:7:=$TbDescription{8}  // 8 LocalitéProfessionnelle Alpha 80
									[PersonnesAdresses:11]Pays:8:=$TbDescription{12}  //12 PaysAlpha 80
									SAVE RECORD:C53([PersonnesAdresses:11])
								End if 
							End if 
						End if 
						
						
						  // Les adresses de facturation
						$L:=Find in array:C230($TbTypeAdresse;"Facturation")
						If ($L>0)
							GOTO RECORD:C242([PersonnesAdresses:11];$TbNumEnrAdresse{$L})
						Else 
							If ($TbDescription{9}#"")  // 9 AdresseFacturation Texte
								CREATE RECORD:C68([PersonnesAdresses:11])
								[PersonnesAdresses:11]UUIDPersonne:2:=[Personnes:12]UUID:1
								[PersonnesAdresses:11]TypeAdresse:9:="Facturation"
								ARRAY TEXT:C222($TbAdresse;0)
								$AdresseFacturation:=$TbDescription{9}  // 9 AdresseFacturation Texte
								$Pos:=Position:C15("£";$AdresseFacturation)
								While ($Pos>0)
									APPEND TO ARRAY:C911($TbAdresse;Substring:C12($AdresseFacturation;1;($Pos-1)))
									$AdresseFacturation:=Substring:C12($AdresseFacturation;($Pos+1))
									$Pos:=Position:C15("£";$AdresseFacturation)
								End while 
								APPEND TO ARRAY:C911($TbAdresse;$AdresseFacturation)
								If (Size of array:C274($TbAdresse)>0)
									[PersonnesAdresses:11]LigneAdresse1:3:=$TbAdresse{1}
									If (Size of array:C274($TbAdresse)>1)
										[PersonnesAdresses:11]LigneAdresse2:4:=$TbAdresse{2}
										If (Size of array:C274($TbAdresse)>2)
											[PersonnesAdresses:11]LigneAdresse3:5:=$TbAdresse{3}
										End if 
									End if 
								End if 
								[PersonnesAdresses:11]CodePostal:6:=$TbDescription{10}  //10 CodePostalFacturation Alpha 5
								[PersonnesAdresses:11]Ville:7:=$TbDescription{11}  // 11 LocalitéFacturation Alpha 80
								[PersonnesAdresses:11]Pays:8:=$TbDescription{49}  //49 PaysFacturation Alpha 60
								SAVE RECORD:C53([PersonnesAdresses:11])
							End if 
						End if 
					End if 
				End if 
				
				RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
				
			End for 
			
			CLOSE DOCUMENT:C267($Doc)
		End if 
		
		  // attribution du champ recherche
		ALL RECORDS:C47([Personnes:12])
		APPLY TO SELECTION:C70([Personnes:12];[Personnes:12]ChampRecherche:6:=ASAPPerCreationChampRecherche )
		
	End if 
	
	QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Testeur")
	If (Records in selection:C76([Personnes:12])=0)
		CREATE RECORD:C68([Personnes:12])
		[Personnes:12]NomLong:2:="Testeur"
		[Personnes:12]TypePersonne:5:="Testeur"
		[Personnes:12]Identificateur:4:="FuQPRPqSYE"
		SAVE RECORD:C53([Personnes:12])
	End if 
	
	ZAmnistieInternationale 
	ALERT:C41("Import des Personnes achevé")
	SET TEXT TO PASTEBOARD:C523($Rapport)
	
End if 


ASAPFabriqueTbPersonnes 
If (False:C215)
	  //$TbDescription{1} = NumAdhérent
	  //$TbDescription{2} = IdentitéAdhérent
	  //$TbDescription{3} = AdressePersonnelle
	  //$TbDescription{4} = CodePostalPersonnel
	  //$TbDescription{5} = LocalitéPersonnelle
	  //$TbDescription{6} = AdresseProfessionnelle
	  //$TbDescription{7} = CodePostalProfessionnel
	  //$TbDescription{8} = LocalitéProfessionnelle
	  //$TbDescription{9} = AdresseFacturation
	  //$TbDescription{10} = CodePostalFacturation
	  //$TbDescription{11} = LocalitéFacturation
	  //$TbDescription{12} = Pays
	  //$TbDescription{13} = TéléphonePro
	  //$TbDescription{14} = FaxPro
	  //$TbDescription{15} = Association
	  //$TbDescription{16} = NumFacturation
	  //$TbDescription{17} = EMail
	  //$TbDescription{18} = AJour
	  //$TbDescription{19} = Prénom
	  //$TbDescription{20} = Civilités
	  //$TbDescription{21} = Laboratoire
	  //$TbDescription{22} = RAEMA
	  //$TbDescription{23} = NomCourtLabo
	  //$TbDescription{24} = NumClient
	  //$TbDescription{25} = AdhérentModifié
	  //$TbDescription{26} = MotDePasse
	  //$TbDescription{27} = EMailInternet
	  //$TbDescription{28} = Société
	  //$TbDescription{29} = NumRAEMA
	  //$TbDescription{30} = NomContact
	  //$TbDescription{31} = CodeSaisieRAEMA
	  //$TbDescription{32} = NumTVAIntraCom
	  //$TbDescription{33} = Portable
	  //$TbDescription{34} = Caduc
	  //$TbDescription{35} = Remarques
	  //$TbDescription{36} = TelephonePerso
	  //$TbDescription{37} = FaxPerso
	  //$TbDescription{38} = TelephoneContact
	  //$TbDescription{39} = EtatProvince
	  //$TbDescription{40} = UPSConforme
	  //$TbDescription{41} = NumRAEMAEntier
	  //$TbDescription{42} = EMailBis
	  //$TbDescription{43} = EmailRAEMA
	  //$TbDescription{44} = NbrePoudreSupMars
	  //$TbDescription{45} = NumRAEMALié
	  //$TbDescription{46} = CodeFacturation
	  //$TbDescription{47} = NbrePoudreSupOctobre
	  //$TbDescription{48} = NumBonCommandePoudre
	  //$TbDescription{49} = PaysFacturation
	  //$TbDescription{50} = SansPathogenes
	  //$TbDescription{51} = ModeEnvoiColis
	  //$TbDescription{52} = PayeDeuxFois
	  //$TbDescription{53} = BoiteIsotherme
	  //$TbDescription{54} = FacturationSpeciale
	  //$TbDescription{55} = FacturationPays
	  //$TbDescription{56} = NbrePotSupGelSansRapport
	  //$TbDescription{57} = Proforma
	  //$TbDescription{58} = NbrePotSupGelAvecRapport
	  //$TbDescription{59} = NomTransport
	  //$TbDescription{60} = NumBonCommandeGel
	  //$TbDescription{61} = ID
	  //$TbDescription{62} = NonSoumisTVA
	  //$TbDescription{63} = NonSoumisCotisation
	  //$TbDescription{64} = PrixTransporteur
	  //$TbDescription{65} = TransporteurPayant
End if 
