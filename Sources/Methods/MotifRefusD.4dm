//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/08/18, 06:25:04
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : MotifRefusD
  // Description
  // 
$Intitule:=$1
$ChapitreRaema:=TbNomDesGermes{Size of array:C274(TbNomDesGermes)}
If (LangueCourante="F")
	$Refus:="La valeur "+<>ZGuil+ValeurProposée+<>ZGuil+" pour la ligne "+$Intitule+" de la partie "+$ChapitreRaema+" n'est pas correcte : "
	$Refus:=$Refus+"taper la date dans le format précisé dans la question"
Else 
	$Refus:="The value "+<>ZGuil+ValeurProposée+<>ZGuil+" for the item "+$Intitule
	$Refus:=$Refus+" of part "+$ChapitreRaema+" is not correct: "
	$Refus:=$Refus+"type only a date in the format specified in the question"
End if 

$0:=$Refus