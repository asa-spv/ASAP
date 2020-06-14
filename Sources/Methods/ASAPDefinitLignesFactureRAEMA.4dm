//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/01/19, 15:00:29
  // ----------------------------------------------------
  // Paramètres : {$1} si existe = paye $2 plusieur fois
  // ----------------------------------------------------
  // Méthode : ASAPDefinitLignesFactureRAEMA
  // Description
  // Ecrit les lignes de factures([Ventes])
  // en fonction des choix du laboratoire
  // ----------------------------------------------------
C_LONGINT:C283($1;$Quantité)
If (Count parameters:C259=1)
	$Quantité:=1/$1
Else 
	$Quantité:=1
End if 
  // Facturation de la cotisation
$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
If ($TVA="Faux")
	$Code:="Cotisation ASA 20"+<>ZPermMille
	ASAPCreerLigneFacture ($Code;$Quantité)
End if 



  // Facturation RAEMA poudre

  // Recherche dans les tableaux généraux de campagne de la participation éventuelle du laboratoire
$NumRaema:=ASAPTrouveNumeroLaboParUUID ([Personnes:12]UUID:1)
$AnN:=Year of:C25(Current date:C33)
$numCampagneMars:=RaemaTrouveNumCampagneParAn ($AnN)
$numCampagneOctobre:=RaemaTrouveNumCampagneParAn ($AnN;3)
$IDParticipeMars:=$numCampagneMars+"_"+$NumRaema+"_"
$IDParticipeOctobre:=$numCampagneOctobre+"_"+$NumRaema+"_"
$LMars:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IDParticipeMars)
$Mars:=($LMars>0)
$LOctobre:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IDParticipeOctobre)
$Octobre:=($LOctobre>0)
$LesDeux:=($Mars & $Octobre)
$UneSeule:=((Num:C11($Mars)+Num:C11($Octobre))=1)
If ($Mars | $Octobre)  // rien à faire sinon
	Case of 
		: ($Mars & $Octobre)
			ASAPCreerLigneFacture ("P2C";$Quantité)
			  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
			If (<>TbLotoNbColisPoudreAR{$LMars}>0) & (<>TbLotoNbColisPoudreAR{$LOctobre}>0)  // en  MARS et en OCTOBRE
				ASAPCreerLigneFacture ("P2AR";(<>TbLotoNbColisPoudreAR{$LMars}+<>TbLotoNbColisPoudreAR{$LOctobre})*$Quantité)
			End if 
			  // FACTURATION DES BOITES ISOTHERMES
			$BoiteM:=<>TbLotoBoiteIsotherme{$LMars}
			$BoiteO:=<>TbLotoBoiteIsotherme{$LOctobre}
			If ($BoiteM=2) | ($BoiteO=2)
				$Code:="BOI"
				ASAPCreerLigneFacture ($Code;($BoiteM+$BoiteO)*$Quantité)
			End if 
			
		: ($Mars)
			ASAPCreerLigneFacture ("P1M";$Quantité)
			
		: ($Octobre)
			ASAPCreerLigneFacture ("P1O";$Quantité)
			
	End case 
	
	If ($Mars & $UneSeule)  //Mars seulement
		  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
		If (<>TbLotoNbColisPoudreAR{$LMars}>0)  // en  MARS 
			ASAPCreerLigneFacture ("PMAR";(<>TbLotoNbColisPoudreAR{$LMars})*$Quantité)
		End if 
		
		  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
		If (<>TbLotoNbColisPoudreSR{$LMars}>0)  // en  MARS
			ASAPCreerLigneFacture ("PMSR";<>TbLotoNbColisPoudreSR{$LMars}*$Quantité)
		End if 
		
		  // FACTURATION DES BOITES ISOTHERMES
		$BoiteM:=<>TbLotoBoiteIsotherme{$LMars}
		If ($BoiteM=2)
			$Code:="BOI"
			ASAPCreerLigneFacture ($Code;$BoiteM*$Quantité)
		End if 
	End if 
	
	
	If ($Octobre & $UneSeule)
		If (<>TbLotoNbColisPoudreAR{$LOctobre}>0)  // en  Octobre 
			ASAPCreerLigneFacture ("PMAR";(<>TbLotoNbColisPoudreAR{$LMars})*$Quantité)
		End if 
		  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
		If (<>TbLotoNbColisPoudreSR{$LOctobre}>0)  // en  Octobre
			ASAPCreerLigneFacture ("PMSR";<>TbLotoNbColisPoudreSR{$LOctobre}*$Quantité)
		End if 
		
		  // FACTURATION DES BOITES ISOTHERMES
		$BoiteO:=<>TbLotoBoiteIsotherme{$LOctobre}
		If ($BoiteO=2)
			$Code:="BOI"
			ASAPCreerLigneFacture ($Code;$BoiteO*$Quantité)
		End if 
	End if 
	
	$Frais:=OB Get:C1224([Personnes:12]Arguments:7;"PrixTransporteur";Est un numérique:K8:4)
	If ($Frais>0)
		CREATE RECORD:C68([Ventes:16])  // la cotis'
		[Ventes:16]NumFacture:2:=[Factures:15]NumFacture:3
		[Ventes:16]Intitule:3:="Frais de port"
		[Ventes:16]PrixUHT:5:=$Frais*$Quantité
		$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
		If ($TVA="Faux")
			[Ventes:16]TauxTVA:8:=<>PermTVA
		End if 
		[Ventes:16]Quantité:6:=1
		[Ventes:16]PrixTotalHT:7:=[Ventes:16]PrixUHT:5*[Ventes:16]Quantité:6
		[Ventes:16]DateVente:4:=Current date:C33
		SAVE RECORD:C53([Ventes:16])
	End if 
End if 
