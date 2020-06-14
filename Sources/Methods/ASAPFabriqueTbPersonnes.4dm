//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/08/18, 15:08:57
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbPersonnes
  // Description
  // C_ENTIER LONG($Salé;$FT;$Fumé;$SFT;$L)
  // Tableaux généraux pour accélérer les recherches uniques et garantir la confidentialité

$MCE:=Macintosh command down:C546
C_LONGINT:C283($Salé;$FT;$Fumé;$SFT)

  // Les [Personnes]
ALL RECORDS:C47([Personnes:12])
$FT:=Records in selection:C76([Personnes:12])

$NomMéthode:=Current method name:C684
$NomMéthodeMAJ:=$NomMéthode+"MAJ"
If (<>ZClient) & (Count parameters:C259=0)
	$Pr:=Execute on server:C373($NomMéthode;0)
Else 
	ASAPInitTbPersonnes 
	
	ARRAY OBJECT:C1221(<>TbPerArguments;$FT)
	  // Les valeurs des champs
	SELECTION TO ARRAY:C260([Personnes:12]Identificateur:4;<>TbPerIdentificateur\
		;[Personnes:12]NomCourt:3;<>TbPerNomCourt\
		;[Personnes:12]NomLong:2;<>TbPerNomLong\
		;[Personnes:12]TypePersonne:5;<>TbPerTypePersonne\
		;[Personnes:12]UUID:1;<>TbPerUUID\
		;[Personnes:12]Arguments:7;<>TbPerArguments\
		;[Personnes:12]Caduc:8;<>TbPerCaduc)
	LONGINT ARRAY FROM SELECTION:C647([Personnes:12];<>TbPerNumEnr)
	
	
	
	  // Les valeurs des [PersonnesAdresses]
	ALL RECORDS:C47([PersonnesAdresses:11])
	DISTINCT VALUES:C339([PersonnesAdresses:11]TypeAdresse:9;$TbVDTypeAdresse)
	SELECTION TO ARRAY:C260([PersonnesAdresses:11]CodePostal:6;$TbCodePostal;[PersonnesAdresses:11]LigneAdresse1:3;$TbLigneAdresse1;[PersonnesAdresses:11]LigneAdresse2:4;$TbLigneAdresse2;[PersonnesAdresses:11]LigneAdresse3:5;$TbLigneAdresse3;[PersonnesAdresses:11]Pays:8;$TbPays;[PersonnesAdresses:11]TypeAdresse:9;$TbTypeAdresse;[PersonnesAdresses:11]UUIDPersonne:2;$TbUUIDPersonne;[PersonnesAdresses:11]Ville:7;$TbVille)
	
	  // Facturation
	ARRAY TEXT:C222(<>TbPerAdrFacCP;$FT)
	ARRAY TEXT:C222(<>TbPerAdrFacAd1;$FT)
	ARRAY TEXT:C222(<>TbPerAdrFacAd2;$FT)
	ARRAY TEXT:C222(<>TbPerAdrFacAd3;$FT)
	ARRAY TEXT:C222(<>TbPerAdrFacPays;$FT)
	ARRAY TEXT:C222(<>TbPerAdrFacVille;$FT)
	
	  // Perso
	ARRAY TEXT:C222(<>TbPerAdrPerCP;$FT)
	ARRAY TEXT:C222(<>TbPerAdrPerAd1;$FT)
	ARRAY TEXT:C222(<>TbPerAdrPerAd2;$FT)
	ARRAY TEXT:C222(<>TbPerAdrPerAd3;$FT)
	ARRAY TEXT:C222(<>TbPerAdrPerPays;$FT)
	ARRAY TEXT:C222(<>TbPerAdrPerVille;$FT)
	
	
	  // Pro
	ARRAY TEXT:C222(<>TbPerAdrProCP;$FT)
	ARRAY TEXT:C222(<>TbPerAdrProAd1;$FT)
	ARRAY TEXT:C222(<>TbPerAdrProAd2;$FT)
	ARRAY TEXT:C222(<>TbPerAdrProAd3;$FT)
	ARRAY TEXT:C222(<>TbPerAdrProPays;$FT)
	ARRAY TEXT:C222(<>TbPerAdrProVille;$FT)
	
	  // Livraison
	ARRAY TEXT:C222(<>TbPerAdrLivCP;$FT)
	ARRAY TEXT:C222(<>TbPerAdrLivAd1;$FT)
	ARRAY TEXT:C222(<>TbPerAdrLivAd2;$FT)
	ARRAY TEXT:C222(<>TbPerAdrLivAd3;$FT)
	ARRAY TEXT:C222(<>TbPerAdrLivPays;$FT)
	ARRAY TEXT:C222(<>TbPerAdrLivVille;$FT)
	
	
	For ($Salé;1;$FT)
		$L:=0
		$L:=Find in array:C230($TbUUIDPersonne;<>TbPerUUID{$Salé})
		While ($L>0)
			$TypeAdresseCourante:=$TbTypeAdresse{$L}
			$Pt:=Get pointer:C304("<>TbPerAdr"+Substring:C12($TypeAdresseCourante;1;3)+"CP")
			$Pt->{$Salé}:=$TbCodePostal{$L}
			$Pt:=Get pointer:C304("<>TbPerAdr"+Substring:C12($TypeAdresseCourante;1;3)+"Ad1")
			$Pt->{$Salé}:=$TbLigneAdresse1{$L}
			$Pt:=Get pointer:C304("<>TbPerAdr"+Substring:C12($TypeAdresseCourante;1;3)+"Ad2")
			$Pt->{$Salé}:=$TbLigneAdresse2{$L}
			$Pt:=Get pointer:C304("<>TbPerAdr"+Substring:C12($TypeAdresseCourante;1;3)+"Ad3")
			$Pt->{$Salé}:=$TbLigneAdresse3{$L}
			$Pt:=Get pointer:C304("<>TbPerAdr"+Substring:C12($TypeAdresseCourante;1;3)+"Pays")
			$Pt->{$Salé}:=$TbPays{$L}
			$Pt:=Get pointer:C304("<>TbPerAdr"+Substring:C12($TypeAdresseCourante;1;3)+"Ville")
			$Pt->{$Salé}:=$TbVille{$L}
			
			$L:=Find in array:C230($TbUUIDPersonne;<>TbPerUUID{$Salé};($L+1))
		End while 
		
	End for 
	
	  // Les valeurs des propriétés
	ARRAY TEXT:C222(<>PUMPerProprio;0)
	ARRAY POINTER:C280($TbPtProprio;0)
	ARRAY TEXT:C222(PUMProprio;0)
	
	For ($Salé;1;$FT)
		OB GET PROPERTY NAMES:C1232(<>TbPerArguments{$Salé};$TbProp)
		$SFT:=Size of array:C274($TbProp)
		For ($Fumé;1;$SFT)
			If (Find in array:C230(<>PUMPerProprio;$TbProp{$Fumé})<0)
				$NomTableau:="<>TbPA"+$TbProp{$Fumé}
				If (Find in array:C230(TbNomProprioRetenues;$NomTableau)>0)
					APPEND TO ARRAY:C911(<>PUMPerProprio;$TbProp{$Fumé})
					$Pt:=Get pointer:C304($NomTableau)
					ARRAY TEXT:C222($Pt->;$FT)
					APPEND TO ARRAY:C911($TbPtProprio;$Pt)
				End if 
			End if 
		End for 
	End for 
	
	
	  //AJOUTER À TABLEAU(<>PUMPerProprio;"N° adhérent")
	  //AJOUTER À TABLEAU(<>PUMPerProprio;"N° RAEMA")
	
	  // Les valeurs des anciens identifiants [Adhérents]NumAdhérent, [Adhérents]NumRAEMA, [Adhérents]NumRAEMAEntier
	ARRAY LONGINT:C221(<>TbPerNumPersonne;$FT)
	ARRAY LONGINT:C221(<>TbPerNumLaboRAEMA;$FT)
	ARRAY TEXT:C222(<>TbPerNumPersonneA;$FT)
	ARRAY TEXT:C222(<>TbPerNumLaboRAEMAA;$FT)
	
	  // les Numéros de RAEMA liés
	ARRAY TEXT:C222(<>TbPANumRAEMALiés;$FT)
	
	For ($Salé;1;$FT)
		<>TbPerNumPersonne{$Salé}:=RAEMADemoduleMdPWeb (<>TbPerIdentificateur{$Salé};True:C214)
		<>TbPerNumLaboRAEMA{$Salé}:=RAEMADemoduleMdPWeb (<>TbPerIdentificateur{$Salé})
		<>TbPerNumPersonneA{$Salé}:=String:C10(<>TbPerNumPersonne{$Salé})
		<>TbPerNumLaboRAEMAA{$Salé}:=String:C10(<>TbPerNumLaboRAEMA{$Salé})
		
		  // les propriétés
		$SFT:=Size of array:C274(<>PUMPerProprio)
		For ($Fumé;1;$SFT)
			$TbPtProprio{$Fumé}->{$Salé}:=OB Get:C1224(<>TbPerArguments{$Salé};<>PUMPerProprio{$Fumé};Est un texte:K8:3)
			If (<>PUMPerProprio{$Fumé}="TbCodesRAEMALiés")
				$CRL:=$TbPtProprio{$Fumé}->{$Salé}
				If ($CRL="")
					<>TbPANumRAEMALiés{$Salé}:=""
				Else 
					ARRAY TEXT:C222($TbCodeRaemaliés;0)
					ZTexteVersTableau ($CRL;->$TbCodeRaemaliés)
					$NumRaemaliés:=""
					$TTRL:=Size of array:C274($TbCodeRaemaliés)
					For ($OuDuCochon;1;$TTRL)
						$NumRaemaliés:=$NumRaemaliés+String:C10(RAEMADemoduleMdPWeb ($TbCodeRaemaliés{$OuDuCochon}))+" "
					End for 
					<>TbPANumRAEMALiés{$Salé}:=$NumRaemaliés
				End if 
			End if 
		End for 
	End for 
	
	
	APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumEnr)
	APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumPersonne)
	APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumLaboRAEMA)
	APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumLaboRAEMAa)
	APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPerNumLaboRAEMAA)
	APPEND TO ARRAY:C911(<>TbPtPersonnes;-><>TbPANumRAEMALiés)
	
	If ($MCE)
		$SFT:=Size of array:C274(<>TbPtPersonnes)
		$Rapport:=""
		For ($Fumé;1;$SFT)
			$Sep:=(Num:C11($Fumé<$SFT)*<>ZTab)+(Num:C11($Fumé=$SFT)*<>ZCR)
			RESOLVE POINTER:C394(<>TbPtPersonnes{$Fumé};$NomVar;$Ta;$Tc)
			$Rapport:=$Rapport+$NomVar+$Sep
		End for 
		For ($Salé;1;$FT)
			For ($Fumé;1;$SFT)
				$Sep:=(Num:C11($Fumé<$SFT)*<>ZTab)+(Num:C11($Fumé=$SFT)*<>ZCR)
				If (Type:C295(<>TbPtPersonnes{$Fumé}->)=Est un tableau objet:K8:28)
					$Rapport:=$Rapport+JSON Stringify:C1217(<>TbPtPersonnes{$Fumé}->{$Salé})+$Sep
				Else 
					$Rapport:=$Rapport+String:C10(<>TbPtPersonnes{$Fumé}->{$Salé})+$Sep
				End if 
			End for 
		End for 
		SET TEXT TO PASTEBOARD:C523($Rapport)
	End if 
	  //$ListeTb:=""
	  //$TT:=Taille tableau(<>TbPtPersonnes)
	  //Boucle ($Salé;1;$TT)
	  //RÉSOUDRE POINTEUR(<>TbPtPersonnes{$Salé};$NV;$NT;$NC)
	  //$ListeTb:=$ListeTb+$NV+<>ZCR
	  //Fin de boucle 
	  //FIXER TEXTE DANS CONTENEUR($ListeTb)
	SORT ARRAY:C229(<>PUMPerProprio;>)
	  // Fin des [Personnes]
	If (Application type:C494=4D Server:K5:6)  // MAJ des clients inscrits
		EXECUTE ON CLIENT:C651("@";"ASAPFabriqueTbPersonnesMAJ")
	End if 
End if 