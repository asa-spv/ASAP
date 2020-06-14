//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 08/06/11
  // ----------------------------------------------------
  // Méthode : XML_UpdateElement
  // Description
  //
  // Paramètres
  // $1 = Référence XML
  // $2 = Clé XML
  // $3 = Valeur
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$3)

If (Count parameters:C259=3)
	$XML:=$1
	$Clé:=$2
	$Valeur:=$3
	
	$vTrouvé:=DOM Find XML element:C864($XML;$Clé)
	If ($vtrouvé="0000000000000000")
		$vTrouvé:=DOM Create XML element:C865($XML;$Clé)
	End if 
	
	DOM SET XML ELEMENT VALUE:C868($vTrouvé;$Valeur)
	
End if 