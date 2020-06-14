//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : admin
  // Date et heure : 14/05/13, 15:47:19
  // ----------------------------------------------------
  // Méthode : GA13AffecteCodeFacturation
  // Description
  // Donne un code de facturation RAEMA poudre à l'[Adhérents]
  // participant au RAEMA
  // Renvoie rien s'il n'y a pas participation au RAEMA 
  // et un premier caractère s'il y a participation
  // "1" si participation aux deux campagne RAEMA 
  // "2" si participation à la seule campagne de Mars
  // "3" si participation à la seule campagne d'Octobre
  // Complète le code par "B" s'il y a un bon de commande
  // et par X2 si la facturation est en deux fois
  // ----------------------------------------------------

$BdC:=OB Get:C1224([Personnes:12]Arguments:7;"NumBonCommandePoudre";Est un texte:K8:3)
$FactureMultiple:=(OB Get:C1224([Personnes:12]Arguments:7;"PayeDeuxFois";Est un texte:K8:3)="Vrai")

Case of 
	: (CaCMarsOK+CaCOctobreOK=2)
		$CodeFacturation:="1"
		
	: (CaCMarsOK=1)
		$CodeFacturation:="2"
		
	: (CaCOctobreOK=1)
		$CodeFacturation:="3"
		
	Else 
		$CodeFacturation:=""
End case 

If ($CodeFacturation#"") & ($BdC#"")
	$CodeFacturation:=$CodeFacturation+"B"
End if 

If ($FactureMultiple)
	$Calendrier:=""
	For ($Salé;1;12)
		$Pt:=Get pointer:C304("FSCasa"+String:C10($Salé))
		$Calendrier:=$Calendrier+String:C10($Pt->)
	End for 
	$CodeFacturation:=$CodeFacturation+" X"+$Calendrier
End if 

OB SET:C1220([Personnes:12]Arguments:7;"CodeFacturation";$CodeFacturation)