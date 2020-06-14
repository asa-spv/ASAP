//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/09/15, 08:11:40
  // ----------------------------------------------------
  // Méthode : HTMLColonneDébut
  // Description
  // Paramètres
  // $1= nom de la classe
  // {$2} = vrai si retour à la ligne préalable
  // ----------------------------------------------------


C_BOOLEAN:C305($2)
$Class:=$1
$RetourLigne:=$2

$guill:=<>ZGuil
$Retour:=""

If (Count parameters:C259=4)
	If ($RetourLigne)
		$Retour:="             "+<>ZCR+"<br /> <br /> "+<>ZCR
	End if 
End if 

$0:="            <td class="+$guill+$Class+$guill+">"+$Retour+<>ZCR
