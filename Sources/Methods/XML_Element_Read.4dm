//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 18/06/11
  // ----------------------------------------------------
  // Méthode : XML_Read_Element
  // Description
  // 
  // Paramètres
  // $0 = Valeur de l'élément
  // $1 = Référence XML
  // $2 = Clé XML
  // ----------------------------------------------------

C_TEXT:C284($0;$1;$2)

$0:=""

If (Count parameters:C259=2)
	$XML:=$1
	$Clé:=$2
	
	$vTrouvé:=DOM Find XML element:C864($XML;$Clé)
	If ($vtrouvé="0000000000000000")
		  // Ben Il n'existe pas
	Else 
		
		DOM GET XML ELEMENT VALUE:C731($vTrouvé;$Valeur)
		$0:=$Valeur
	End if 
End if 