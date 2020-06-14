//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/08/18, 11:54:12
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : RaemaSchemaImprime
  // Description
  // 

$VarNumRAEMA:=TbNR{TbNR}
SET PRINT OPTION:C733(2;2)
PRINT SETTINGS:C106
If (OK=1)
	RaemaSchemaStockPage 
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=TbNR{TbNR})
	QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]UUIDCampagne:2=[RAEMACampagnes:20]UUID:1)
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;$TbNomGermeF;[RAEMAGermes:21]NomEn:5;$TbNomGermeA;[RAEMAGermes:21]Identifiant:3;$TbOrdreA)
	SORT ARRAY:C229($TbOrdreA;$TbNomGermeA;$TbNomGermeF)
	$FT:=Size of array:C274($TbOrdreA)
	C_LONGINT:C283($Salé;$FT;$Fumé;$SFT)
	VarEtatRaema:="                               ETAT DU RAEMA "+$VarNumRAEMA
	$H:=Print form:C5("EtatRaema")
	$HT:=$H
	$Val:=0
	OrdreActuel:=1
	For ($Salé;1;$FT)
		VarEtatRaema:=<>ZCR+$TbNomGermeF{$Salé}+"   ("+$TbNomGermeA{$Salé}+") = page "+String:C10($Salé)
		$H:=Print form:C5("EtatRaema")
		QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=($TbOrdreA{$Salé}+"@"))
		SELECTION TO ARRAY:C260([RAEMALignes:22]NomFr:4;$TbNomLigneF;[RAEMALignes:22]NomEn:5;$TbNomLigneA;[RAEMALignes:22]Identifiant:3;$TbIdentifiantLigne)
		SORT ARRAY:C229($TbIdentifiantLigne;$TbNomLigneF;$TbNomLigneA)
		$SFT:=Size of array:C274($TbNomLigneF)
		For ($Fumé;1;$SFT)
			VarEtatRaema:=RaemaSchemaImprimeColonne ($TbIdentifiantLigne{$Fumé})+$TbNomLigneF{$Fumé}
			VarEtatRaemaE:=$TbNomLigneA{$Fumé}
			$H:=Print form:C5("EtatRaemaLigne")
			QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=($TbIdentifiantLigne{$Fumé}+"@"))
			ARRAY OBJECT:C1221($TbArgumentValeur;0)
			SELECTION TO ARRAY:C260([RAEMAValeurs:23]NomEn:5;$TbNomValeurA;[RAEMAValeurs:23]NomFr:4;$TbNomValeurF;[RAEMAValeurs:23]Identifiant:3;$TbIdentifiantValeur;[RAEMAValeurs:23]Arguments:6;$TbArgumentValeur)
			SORT ARRAY:C229($TbIdentifiantValeur;$TbNomValeurA;$TbNomValeurF;$TbArgumentValeur)
			$SSFT:=Size of array:C274($TbIdentifiantValeur)
			$VarDétailF:=""
			$VarDétailE:=""
			$Précision:=False:C215
			For ($Sec;1;$SSFT)
				$OptionF:=""
				$OptionE:=""
				$RensLiaison:=""
				$TipsFr:=OB Get:C1224($TbArgumentValeur{$Sec};"TipsFr";Est un texte:K8:3)
				$TipsEn:=OB Get:C1224($TbArgumentValeur{$Sec};"TipsEn";Est un texte:K8:3)
				$OptionF:=" (tips : "+Replace string:C233($TipsFr;<>ZCR;" ")+")"
				$OptionE:=" (tips : "+Replace string:C233($TipsEn;<>ZCR;" ")+")"
				$Milieu:=OB Get:C1224($TbArgumentValeur{$Sec};"Milieu";Est un texte:K8:3)
				$Fabricant:=OB Get:C1224($TbArgumentValeur{$Sec};"Fabricant";Est un texte:K8:3)
				$Précision:=OB Get:C1224($TbArgumentValeur{$Sec};"Précision";Est un booléen:K8:9)
				$RensLiaison:=""
				If (Length:C16($Milieu+$Fabricant)>0)
					$RensLiaison:=" [Renseignements liés : Milieu = "+<>ZGuil+$Milieu+<>ZGuil
					$RensLiaison:=$RensLiaison+" / Fabricant = "+<>ZGuil+$Fabricant+<>ZGuil+"]"
				End if 
				$Indice:=String:C10($Sec)+"-"
				$VarDétailF:=$VarDétailF+", "+$Indice+$TbNomValeurF{$Sec}+(Num:C11($TipsFr#"")*$OptionF)+$RensLiaison
				$VarDétailE:=$VarDétailE+", "+$Indice+$TbNomValeurA{$Sec}+(Num:C11($TipsFr#"")*$OptionE)
				If ($Précision)
					$Précision:=True:C214
				End if 
				
			End for 
			VarDetail:=Substring:C12($VarDétailF;3)
			VarDetailE:=Substring:C12($VarDétailE;3)
			$H:=Print form:C5("EtatRaemaLigneDétail")
			
			If ($Précision)
				VarEtatRaema:=RaemaSchemaImprimeColonne ($TbIdentifiantLigne{$Fumé})+"précision pour "+$TbNomLigneF{$Fumé}
				VarEtatRaemaE:=""
				$H:=Print form:C5("EtatRaemaLigne")
			End if 
		End for 
	End for 
End if 