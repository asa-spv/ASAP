//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 31/12/18, 13:59:47
  // ----------------------------------------------------
  // Paramètres : $1=nom de la LB concernée   $2=Pt sur le tableau des numéros d'enregistrement
  // ----------------------------------------------------
  // Méthode : RaemaDevisClicDansListe
  // Description
  // // Méthode exécutée dans le formulaire DlgGestionDevisRaemaGel
  // qui affiche les données de cet écran en fonction du tableau et de la ligne concernés

C_LONGINT:C283($C;$L;$FT;$Fumé;$Salé)
$NomLB:=$1
$Pt:=$2

$coté:=(Num:C11($NomLB="ListBoxNumLabo")*"à valider")+(Num:C11($NomLB#"ListBoxNumLabo")*"validés")+(Num:C11($NomLB="ListBoxNumAdilva")*" de l'ADILVA")
LISTBOX GET CELL POSITION:C971(*;$NomLB;$C;$L)
If ($L=0)
	ALERT:C41("Merci de désigner un laboratoire dans le tableau des devis "+$coté+"...")
Else 
	LigneCliqueDansBDDevis:=$L
	GOTO RECORD:C242([PersonnesDevis:30];$Pt->{$L})
	  // QUI ? numlabo  mdplabo  Nom  adresse  cp  ville  pays  mail
	  // $NomLaboN:=Num(WebTrouveValeurParNom ("numlabo";->TbNoms;->TbValeurs))
	
	$L:=Find in array:C230(<>TbPerUUID;[PersonnesDevis:30]UUIDPersonne:6)
	If ($L>0)
		QUERY:C277([Personnes:12];[Personnes:12]UUID:1=<>TbPerUUID{$L})
		QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]UUIDPersonne:2=<>TbPerUUID{$L};*)
		QUERY:C277([PersonnesAdresses:11]; & [PersonnesAdresses:11]TypeAdresse:9="Livraison")
		VarNom:=[Personnes:12]NomLong:2
		VarAdresse:=[PersonnesAdresses:11]LigneAdresse1:3+<>ZCR+[PersonnesAdresses:11]LigneAdresse2:4+<>ZCR+[PersonnesAdresses:11]LigneAdresse3:5
		VarCP:=[PersonnesAdresses:11]CodePostal:6
		VarVille:=[PersonnesAdresses:11]Ville:7
		VarPays:=[PersonnesAdresses:11]Pays:8
		VarMail:=OB Get:C1224([Personnes:12]Arguments:7;"EmailRAEMA";Est un texte:K8:3)
	Else 
		ZViderSelectionCourante (->[Personnes:12])
		VarNom:=WebTrouveValeurParNom ("Nom";->TbNoms;->TbValeurs)
		VarAdresse:=WebTrouveValeurParNom ("adresse";->TbNoms;->TbValeurs)
		VarCP:=WebTrouveValeurParNom ("cp";->TbNoms;->TbValeurs)
		VarVille:=WebTrouveValeurParNom ("ville";->TbNoms;->TbValeurs)
		VarPays:=WebTrouveValeurParNom ("pays";->TbNoms;->TbValeurs)
		If (VarPays="")
			VarPays:="France"
		End if 
		VarMail:=WebTrouveValeurParNom ("mail";->TbNoms;->TbValeurs)
	End if 
	
	
	  // QUOI ? 
	ARRAY TEXT:C222(TbNoms;0)
	ARRAY TEXT:C222(TbValeurs;0)
	  //ZBlobVersVariable (->[XData]XBlob;->TbNoms;->TbValeurs)
	OB GET ARRAY:C1229([PersonnesDevis:30]Arguments:9;"TbNoms";TbNoms)
	OB GET ARRAY:C1229([PersonnesDevis:30]Arguments:9;"TbValeurs";TbValeurs)
	
	  // $:=Chercher dans tableau(TbNoms;"nbpotsuparmaibacillus")>0)
	
	ARRAY TEXT:C222(TbNomGermeMai;0)
	ARRAY TEXT:C222(TbPSARMai;0)
	ARRAY TEXT:C222(TbPSSRMai;0)
	ARRAY TEXT:C222(TbNomGermeDec;0)
	ARRAY TEXT:C222(TbPSARDec;0)
	ARRAY TEXT:C222(TbPSSRDec;0)
	
	For ($Fumé;1;2)
		$Mois:=(Num:C11($Fumé=1)*"mai")+(Num:C11($Fumé=2)*"dec")
		$FT:=Size of array:C274(<>TbPetitNomGermeWeb)
		For ($Salé;1;$FT)
			$CbCourante:="cb"+$Mois+<>TbPetitNomGermeWeb{$Salé}
			If (Find in array:C230(TbNoms;$CbCourante)>0)
				$NomGerme:=<>TbNomGermeSchémaGEL{$Salé}
				$Pt:=Get pointer:C304("TbNomGerme"+$Mois)
				APPEND TO ARRAY:C911($Pt->;$NomGerme)
				$NbPots:=TbValeurs{Find in array:C230(TbNoms;("nbpotsupar"+$Mois+<>TbPetitNomGermeWeb{$Salé}))}
				$Pt:=Get pointer:C304("TbPSAR"+$Mois)
				APPEND TO ARRAY:C911($Pt->;$NbPots)
				$NbPots:=TbValeurs{Find in array:C230(TbNoms;("nbpotsupsr"+$Mois+<>TbPetitNomGermeWeb{$Salé}))}
				$Pt:=Get pointer:C304("TbPSSR"+$Mois)
				APPEND TO ARRAY:C911($Pt->;$NbPots)
			End if 
		End for 
	End for 
	
	
End if 
