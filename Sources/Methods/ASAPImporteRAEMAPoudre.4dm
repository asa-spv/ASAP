//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 10:20:33
  // ----------------------------------------------------
  // Méthode : ASAPImporteRAEMAPoudre
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------


$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"6@")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux RAEMA poudre")
	Else 
		$NumCampagne:=String:C10(Num:C11(Ligne))  // Pour éliminer les tabulations
		READ WRITE:C146([CampagneParticipations:17])
		  //CHERCHER([CampagneParticipations];[CampagnesRAEMAPoudre]NumCampagne=$NumCampagne)
		  //SUPPRIMER SÉLECTION([CampagneParticipations])
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  // Les ET
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  // La première ligne
		$TT:=7
		Repeat 
			  // Fabrication du tableau de l'import
			  // $TbDescription{1} = N° Labo 
			  // $TbDescription{2} = Nb Colis SANS Cofrac
			  // $TbDescription{3} = Nb Colis AVEC Cofrac
			  // $TbDescription{4} = Transporteur
			  // $TbDescription{5} = Boîte isotherme gratuite
			  // $TbDescription{6} = Boîte isotherme payante
			  // $TbDescription{7} = Commentaire
			Ligne:=Replace string:C233(Ligne;Char:C90(10);"")
			ARRAY TEXT:C222($TbDescription;$TT)  // recueil des 7 valeurs exportées
			$SFT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$SFT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$SFT+1}:=Ligne
			
			  // Création de l'enregistrement de [CampagneParticipations]
			$NumLaboA:=$TbDescription{1}
			$NbreColisSupSansRapport:=Num:C11($TbDescription{2})
			$NbreColisSupAvecRapport:=Num:C11($TbDescription{3})
			$Transporteur:=$TbDescription{4}
			$BoîteIsothermeGratuite:=Num:C11($TbDescription{5})
			$BoîteIsothermePayante:=Num:C11($TbDescription{6})
			$Commentaire:=$TbDescription{7}
			$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumLaboA)  // Se place sur la bonne ligne
			If ($L<0)
				TRACE:C157
			Else 
				$CodelaboA:=<>TbPerIdentificateur{$L}
				QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
				QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=<>TbPerUUID{$L})
				If ($Commentaire#"assoc@")  // Le laboratoire est la référence 
					If (Records in selection:C76([CampagneParticipations:17])=0)
						CREATE RECORD:C68([CampagneParticipations:17])
						[CampagneParticipations:17]NumCampagne:3:=$NumCampagne
						[CampagneParticipations:17]UUIDPersonne:2:=<>TbPerUUID{$L}
					End if 
					If ($Transporteur#"")
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"Transporteur";$Transporteur)
					End if 
					If ($BoîteIsothermeGratuite#0)
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"BoîteIsotherme";1)
					End if 
					If ($BoîteIsothermePayante#0)
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"BoîteIsotherme";2)
					End if 
					If ($Commentaire#"") & ($Commentaire#"associ@")
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"Commentaire";$Commentaire)
					End if 
					If ($NbreColisSupSansRapport#0)
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"NbreColisSupSansRapport";$NbreColisSupSansRapport)
					End if 
					If ($NbreColisSupAvecRapport#0)
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"NbreColisSupAvecRapport";$NbreColisSupAvecRapport)
					End if 
					If (<>TbPAProforma{$L}#"")
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"Proforma";<>TbPAProforma{$L})
					Else 
						OB REMOVE:C1226([CampagneParticipations:17]Arguments:5;"Proforma")
					End if 
					If (<>TbPASansPathogenes{$L}="Vrai")
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"SansPathogène";True:C214)
					End if 
					SAVE RECORD:C53([CampagneParticipations:17])
					
					
				Else   // c'est un laboratoire virtuel RaemaLié
					
					$NumLaboOrigineA:=String:C10(Num:C11($Commentaire))
					$UUID:=WebTrouveValeurParNom ($NumLaboOrigineA;-><>TbPerNumLaboRAEMAA;-><>TbPerUUID)
					If ($UUID="")
						TRACE:C157
					End if 
					$CodelaboActuel:=WebTrouveValeurParNom ($NumLaboA;-><>TbPerNumLaboRAEMAA;-><>TbPerIdentificateur)
					QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=$UUID;*)
					QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$NumCampagne)
					If (Records in selection:C76([CampagneParticipations:17])=0)
						TRACE:C157
						CREATE RECORD:C68([CampagneParticipations:17])
						[CampagneParticipations:17]UUIDPersonne:2:=$UUID
						[CampagneParticipations:17]NumCampagne:3:=$NumCampagne
						SAVE RECORD:C53([CampagneParticipations:17])
					End if 
					$NumEnrLaboInitial:=Record number:C243([CampagneParticipations:17])
					QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=$UUID;*)
					QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
					QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";=;$CodelaboActuel)
					If (Records in selection:C76([CampagneParticipations:17])=0)
						GOTO RECORD:C242([CampagneParticipations:17];$NumEnrLaboInitial)
						DUPLICATE RECORD:C225([CampagneParticipations:17])
						[CampagneParticipations:17]UUID:1:=Generate UUID:C1066
						OB SET:C1220([CampagneParticipations:17]Arguments:5;"CodeRaemaLié";$CodelaboActuel)
						SAVE RECORD:C53([CampagneParticipations:17])
					End if 
				End if 
			End if 
			  // Au suivant
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
			
		Until (Ligne="")
		
		CLOSE DOCUMENT:C267($Doc)
	End if 
End if 

ZAmnistieInternationale 