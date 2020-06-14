//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/01/19, 16:17:31
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : ASAPFactureRAEMAGel
  // Description
  // Méthode générale permettant de facturer le RAEMA Gel

C_LONGINT:C283($Salé;$FT;$Quantité)
C_TEXT:C284($TVA)

READ WRITE:C146([Factures:15])
READ WRITE:C146([Ventes:16])
READ WRITE:C146([Personnes:12])

  // Recueil des raema concernés
$AnN:=Year of:C25(Current date:C33)
$numCampagneMai:=RaemaTrouveNumCampagneParAn ($AnN;2)
$numCampagneDec:=RaemaTrouveNumCampagneParAn ($AnN;4)

  // les ADILVA et Belges et autres exotiques ont une facturation plus bas
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"Association";#;"Adilva";*)  // Pas l'ADILVA
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"Association";#;"belges";*)  // Pas l'belges
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"Association";#;"@maroc@";*)  // Pas les marocains
QUERY:C277([Personnes:12]; & [Personnes:12]TypePersonne:5="laboratoire";*)  // un labo
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"FacturationSpeciale";#;"Vrai")  // Pas de facturation spéciale
  // CHERCHER([Personnes]; & [Personnes]Caduc=Faux)  // Pas caduc = mauvais critère car on facture selon le programme de participation

$FT:=Records in selection:C76([Personnes:12])
For ($Salé;1;$FT)
	
	  // Initalisation des tableaux les lignes de facture ([Ventes])
	ARRAY TEXT:C222(TbLFNumFacture;0)
	ARRAY TEXT:C222(TbLFIntitule;0)
	ARRAY TEXT:C222(TbLFCodePrestation;0)
	ARRAY REAL:C219(TbLFPrixHT;0)
	ARRAY REAL:C219(TbLFTauxTVA;0)
	ARRAY REAL:C219(TbLFQuantité;0)
	ARRAY REAL:C219(TbLFPrixTotalHT;0)
	ARRAY DATE:C224(TbLFDateVente;0)
	
	
	  //$NumRaema:=ASAPTrouveNumeroLaboParUUID ([Personnes]UUID)
	  //$IDParticipeMai:=$NumRaema+"_"+$numCampagneMai+"_"
	  //$IDParticipeDec:=$NumRaema+"_"+$numCampagneDec+"_"
	  //$LMai:=Chercher dans tableau(<>TbLotoIdentifiantParticipation;$IDParticipeMai)
	  //$Mai:=($LMai>0)
	  //$LDec:=Chercher dans tableau(<>TbLotoIdentifiantParticipation;$IDParticipeDec)
	  //$Dec:=($LDec>0)
	  //$UneSeule:=((Num($Mai)+Num($Dec))=1)
	  //$Quantité:=1
	
	  // selection des [CampagneParticipations] de mai
	ARRAY OBJECT:C1221($TbArgParticipe;0)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$numCampagneMai;*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
	  //  SÉLECTION RETOUR(
	If (Records in selection:C76([CampagneParticipations:17])>0)
		$Mai:=True:C214
		$NbColisSupCofrac:=0
		SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5;$TbArgParticipe)
		$Dec:=($LDec>0)
		$UneSeule:=((Num:C11($Mai)+Num:C11($Dec))=1)
		$Quantité:=1
		
		If ($Dec) | ($Mai)  // sinon aucune facturation nécessaire
			If (False:C215)
				  // Facturation de la cotisation
				$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisCotisation";Est un texte:K8:3)
				If ($TVA#"Vrai")
					ASAPCreerTbLigneFactureRaemaP ("COT";$Quantité)
				End if 
				
				  // Facturation RAEMA poudre
				
				  // Recherche dans les tableaux généraux de campagne de la participation éventuelle du laboratoire
				$NumRaema:=ASAPTrouveNumeroLaboParUUID ([Personnes:12]UUID:1)
				
				
				Case of 
					: ($Mai & $Dec)
						  //FACTURATION des deux campagnes
						ASAPCreerTbLigneFactureRaemaP ("P2C";1)
						
						  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
						If (<>TbLotoNbColisPoudreAR{$LMai}>0) & (<>TbLotoNbColisPoudreAR{$LDec}>0)  // en  Mai et en Dec
							ASAPCreerTbLigneFactureRaemaP ("P2AR";(<>TbLotoNbColisPoudreAR{$LMai}+<>TbLotoNbColisPoudreAR{$LDec})*$Quantité)
						End if 
						
						  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
						If (<>TbLotoNbColisPoudreSR{$LMai}>0) & (<>TbLotoNbColisPoudreSR{$LDec}>0)  // en  Mai et en Dec
							ASAPCreerTbLigneFactureRaemaP ("P2SR";(<>TbLotoNbColisPoudreSR{$LMai}+<>TbLotoNbColisPoudreSR{$LDec})*$Quantité)
						End if 
						
						  // FACTURATION DES BOITES ISOTHERMES
						$BoiteM:=<>TbLotoBoiteIsotherme{$LMai}
						$BoiteO:=<>TbLotoBoiteIsotherme{$LDec}
						If ($BoiteM=2) | ($BoiteO=2)
							$Code:="BOI"
							ASAPCreerTbLigneFactureRaemaP ($Code;($BoiteM+$BoiteO)*$Quantité)
						End if 
						
					: ($Mai)  // Mai seulement
						
						  //FACTURATION de la campagne de Mai
						ASAPCreerTbLigneFactureRaemaP ("P1M";$Quantité)
						
						  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
						If (<>TbLotoNbColisPoudreAR{$LMai}>0)  // en  Mai 
							ASAPCreerTbLigneFactureRaemaP ("PMAR";(<>TbLotoNbColisPoudreAR{$LMai})*$Quantité)
						End if 
						
						  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
						If (<>TbLotoNbColisPoudreSR{$LMai}>0)  // en  Mai
							ASAPCreerTbLigneFactureRaemaP ("PMSR";<>TbLotoNbColisPoudreSR{$LMai}*$Quantité)
						End if 
						
						  // FACTURATION DES BOITES ISOTHERMES
						$BoiteM:=<>TbLotoBoiteIsotherme{$LMai}
						If ($BoiteM=2)
							$Code:="BOI"
							ASAPCreerTbLigneFactureRaemaP ($Code;$BoiteM*$Quantité)
						End if 
						
					: ($Dec)
						
						  //FACTURATION de la campagne d'Dec
						ASAPCreerTbLigneFactureRaemaP ("P1O";$Quantité)
						
						  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
						If (<>TbLotoNbColisPoudreAR{$LDec}>0)  // en  Dec 
							ASAPCreerTbLigneFactureRaemaP ("PMAR";(<>TbLotoNbColisPoudreAR{$LMai})*$Quantité)
						End if 
						
						  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
						If (<>TbLotoNbColisPoudreSR{$LDec}>0)  // en  Dec
							ASAPCreerTbLigneFactureRaemaP ("PMSR";<>TbLotoNbColisPoudreSR{$LDec}*$Quantité)
						End if 
						
						  // FACTURATION DES BOITES ISOTHERMES
						$BoiteO:=<>TbLotoBoiteIsotherme{$LDec}
						If ($BoiteO=2)
							$Code:="BOI"
							ASAPCreerTbLigneFactureRaemaP ($Code;$BoiteO*$Quantité)
						End if 
						
				End case 
				
				$Frais:=OB Get:C1224([Personnes:12]Arguments:7;"PrixTransporteur";Est un numérique:K8:4)
				If ($Frais>0)
					
					APPEND TO ARRAY:C911(TbLFIntitule;"Frais de port")
					APPEND TO ARRAY:C911(TbLFPrixHT;$Frais)
					$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
					If ($TVA="Faux") & (TbLFCodePrestation{Size of array:C274(TbLFCodePrestation)}#"COT")
						APPEND TO ARRAY:C911(TbLFTauxTVA;<>PermTVA)
					Else 
						APPEND TO ARRAY:C911(TbLFTauxTVA;0)
					End if 
					APPEND TO ARRAY:C911(TbLFQuantité;1)
					APPEND TO ARRAY:C911(TbLFPrixTotalHT;$Frais)
					APPEND TO ARRAY:C911(TbLFCodePrestation;"")
				End if 
				
				  // Gestion des factures antérieures
				READ WRITE:C146([Factures:15])
				  // Obtention du prochain n° de facture
				QUERY:C277([Factures:15];[Factures:15]NumFacture:3=(<>ZPermMille+"/RT@"))  // recherche des [Factures] de Raema P de l'nnée
				SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;$TbNumFacture)
				SORT ARRAY:C229($TbNumFacture;<)
				If (Size of array:C274($TbNumFacture)=0)
					$ProchNumIndexFacture:=1
				Else 
					$ProchNumIndexFacture:=Num:C11(Substring:C12($TbNumFacture{1};5))+1
				End if 
				
				  // Recherche des factures du laboratoire
				QUERY SELECTION:C341([Factures:15];[Factures:15]UUIDPersonne:2=[Personnes:12]UUID:1)
				If (Records in selection:C76([Factures:15])=0)  // Pas de facture déjà éditée
					CREATE RECORD:C68([Factures:15])
					[Factures:15]UUIDPersonne:2:=[Personnes:12]UUID:1
					[Factures:15]NumFacture:3:=<>ZPermMille+"/RT"+String:C10($ProchNumIndexFacture;"0000")
				Else 
					READ WRITE:C146([Ventes:16])
					  // rappel des anciennes LF
					QUERY:C277([Ventes:16];[Ventes:16]NumFacture:2=[Factures:15]NumFacture:3)
					  // Suooression des anciennes LF
					DELETE SELECTION:C66([Ventes:16])
				End if 
				[Factures:15]DateFacture:4:=Current date:C33
				QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]UUID:1=[Personnes:12]UUID:1)
				QUERY:C277([PersonnesAdresses:11]; & [PersonnesAdresses:11]TypeAdresse:9="Facturation")
				[Factures:15]AdresseFacturation:5:=ASAPEcritAdresseFacturation 
				[Factures:15]CP:6:=[PersonnesAdresses:11]CodePostal:6
				If ([PersonnesAdresses:11]Pays:8="")
					[Factures:15]PaysFacturation:7:="France"
				Else 
					[Factures:15]PaysFacturation:7:=[PersonnesAdresses:11]Pays:8
				End if 
				[Factures:15]TotalHT:8:=Sum:C1(TbLFPrixTotalHT)
				$TT:=Size of array:C274(TbLFPrixTotalHT)
				$MontantTVA:=0
				For ($Fumé;1;$TT)
					$MontantTVA:=$MontantTVA+Round:C94((TbLFPrixTotalHT{$Fumé}*TbLFTauxTVA{$Fumé}/100);2)
					APPEND TO ARRAY:C911(TbLFDateVente;Current date:C33)
					APPEND TO ARRAY:C911(TbLFNumFacture;[Factures:15]NumFacture:3)
				End for 
				[Factures:15]TotalTVA:9:=$MontantTVA
				[Factures:15]TotalTTC:10:=[Factures:15]TotalHT:8+$MontantTVA
				SAVE RECORD:C53([Factures:15])
				ZViderSelectionCourante (->[Ventes:16])
				ARRAY TO SELECTION:C261(TbLFNumFacture;[Ventes:16]NumFacture:2\
					;TbLFDateVente;[Ventes:16]DateVente:4\
					;TbLFIntitule;[Ventes:16]Intitule:3\
					;TbLFCodePrestation;[Ventes:16]CodePrestation:9\
					;TbLFPrixTotalHT;[Ventes:16]PrixTotalHT:7\
					;TbLFPrixHT;[Ventes:16]PrixUHT:5\
					;TbLFQuantité;[Ventes:16]Quantité:6\
					;TbLFTauxTVA;[Ventes:16]TauxTVA:8)
			End if 
		End if 
	End if 
	NEXT RECORD:C51([Personnes:12])
End for 
ZAmnistiePartielle (->[Ventes:16])
ZAmnistiePartielle (->[Factures:15])

  // L'ADILVA = facturation des poudres sup
If (False:C215)
	$FT:=Size of array:C274(<>TbLotoAssociation)
	For ($Salé;1;$FT)
		$Possible:=(<>TbLotoNumCampagne{$Salé}=$numCampagneMai) | (<>TbLotoNumCampagne{$Salé}=$numCampagneDec) & (<>TbLotoAssociation{$Salé}="ADILVA")
		If ($Possible & (<>TbLotoNbColisPoudreSR{$Salé}>0))
			CREATE RECORD:C68([Ventes:16])  // la cotis'
			[Ventes:16]NumFacture:2:=[Factures:15]NumFacture:3
			[Ventes:16]Intitule:3:="Frais de port"
			[Ventes:16]PrixUHT:5:=$PrixDuColisSupSansRapport
			$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
			If ($TVA="Faux")
				[Ventes:16]TauxTVA:8:=<>PermTVA
			End if 
			[Ventes:16]Quantité:6:=1
			[Ventes:16]PrixTotalHT:7:=[Ventes:16]PrixUHT:5*[Ventes:16]Quantité:6
			[Ventes:16]DateVente:4:=Current date:C33
			SAVE RECORD:C53([Ventes:16])
		End if 
	End for 
	
	$Test:=<>ZPermMille+"/RT@"
	QUERY:C277([Factures:15];[Factures:15]NumFacture:3=$Test)
	VarSommeHT:=Sum:C1([Factures:15]TotalHT:8)
	VarSommeTTC:=Sum:C1([Factures:15]TotalTTC:10)
	
End if 
