//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/09/16, 13:02:04
  // ----------------------------------------------------
  // Méthode : RapActualisePriseRapport
  // Description
  // Actualise sur minuteur les tableaux 
  // des rapports pris <>ZoneRapLabPris ou non <>ZoneRapLabNonPris
  // ----------------------------------------------------


C_LONGINT:C283($Salé;1;$FT;$NumLabo;$Pos;$NumLaboRaemaN;$TT)
C_BOOLEAN:C305($RapportPris)
C_TEXT:C284($CodeRaemalié;$NumLaboRaemaA)
$H1:=Current time:C178

$NumCampagne:=<>PUMCampagne{<>PUMCampagne}
RecruteLaboParticipants ($NumCampagne)  // tous ceux qui ont participé au RAEMA
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDLabo;[CampagneParticipations:17]Arguments:5;$TbArgument)

$FT:=Size of array:C274($TbUUIDLabo)
For ($Salé;1;$FT)  // Pour chaque participation
	$RapportPris:=OB Get:C1224($TbArgument{$Salé};"RapportPris";Est un booléen:K8:9)
	$NumLaboRaemaA:=WebTrouveValeurParNom ($TbUUIDLabo{$Salé};-><>TbPerUUID;-><>TbPerNumLaboRAEMAA)
	$CodeRaemalié:=OB Get:C1224($TbArgument{$Salé};"CodeRaemaLié";Est un texte:K8:3)
	If ($CodeRaemalié#"")  // envoi lié à un laboratoire principal = $NumLaboRaemaA
		$NumRaemaLié:=String:C10(RAEMADemoduleMdPWeb ($CodeRaemalié))
		$NumLaboRaemaA:=$NumLaboRaemaA+"-"+$NumRaemaLié
	End if 
	$NumLaboN:=Num:C11($NumLaboRaemaA)
	If ($RapportPris) & (Find in array:C230(TbRapportsPris;$NumLaboRaemaA)<0)
		APPEND TO ARRAY:C911(TbRapportsPris;$NumLaboRaemaA)
		APPEND TO ARRAY:C911(TbRapportsPrisN;$NumLaboRaemaN)
		APPEND TO ARRAY:C911(TbRapportsPrisU;$TbUUIDLabo{$Salé})
		$L:=Find in array:C230(TbRapportsPris;$NumLaboRaemaA)
		DELETE FROM ARRAY:C228(TbRapportsPris;$L)
		DELETE FROM ARRAY:C228(TbRapportsPrisN;$L)
		DELETE FROM ARRAY:C228(TbRapportsPrisU;$L)
	End if 
End for 
MULTI SORT ARRAY:C718(TbRapportsPrisN;>;TbRapportsPris;>;TbRapportsPrisU)
MULTI SORT ARRAY:C718(TbRapportsNonPrisN;>;TbRapportsNonPris;>;TbRapportsNonPrisU)

  // renseignement des variables associées
VarRapNonObt:=RapInitEti (->TbRapportsNonPris)
VarRapRetenus:=RapInitEti (->TbRapportsRetenus)

