//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/08/18, 07:18:06
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSuiviAfficheTbChoix
  // Description
  // Affiche dans le tableau de "DlgSuiviResultats"
  //  la liste des laboratoires choisis dans PUMChoix
  // ----------------------------------------------------

  // SÉLECTION VERS TABLEAU([CampagneParticipation]NumLaboEntier;TbParticipantN;[CampagneParticipation]TexteParticipation1;TbHistorique)
  //TRIER([CampagneParticipation];[CampagneParticipation]UUIDPersonne;>)
$FT:=Records in selection:C76([CampagneParticipations:17])
ARRAY LONGINT:C221(TbParticipantN;$FT)
ARRAY LONGINT:C221(TbCouleurFond;$FT)
ARRAY TEXT:C222(TbParticipantA;$FT)
ARRAY TEXT:C222(TbTexteParticipation;$FT)
$Couleur:=0x00FFFFFF
FIRST RECORD:C50([CampagneParticipations:17])
For ($Salé;1;$FT)
	TbParticipantA{$Salé}:=String:C10(ASAPTrouveNumeroLaboParUUID ([CampagneParticipations:17]UUIDPersonne:2))
	TbParticipantN{$Salé}:=Num:C11(TbParticipantA{$Salé})
	$RL:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"CodeRaemaLié";Est un texte:K8:3)
	$RL:=[CampagneParticipations:17]Arguments:5.CodeRaemaLié  // première utilisation de la notation pointée par cgm !!!!
	If ($RL#"")
		$RL:=Substring:C12($RL;1;10)
		TbParticipantA{$Salé}:=TbParticipantA{$Salé}+" - "+String:C10(RAEMADemoduleMdPWeb ($RL))
	End if 
	TbTexteParticipation{$Salé}:=[CampagneParticipations:17]TexteParticipation:4
	Case of 
		: (Is in set:C273("envoyé"))
			$Couleur:=0x00C0F99A
			
		: (Is in set:C273("absence"))
			$Couleur:=0x00F9B09A
			
		Else   // en cours
			$Couleur:=0x00F2F290
	End case 
	TbCouleurFond{$Salé}:=$Couleur
	NEXT RECORD:C51([CampagneParticipations:17])
End for 
LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17];TbNumEnrLP)

MULTI SORT ARRAY:C718(TbParticipantN;>;TbParticipantA;>;TbTexteParticipation;TbCouleurFond;TbNumEnrLP)
VarNbLaboP:=Size of array:C274(TbParticipantA)

