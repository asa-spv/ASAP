//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/09/16, 07:08:31
  // ----------------------------------------------------
  // Méthode : MotifRefusN
  // Description
  // Explicite le motif du refus d'une valeur numérique
  //
  // Paramètre $1 = intitulé de la ligne
  // ----------------------------------------------------
$Intitule:=$1
$ChapitreRaema:=TbNomDesGermes{Size of array:C274(TbNomDesGermes)}
If (LangueCourante="F")
	$Refus:="La valeur "+<>ZGuil+ValeurProposée+<>ZGuil+" pour la ligne "+$Intitule
	$Refus:=$Refus+" de la partie "+$ChapitreRaema+" n'est pas correcte : "
	$Refus:=$Refus+"taper uniquement un nombre dans l'unité précisée dans la question"
Else 
	$Refus:="The value "+<>ZGuil+ValeurProposée+<>ZGuil+" for the item "+$Intitule
	$Refus:=$Refus+" of part "+$ChapitreRaema+" is not correct: "
	$Refus:=$Refus+"type only a number"
End if 
$0:=$Refus