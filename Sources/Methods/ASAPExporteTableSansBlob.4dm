//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : asa-spv
  // Date et heure : 08/07/18, 06:15:20
  // ----------------------------------------------------
  // Méthode : ASAPExporteTableSansBlob
  // Description
  // Méthode d'exportation des données de Biblio
  //  du contenu d'une table sansz blob et sans image
  // Paramètres : $1 = Pt sur la table a exporter  
  //              $2 = Annonce du fichier
  //              {$3} = Booléen de création de sélection
  //              {$4} = Pt sur champ indispensable
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$NumTable;$Type)
C_TEXT:C284($2;$Annonce)
C_POINTER:C301($1;$PtTable)
C_BOOLEAN:C305($3)

$PtTable:=$1
$Annonce:=$2
If (Count parameters:C259#3)
	If (Count parameters:C259>2)
		C_POINTER:C301($4)
		$PtChampIndispensable:=$4
		QUERY:C277($PtTable->;$PtChampIndispensable->#"")
	Else 
		ALL RECORDS:C47($PtTable->)
	End if 
End if 
$NumTable:=Table:C252($PtTable)
$FT:=Get last field number:C255($PtTable)
ARRAY LONGINT:C221($TbType;0)
ARRAY TEXT:C222($TbNomTableau;0)

For ($Salé;1;$FT)
	If (Is field number valid:C1000($NumTable;$Salé))
		$PtChamp:=Field:C253($NumTable;$Salé)
		$Type:=Type:C295($PtChamp->)
		$NomTableau:="$Tb"+Field name:C257($PtChamp)
		Case of 
				
			: ($Type=Est un champ alpha:K8:1) | ($Type=Est un texte:K8:3)
				$PtTe:=Get pointer:C304($NomTableau)
				ARRAY TEXT:C222($PtTe->;0)
				SELECTION TO ARRAY:C260($PtChamp->;$PtTe->;*)
				
			: ($Type=Est un BLOB:K8:12)
				TRACE:C157
				
			: ($Type=Est un entier:K8:5) | ($Type=Est un entier long:K8:6) | ($Type=Est un numérique:K8:4)
				$PtNu:=Get pointer:C304($NomTableau)
				ARRAY REAL:C219($PtNu->;0)
				SELECTION TO ARRAY:C260($PtChamp->;$PtNu->;*)
				
			: ($Type=Est un booléen:K8:9)
				$PtBo:=Get pointer:C304($NomTableau)
				ARRAY BOOLEAN:C223($PtBo->;0)
				SELECTION TO ARRAY:C260($PtChamp->;$PtBo->;*)
				
			: ($Type=Est une date:K8:7)
				$PtDa:=Get pointer:C304($NomTableau)
				ARRAY DATE:C224($PtDa->;0)
				SELECTION TO ARRAY:C260($PtChamp->;$PtDa->;*)
				
			: ($Type=Est une heure:K8:8)
				$PtHe:=Get pointer:C304($NomTableau)
				ARRAY TIME:C1223($PtHe->;0)
				SELECTION TO ARRAY:C260($PtChamp->;$PtHe->;*)
				
			: ($Type=Est une image:K8:10)
				TRACE:C157
				
			Else 
				TRACE:C157
		End case 
		APPEND TO ARRAY:C911($TbType;$Type)
		APPEND TO ARRAY:C911($TbNomTableau;$NomTableau)
	End if 
End for 

SELECTION TO ARRAY:C260

$Doc:=Create document:C266("")
$FT:=Size of array:C274($PtTe->)
$SFT:=Size of array:C274($TbNomTableau)
$Envoi:=$Annonce+String:C10($FT)+"_"+String:C10($SFT)+<>ZCR


SEND PACKET:C103($Doc;$Envoi)
$ET:=""
For ($Fumé;1;$SFT)  // pour chaque champ
	If ($Fumé<$SFT)
		$ET:=$ET+Substring:C12($TbNomTableau{$Fumé};4)+<>ZTab
	Else 
		$ET:=$ET+Substring:C12($TbNomTableau{$Fumé};4)+<>ZCR
	End if 
End for 
  // FIXER TEXTE DANS CONTENEUR($ET)
SEND PACKET:C103($Doc;$ET)

For ($Salé;1;$FT)  // pour chaque enregistrement
	$Envoi:=""
	For ($Fumé;1;$SFT)  // pour chaque champ
		$NomCourant:=$TbNomTableau{$Fumé}
		$PtBl:=Get pointer:C304($NomCourant)
		$Type:=$TbType{$Fumé}
		$Texte:=String:C10($PtBl->{$Salé})
		If ($Type=Est un texte:K8:3)
			$Texte:=Replace string:C233($Texte;<>ZCR;"£")
			$Texte:=Replace string:C233($Texte;<>ZTab;" ")
		Else 
			$Texte:=Replace string:C233($Texte;<>ZCR;" ")
			$Texte:=Replace string:C233($Texte;<>ZTab;" ")
		End if 
		$Envoi:=$Envoi+$Texte
		$Envoi:=$Envoi+(Num:C11($Fumé<$SFT)*<>ZTab)+(Num:C11($Fumé=$SFT)*<>ZCR)
	End for 
	SEND PACKET:C103($Doc;$Envoi)
	  // FIXER TEXTE DANS CONTENEUR($Envoi)
	
End for 
CLOSE DOCUMENT:C267($Doc)