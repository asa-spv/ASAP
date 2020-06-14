//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/01/19, 11:09:37
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbNomGermeGel
  // Description
  //  Méthode qui établit la correspondance entre le nom des germes 
  //  du schéma ([RAEMAGermes]NomFr), de la campagne ([CampagneGelGermes]NomDuGerme), du petit nom sur le Web
  //   et des tableaux de participation, Nb de pots avec ou sans Rapport COFRAC

C_LONGINT:C283($Salé;$TT)
$MCE:=Macintosh command down:C546

ARRAY TEXT:C222(<>TbNomGermeCampagneGEL;0)
ARRAY TEXT:C222(<>TbNomGermeSchémaGEL;0)
ARRAY TEXT:C222(<>TbPetitNomGermeWeb;0)
ARRAY POINTER:C280(<>TbPtTbParticipeGermeGEL;0)
ARRAY POINTER:C280(<>TbPtTbLotoGermeGELNCGSR;0)
ARRAY POINTER:C280(<>TbPtTbLotoGermeGELNCGAR;0)


  // Remplissage à la main ...
APPEND TO ARRAY:C911(<>TbNomGermeSchémaGEL;"BACILLUS CEREUS")  // [RAEMAGermes]NomFr
APPEND TO ARRAY:C911(<>TbNomGermeCampagneGEL;"Bacillus")  // [CampagneGelGermes]NomDuGerme
APPEND TO ARRAY:C911(<>TbPetitNomGermeWeb;"bacillus")  // suffixe utilisé dans les variables Web OldFashion
APPEND TO ARRAY:C911(<>TbPtTbParticipeGermeGEL;-><>TbLotoBacillus)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGSR;-><>TbLotoBacillusNCGSR)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGAR;-><>TbLotoBacillusNCGAR)
APPEND TO ARRAY:C911(<>TbOrdreGermeCampagneGEL;10)

APPEND TO ARRAY:C911(<>TbNomGermeSchémaGEL;"PSEUDOMONAS")
APPEND TO ARRAY:C911(<>TbNomGermeCampagneGEL;"Pseudomonas")
APPEND TO ARRAY:C911(<>TbPetitNomGermeWeb;"pseudo")
APPEND TO ARRAY:C911(<>TbPtTbParticipeGermeGEL;-><>TbLotoPseudo)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGSR;-><>TbLotoPseudoNCGSR)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGAR;-><>TbLotoPseudoNCGAR)
APPEND TO ARRAY:C911(<>TbOrdreGermeCampagneGEL;20)

APPEND TO ARRAY:C911(<>TbNomGermeSchémaGEL;"BACTERIES LACTIQUES")
APPEND TO ARRAY:C911(<>TbPetitNomGermeWeb;"lactiques")
APPEND TO ARRAY:C911(<>TbNomGermeCampagneGEL;"Bacilles lactiques")
APPEND TO ARRAY:C911(<>TbPtTbParticipeGermeGEL;-><>TbLotoLactiques)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGSR;-><>TbLotoLactiquesNCGSR)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGAR;-><>TbLotoLactiquesNCGAR)
APPEND TO ARRAY:C911(<>TbOrdreGermeCampagneGEL;30)

APPEND TO ARRAY:C911(<>TbNomGermeSchémaGEL;"LEVURES-MOISISSURES ENSEMBLE")
APPEND TO ARRAY:C911(<>TbNomGermeCampagneGEL;"Levures moisissures")
APPEND TO ARRAY:C911(<>TbPetitNomGermeWeb;"lmensemble")
APPEND TO ARRAY:C911(<>TbPtTbParticipeGermeGEL;-><>TbLotoLevMoisEns)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGSR;-><>TbLotoLevMoisEnsNCGSR)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGAR;-><>TbLotoLevMoisEnsNCGAR)
APPEND TO ARRAY:C911(<>TbOrdreGermeCampagneGEL;40)

APPEND TO ARRAY:C911(<>TbNomGermeSchémaGEL;"LEVURES-MOISISSURES SEPAREMENT")
APPEND TO ARRAY:C911(<>TbNomGermeCampagneGEL;"Levures + moisissures")
APPEND TO ARRAY:C911(<>TbPetitNomGermeWeb;"lmsepare")
APPEND TO ARRAY:C911(<>TbPtTbParticipeGermeGEL;-><>TbLotoLevMoisSep)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGSR;-><>TbLotoLevMoisSepNCGSR)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGAR;-><>TbLotoLevMoisSepNCGAR)
APPEND TO ARRAY:C911(<>TbOrdreGermeCampagneGEL;50)

APPEND TO ARRAY:C911(<>TbNomGermeSchémaGEL;"CAMPYLOBACTER RECHERCHE")
APPEND TO ARRAY:C911(<>TbNomGermeCampagneGEL;"Campylobacter recherche")
APPEND TO ARRAY:C911(<>TbPetitNomGermeWeb;"campylor")
APPEND TO ARRAY:C911(<>TbPtTbParticipeGermeGEL;-><>TbLotoCampyloChe)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGSR;-><>TbLotoCampyloCheNCGSR)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGAR;-><>TbLotoCampyloCheNCGAR)
APPEND TO ARRAY:C911(<>TbOrdreGermeCampagneGEL;60)

APPEND TO ARRAY:C911(<>TbNomGermeSchémaGEL;"CAMPYLOBACTER DENOMBREMENT")
APPEND TO ARRAY:C911(<>TbNomGermeCampagneGEL;"Campylobacter dénombrement")
APPEND TO ARRAY:C911(<>TbPetitNomGermeWeb;"campylod")
APPEND TO ARRAY:C911(<>TbPtTbParticipeGermeGEL;-><>TbLotoCampyloDen)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGSR;-><>TbLotoCampyloDenNCGSR)
APPEND TO ARRAY:C911(<>TbPtTbLotoGermeGELNCGAR;-><>TbLotoCampyloDenNCGAR)
APPEND TO ARRAY:C911(<>TbOrdreGermeCampagneGEL;70)


If ($MCE)
	$Rapport:=""
	$TT:=Size of array:C274(<>TbNomGermeSchémaGEL)
	For ($Salé;1;$TT)
		RESOLVE POINTER:C394(<>TbPtTbParticipeGermeGEL{$Salé};$NomPointeur;$T;$C)
		$Rapport:=$Rapport+<>TbNomGermeSchémaGEL{$Salé}+<>ZTab+<>TbNomGermeCampagneGEL{$Salé}+<>ZTab
		$Rapport:=$Rapport+<>TbPetitNomGermeWeb{$Salé}+<>ZTab+$NomPointeur+<>ZTab
		RESOLVE POINTER:C394(<>TbPtTbLotoGermeGELNCGSR{$Salé};$NomPointeur;$T;$C)
		$Rapport:=$Rapport+$NomPointeur+<>ZTab
		RESOLVE POINTER:C394(<>TbPtTbLotoGermeGELNCGAR{$Salé};$NomPointeur;$T;$C)
		$Rapport:=$Rapport+$NomPointeur+<>ZTab+String:C10(<>TbOrdreGermeCampagneGEL{$Salé})+<>ZCR
	End for 
	SET TEXT TO PASTEBOARD:C523($Rapport)
End if 

