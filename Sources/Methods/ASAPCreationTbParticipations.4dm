//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 31/01/19, 17:18:58
  // ----------------------------------------------------
  // Paramètre pas de
  // ----------------------------------------------------
  // Méthode : ASAPAfficheTbParticipations
  // Description
  // Méthode qui affiche la sélection des [CampagneParticipations]
  // sous forme de deux tableaux synchonisés : 
  // l'un avec le nom de la campagne éventuellement suivi du n° de RAEMA lié
  // L'autre avec les n° d'enregistrement de la table [CampagneParticipations]

C_LONGINT:C283($Salé;$FT)

SELECTION TO ARRAY:C260([CampagneParticipations:17]NumCampagne:3;$TbNumCampagne;[CampagneParticipations:17]TexteParticipation:4;TbTexteParticipation;[CampagneParticipations:17]Arguments:5;$TbCampagneArgument)
$FT:=Size of array:C274($TbNumCampagne)
ARRAY TEXT:C222(TbNumCampagneA;$FT)
LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17];TbNumEnrCamp)
For ($Salé;1;$FT)
	TbNumCampagneA{$Salé}:=$TbNumCampagne{$Salé}
	$RL:=OB Get:C1224($TbCampagneArgument{$Salé};"CodeRaemaLié";Est un texte:K8:3)
	If ($RL#"")
		$RL:=Substring:C12($RL;1;10)
		TbNumCampagneA{$Salé}:=TbNumCampagneA{$Salé}+" - "+String:C10(RAEMADemoduleMdPWeb ($RL))
	End if 
End for 
SORT ARRAY:C229(TbNumCampagneA;TbNumEnrCamp;TbTexteParticipation;>)
