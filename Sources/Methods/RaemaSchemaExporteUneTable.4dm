//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/08/18, 07:05:05
  // ----------------------------------------------------
  // Paramètre : $1 = Pt sur champ identifiant
  // ----------------------------------------------------
  // Méthode : RaemaSchemaExporteUneTable
  // Description
  // // Méthode qui exporte une table qui compose le RAEMA affiché

C_POINTER:C301($PtIdentifiant;$1)
C_LONGINT:C283($NumTable)

$PtIdentifiant:=$1
$NumTable:=Table:C252($PtIdentifiant)
$PtTable:=Table:C252($NumTable)
$NumTableA:=String:C10(Table:C252($PtIdentifiant))
SEND VARIABLE:C80($NumTableA)  // Tag de la table
$TestCampagne:=TbNR{TbNR}+"@"
QUERY:C277($PtTable->;$PtIdentifiant->=$TestCampagne)  // Sélection des enregistrements de 
$FT:=Records in selection:C76($PtTable->)
For ($Salé;1;$FT)
	$Fichier:="Une autre"
	SEND VARIABLE:C80($Fichier)
	SEND RECORD:C78($PtTable->)
	NEXT RECORD:C51($PtTable->)
End for 