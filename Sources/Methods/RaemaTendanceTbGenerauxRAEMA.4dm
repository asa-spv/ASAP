//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/07/19, 05:48:19
  // ----------------------------------------------------
  // Méthode : RaemaTendanceTbGenerauxRAEMA

  // Description
  // Ecrit les tableaux des RAEMA concernés  
  //  définis par le PUM
  // ----------------------------------------------------

C_LONGINT:C283($salé;$OuDuCochon;$fumé;$sec;$TT;$FT;$L;$L2;$L3;$LimiteCampagne)
ARRAY LONGINT:C221(TbOccurrence;0)
ARRAY LONGINT:C221(TbRangLigne;0)
ARRAY TEXT:C222(TbValeurs;0)
ARRAY TEXT:C222(TbGerme;0)
ARRAY TEXT:C222(TbNature;0)
ARRAY TEXT:C222(TbNumCampagne;0)
ARRAY TEXT:C222(TbPL;0)
ARRAY TEXT:C222(TbLabosConcernes;0)

ARRAY TEXT:C222($TbRaemaConcernes;2)
$TbRaemaConcernes{1}:=TbNR{TbNR+4}
$TbRaemaConcernes{2}:=TbNR{TbNR+2}

  //VarNumRaema:="64"
For ($OuDuCochon;1;2)
	VarNumRaema:=$TbRaemaConcernes{$OuDuCochon}
	  // Correspondance de la page avec le nom du germe
	
	
	  //  // Ensemble des [XDonnées] = envois à l'ASA pour la campagne
	
	  //  // le dernier envoyé
	  //SÉLECTION VERS TABLEAU([XData]XType;$TbType;[XData]XEntier;$TbRangLigne;[XData]XBlob;$TbBlob)
	  //TABLEAU ENTIER LONG SUR SÉLECTION([XData];$TbNumEnrEnvoi)
	
	  // Le nom des germes de la capagne
	QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=(VarNumRaema+"@"))
	ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;$TbNomGerme)
	  //CHERCHER([RAEMA];[RAEMA]NumRAEMA=VarNumRaema;*)
	  //CHERCHER([RAEMA]; & [RAEMA]Ordre=0)
	  //TRIER([RAEMA];[RAEMA]NumPage;>)
	  //SÉLECTION VERS TABLEAU([RAEMA]Intitule;$TbNomGerme)
	
	  // Sélection des [WebConnexions] envoyées de la campagne hors laboratoire13 (CodeConnexion#"FuQPRPqSYE")
	QUERY:C277([WebConnexions:13];[WebConnexions:13]Campagne:5=VarNumRaema;*)
	QUERY:C277([WebConnexions:13]; & [WebConnexions:13]CodeConnexion:4#"FuQPRPqSYE";*)
	QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
	  // Ensemble des [XDonnées] = envois à l'ASA pour la campagne
	  //CHERCHER([XData];[XData]XType=(VarNumRaema+"@");*)
	  //  // Sélection des XDonnées dont type commence par n° de campagne
	  //Si (VarNumRaema#"@A")  // Si Raema poudre la ligne précédente selectionne aussi le RAEMA Gel
	  //CHERCHER([XData]; & [XData]XType#(VarNumRaema+"A@");*)  // Elimination du Rama gel
	  //Fin de si 
	  //CHERCHER([XData]; & [XData]XType#VarNumRaema;*)  // Elimination des connexion sans labo
	  //CHERCHER([XData]; & [XData]XType#(VarNumRaema+"13");*)  // Elimination du 13
	  //CHERCHER([XData]; & [XData]XBool=Vrai)  // On ne conserve que les connexions envoyées à l'ASA
	
	  // le dernier envoyé
	SELECTION TO ARRAY:C260([WebConnexions:13]CodeConnexion:4;$TbCode;[WebConnexions:13]NumEnvoi:9;$TbRangLigne;[WebConnexions:13]BlobConnexion:11;$TbBlob)
	LONGINT ARRAY FROM SELECTION:C647([WebConnexions:13];$TbNumEnrEnvoi)
	$TT:=Size of array:C274($TbNumEnrEnvoi)
	ARRAY TEXT:C222($TbType;$TT)
	For ($Salé;1;$TT)  // Pour chaque connexion
		$TbType{$Salé}:=String:C10(RAEMADemoduleMdPWeb ($TbCode{$Salé}))
	End for 
	MULTI SORT ARRAY:C718($TbType;>;$TbRangLigne;<;$TbNumEnrEnvoi;$TbBlob;<)
	ARRAY LONGINT:C221(TbNumEnrRetenus;0)  // Les n° d'enregistrements des bonnes [XDonnées]
	ARRAY TEXT:C222(TbNumLaboA;0)  // Les n° de labo sous forme alphanumérique
	ARRAY TEXT:C222($TbLaboTraités;0)  // Pour éviter de compter plusieurs fois le même labo
	ARRAY BLOB:C1222($TbBlobDernierEnvoi;0)
	$TT:=Size of array:C274($TbType)
	For ($Salé;1;$TT)  // Pour chaque labo
		If (Find in array:C230($TbLaboTraités;$TbType{$salé})<0)
			APPEND TO ARRAY:C911($TbLaboTraités;$TbType{$salé})
			APPEND TO ARRAY:C911(TbNumEnrRetenus;$TbNumEnrEnvoi{$salé})
			$LimiteCampagne:=3+Num:C11(VarNumRaema="@A")
			APPEND TO ARRAY:C911(TbNumLaboA;$TbType{$salé})
			APPEND TO ARRAY:C911($TbBlobDernierEnvoi;$TbBlob{$salé})
		End if 
	End for 
	
	
	
	$TT:=Size of array:C274($TbBlobDernierEnvoi)
	For ($salé;1;$TT)
		ARRAY TEXT:C222(TbNomsP3;0)
		ARRAY TEXT:C222(TbValeursP3;0)
		ZBlobVersVariable (->$TbBlobDernierEnvoi{$salé};->TbNumEch;->TbNumEchT;->TbNumEnrRaemaRetenu;->TbNomsP2;->TbValeursP2;->TbNomsP3;->TbValeursP3;->TbTexteResume;->TbPJMailRaema)
		$L:=Find in array:C230(<>TbTendanceToutesNumRaema;VarNumRaema)
		$FT:=Size of array:C274(<>TbTendanceToutesNumRaema)  // Autant de fois que de lignes recherchées
		For ($fumé;$L;$FT)
			If (<>TbTendanceToutesNumRaema{$fumé}=VarNumRaema)
				$PLCourant:=<>TbTendanceToutesPL{$fumé}
				$VarPageLigne:="PUM"+$PLCourant
				$L2:=Find in array:C230(TbNomsP3;$VarPageLigne)
				If ($L2>0)
					$Lignevaleurcourante:=TbNomsP3{$L2}
					$RangNomGerme:=Num:C11(Substring:C12($Lignevaleurcourante;4;2))
					$ValeurCourante:=TbValeursP3{$L2}
					
					If ($ValeurCourante#"") & ($ValeurCourante#"0")
						$NbInsecable:=0
						For ($sec;1;100)
							If ($ValeurCourante[[$sec]]=" ")
								$NbInsecable:=$NbInsecable+1
								If ($NbInsecable=2)
									$RangValeurCourant:=Num:C11(Substring:C12($ValeurCourante;1;$sec))+1
									$ValeurCourante:=Substring:C12($ValeurCourante;($sec+1))
									$sec:=100
								End if 
							End if 
						End for 
						$ValeurTbPLCourant:=VarNumRaema+$PLCourant+$ValeurCourante
						  // (VarNumRaema="63A") & ($PLCourant="0303") & ($ValeurCourante="bio-r@")
						$L3:=Find in array:C230(TbPL;$ValeurTbPLCourant)
						If ($L3<0)
							APPEND TO ARRAY:C911(TbNumCampagne;VarNumRaema)
							APPEND TO ARRAY:C911(TbGerme;$TbNomGerme{$RangNomGerme})
							APPEND TO ARRAY:C911(TbNature;<>TbTendanceToutesNature{$fumé})
							If ($ValeurCourante="Autre@") | ($ValeurCourante="Other@")
								APPEND TO ARRAY:C911(TbValeurs;$ValeurCourante+" (tous confondus)")
							Else 
								APPEND TO ARRAY:C911(TbValeurs;$ValeurCourante)
							End if 
							APPEND TO ARRAY:C911(TbRangLigne;$RangValeurCourant)
							APPEND TO ARRAY:C911(TbOccurrence;1)
							APPEND TO ARRAY:C911(TbPL;$ValeurTbPLCourant)
							APPEND TO ARRAY:C911(TbLabosConcernes;TbNumLaboA{$salé})
						Else 
							TbOccurrence{$L3}:=TbOccurrence{$L3}+1
							TbLabosConcernes{$L3}:=TbLabosConcernes{$L3}+" , "+TbNumLaboA{$salé}
						End if 
						If ($ValeurCourante="Autre@") | ($ValeurCourante="Other@")
							$Autre:="Champ"+<>TbTendanceToutesPL{$fumé}
							$L2:=Find in array:C230(TbNomsP3;$Autre)
							$ValeurCourante:=TbValeursP3{$L2}
							If ($ValeurCourante#"")
								If ($L2>0)
									$ValeurTbPLCourant:=VarNumRaema+$PLCourant+$ValeurCourante
									$L3:=Find in array:C230(TbValeurs;$ValeurTbPLCourant)
									If ($L3<0)
										APPEND TO ARRAY:C911(TbNumCampagne;VarNumRaema)
										APPEND TO ARRAY:C911(TbGerme;$TbNomGerme{$RangNomGerme})
										APPEND TO ARRAY:C911(TbNature;<>TbTendanceToutesNature{$fumé})
										APPEND TO ARRAY:C911(TbValeurs;("Autre : "+$ValeurCourante))
										APPEND TO ARRAY:C911(TbRangLigne;$RangValeurCourant+1)
										APPEND TO ARRAY:C911(TbOccurrence;1)
										APPEND TO ARRAY:C911(TbPL;VarNumRaema+$PLCourant+$ValeurCourante)
										APPEND TO ARRAY:C911(TbLabosConcernes;TbNumLaboA{$salé})
									Else 
										TbOccurrence{$L3}:=TbOccurrence{$L3}+1
										TbLabosConcernes{$L3}:=TbLabosConcernes{$L3}+" , "+TbNumLaboA{$salé}
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
				
			Else 
				$fumé:=$FT
			End if 
			
		End for 
		
	End for 
	
End for 
VarNbLignes:=Size of array:C274(TbOccurrence)
