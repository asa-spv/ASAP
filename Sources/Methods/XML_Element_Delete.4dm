//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 08/06/11
  // ----------------------------------------------------
  // Méthode : XML_DeleteElement
  // Description
  //
  // Paramètres
  // $1 = Référence XML
  // $2 = Clé XML
  // ----------------------------------------------------

C_TEXT:C284($1;$2)

If (Count parameters:C259=2)
	$XML:=$1
	$Clé:=$2
	
	$vTrouvé:=DOM Find XML element:C864($XML;$Clé)
	If ($vtrouvé="0000000000000000")
		  // Ben Il n'existe pas
	Else 
		
		DOM REMOVE XML ELEMENT:C869($vTrouvé)
	End if 
End if 