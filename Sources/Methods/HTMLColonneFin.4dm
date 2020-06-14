//%attributes = {}
  // HTMLColonneFin
  // {$1} =  vrai si la colonne est la dernière
C_BOOLEAN:C305($1)

$Texte:=<>ZCR+"            </td>"+<>ZCR
If (Count parameters:C259=1)
	$Texte:=$Texte+"          </tr>"+<>ZCR
End if 
$0:=$Texte
