//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/04/18, 09:03:44
  // ----------------------------------------------------
  // Paramètres 
  // {$1} =  [XAttributions]UUIDUtilisateur
  // {$2} =  [XAttributions]UUIDFonction
  // $0 = 
  // ----------------------------------------------------
  // Méthode : ZDroitsDecritAttribution
  // Description
  // méthode qui décrit [XAttributions]Descriptif
  //  qui rend plus lisible la table [XAttributions]

If (Count parameters:C259=0)
	$IDU:=[XAttributions:5]UUIDUtilisateur:2
	$IDF:=[XAttributions:5]UUIDFonction:3
	
Else 
	$IDU:=$1
	$IDF:=$2
	
End if 

If (Is new record:C668([XUtilisateurs:2]))
	$Code:=[XUtilisateurs:2]Initiales:4
	
Else 
	$L:=Find in array:C230(<>TbUtilUUID;$IDU)
	$Code:=<>TbUtilInitiales{$L}
	
End if 

$L:=Find in array:C230(<>TbFonctionsUUID;$IDF)
$NF:=<>TbFonctionsNomFonction{$L}
$0:=$Code+"-"+$NF