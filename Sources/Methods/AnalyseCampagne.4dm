//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/04/20, 06:47:56
  // ----------------------------------------------------
  // Méthode : AnalyseCampagne
  // Description
  // Méthode qui permet de connaitre quels sont les germes
  //  répondus dans une campagne
  //   le résultat aura la forme NumLabo Campagne Germe 1 Germe 2 Germe 3 Germe 4 Germe 5 
  //   Germe 6 Germe 7 Germe 8 Germe 9 Germe 10 Germe 11
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)


  // recherche des lignes de campagne qui demandent un résultat
QUERY:C277([RAEMALignes:22];[RAEMALignes:22]NomFr:4="Présence dans 25 g de l'échantillon n°1xxx";*)
QUERY:C277([RAEMALignes:22]; | [RAEMALignes:22]NomFr:4="Concentration de l'échantillon n°1xxx@")
SELECTION TO ARRAY:C260([RAEMALignes:22]Identifiant:3;$TbIdLigne)

$FT:=Size of array:C274($TbIdLigne)

For ($Salé;$FT;1;-1)
	If ($TbIdLigne{$Salé}="@A@")
		DELETE FROM ARRAY:C228($TbIdLigne;$Salé)
	End if 
End for 


  // Déclaration des tableaux du résultat
ARRAY TEXT:C222(<>TbBilanCampagne;0)
ARRAY TEXT:C222(<>TbBilanMdP;0)
ARRAY TEXT:C222(<>TbBilanEurope;0)
ARRAY TEXT:C222(<>TbBilanPays;0)
ARRAY LONGINT:C221(<>TbBilanNumLaboN;0)
ARRAY LONGINT:C221(<>TbBilanGerme1;0)
ARRAY LONGINT:C221(<>TbBilanGerme2;0)
ARRAY LONGINT:C221(<>TbBilanGerme3;0)
ARRAY LONGINT:C221(<>TbBilanGerme4;0)
ARRAY LONGINT:C221(<>TbBilanGerme5;0)
ARRAY LONGINT:C221(<>TbBilanGerme6;0)
ARRAY LONGINT:C221(<>TbBilanGerme7;0)
ARRAY LONGINT:C221(<>TbBilanGerme8;0)
ARRAY LONGINT:C221(<>TbBilanGerme9;0)
ARRAY LONGINT:C221(<>TbBilanGerme10;0)
ARRAY LONGINT:C221(<>TbBilanGerme11;0)

QUERY:C277([WebConnexions:13];[WebConnexions:13]BoolEnvoi:8=True:C214;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]Campagne:5#"@A@")
  // Elimination du laboratoire 13 FuQPRPqSYE  ?
ARRAY BLOB:C1222($TbBlob;0)

SELECTION TO ARRAY:C260([WebConnexions:13]BlobConnexion:11;$TbBlob\
;[WebConnexions:13]Campagne:5;$TbNumCampagne\
;[WebConnexions:13]CodeConnexion:4;$CodeConnexion\
;[WebConnexions:13]DateConnexion:2;$DateConnexion\
;[WebConnexions:13]HeureConnexion:3;$HeureConnexion)
$FT:=Size of array:C274($TbNumCampagne)
$TailleTbCourante:=1
For ($Salé;1;$FT)
	
	If ($CodeConnexion{$Salé-1}#$CodeConnexion{$Salé})
		$NumLaboN:=RAEMADemoduleMdPWeb ($CodeConnexion{$Salé})
		$NumCampagne:=$TbNumCampagne{$Salé}
		$Code:=$CodeConnexion{$Salé}
		$L:=Find in array:C230(<>TbPerIdentificateur;$Code)
		If ($L>0)
			$PaysLabo:=<>TbPerAdrLivPays{$L}
			If ($PaysLabo="France") | ($PaysLabo="Espagne") | ($PaysLabo="Belgique") | ($PaysLabo="Luxembourg") | ($PaysLabo="Suisse")
				$Europe:="Europe"
			Else 
				$Europe:="Etranger"
			End if 
			If ($PaysLabo="")
				$PaysLabo:="Pays à vérifier"
				$Europe:="Pays à vérifier"
			End if 
		Else 
			$Europe:="Pays à vérifier"
			$PaysLabo:="Pays à vérifier"
		End if 
		
		ARRAY TEXT:C222($TbNumEch;0)
		ARRAY TEXT:C222($TbNumEchT;0)
		ARRAY LONGINT:C221($TbNumEnrRaemaRetenu;0)
		ARRAY TEXT:C222($TbNomsP2;0)
		ARRAY TEXT:C222($TbValeursP2;0)
		ARRAY TEXT:C222($TbNomsP3;0)
		ARRAY TEXT:C222($TbValeursP3;0)
		ARRAY TEXT:C222($TbTexteResume;0)
		ARRAY TEXT:C222($TbPJMailRaema;0)
		ZBlobVersVariableSansPt ($TbBlob{$Salé};->$TbNumEch;->$TbNumEchT;->$TbNumEnrRaemaRetenu;->$TbNomsP2;->$TbValeursP2;->$TbNomsP3;->$TbValeursP3;->$TbTexteResume;->$TbPJMailRaema)
		  // Remplissage des tableaux généraux
		APPEND TO ARRAY:C911(<>TbBilanCampagne;$NumCampagne)
		APPEND TO ARRAY:C911(<>TbBilanMdP;$Code)
		APPEND TO ARRAY:C911(<>TbBilanPays;$PaysLabo)
		APPEND TO ARRAY:C911(<>TbBilanNumLaboN;$NumLaboN)
		APPEND TO ARRAY:C911(<>TbBilanEurope;$Europe)
		  // les tableaux des germes
		$L:=Find in array:C230($TbIdLigne;($NumCampagne+"@"))
		For ($Fumé;1;11)
			$Pt:=Get pointer:C304("<>TbBilanGerme"+String:C10($Fumé))
			APPEND TO ARRAY:C911($Pt->;0)
		End for 
		
		If ($L>0)  // Il a répondu à au moins un germe
			While ($L>0)
				$RangGerme:=Num:C11(Substring:C12($TbIdLigne{$L};(Length:C16($TbIdLigne{$L})-3);2))-1  //  -1 pour tenir compte de la première page = conditions d'analyses
				If ($RangGerme=10) | ($RangGerme=9)
					$NomChamp:="PUM"+Substring:C12($TbIdLigne{$L};(Length:C16($TbIdLigne{$L})-3);4)
				Else 
					$NomChamp:="Champ"+Substring:C12($TbIdLigne{$L};(Length:C16($TbIdLigne{$L})-3);4)
				End if 
				$Valeur:=WebTrouveValeurParNom ($NomChamp;->$TbNomsP3;->$TbValeursP3)
				If ($Valeur="0.1") | (Num:C11($Valeur)>0)  // une valeur est notée
					$Pt:=Get pointer:C304("<>TbBilanGerme"+String:C10($RangGerme))
					$Pt->{Size of array:C274($Pt->)}:=1
				End if 
				$L:=Find in array:C230($TbIdLigne;($NumCampagne+"@");($L+1))
			End while 
		End if 
	End if 
End for 
$FT:=Size of array:C274(<>TbBilanNumLaboN)
$Rapport:=""
For ($Salé;1;$FT)
	$Rapport:=$Rapport+String:C10(<>TbBilanNumLaboN{$Salé})+<>ZTab+<>TbBilanMdP{$Salé}+<>ZTab+<>TbBilanCampagne{$Salé}+<>ZTab+<>TbBilanPays{$Salé}+<>ZTab+<>TbBilanEurope{$Salé}
	For ($Fumé;1;11)
		$Pt:=Get pointer:C304("<>TbBilanGerme"+String:C10($Fumé))
		$Rapport:=$Rapport+<>ZTab+String:C10($Pt->{$Salé})
	End for 
	$Rapport:=$Rapport+<>ZCR
End for 
SET TEXT TO PASTEBOARD:C523($Rapport)
