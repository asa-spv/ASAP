//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/07/19, 05:30:55
  // ----------------------------------------------------
  // Méthode : RaemaTendanceTbPLTousRAEMA
  // Fabrique les tableaux généraux de repérage
  //   des méthodes, fabricants, milieux 
  //   de tous les RAEMA
  // ----------------------------------------------------

C_LONGINT:C283($salé;$TT)
C_TEXT:C284($Page)
ALL RECORDS:C47([RAEMALignes:22])
  // SÉLECTION VERS TABLEAU([RAEMA]NumRAEMA;$TbR;[RAEMA]NumPage;$TbP;[RAEMA]Ordre;$TbO;[RAEMA]Intitule;$TbNat)
SELECTION TO ARRAY:C260([RAEMALignes:22]Identifiant:3;$TbR;[RAEMALignes:22]NomFr:4;$TbNat)
$TT:=Size of array:C274($TbR)
ARRAY TEXT:C222(<>TbTendanceToutesNumRaema;0)
ARRAY TEXT:C222(<>TbTendanceToutesNature;0)
ARRAY TEXT:C222(<>TbTendanceToutesPL;0)
For ($salé;1;$TT)
	$InituleCourant:=$TbNat{$salé}
	$NumCampagne:=Substring:C12($TbR{$salé};1;(Length:C16($TbR{$salé})-4))  // tient compte des RAEMA Gel
	$Page:=Substring:C12($TbR{$salé};(Length:C16($NumCampagne)+1);4)  // tient compte des RAEMA Gel
	$Nature:=""
	Case of 
		: ($InituleCourant="methode@")
			$Nature:="Méthode"
		: ($InituleCourant="fabricant@")
			$Nature:="Fabricant"
		: (($InituleCourant="Nature@") & ($InituleCourant#"@enrichissement@"))
			$Nature:="Milieu"
		: ($InituleCourant="Milieu d'isolement")
			$Nature:="Milieu d'isolement"
	End case 
	If ($Nature#"")
		APPEND TO ARRAY:C911(<>TbTendanceToutesNumRaema;$NumCampagne)
		APPEND TO ARRAY:C911(<>TbTendanceToutesNature;$Nature)
		APPEND TO ARRAY:C911(<>TbTendanceToutesPL;$Page)
		
	End if 
End for 
SORT ARRAY:C229(<>TbTendanceToutesNumRaema;<>TbTendanceToutesNature;<>TbTendanceToutesPL;>)