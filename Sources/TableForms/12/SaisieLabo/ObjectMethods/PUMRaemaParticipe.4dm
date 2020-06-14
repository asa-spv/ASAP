C_LONGINT:C283($Salé;$FT)
$Campagne:=PUMRaemaParticipe{PUMRaemaParticipe}
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]NumCampagne:3=$Campagne)
If (Records in selection:C76([CampagneParticipations:17])=1)
	VarParticipe:=[CampagneParticipations:17]TexteParticipation:4
	OBJECT SET VISIBLE:C603(PUMRaemaParticipeLié;False:C215)
Else 
	VarParticipe:=""
	ARRAY OBJECT:C1221($TbArg;0)
	ARRAY LONGINT:C221($TbNumEnrRaemaParticipeLié;0)
	SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5;$TbArg;[CampagneParticipations:17]TexteParticipation:4;$TbTexteParticipe)
	LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17];$TbNumEnrRaemaParticipeLié)
	$FT:=Size of array:C274($TbArg)
	ARRAY TEXT:C222(PUMRaemaParticipeLié;0)
	ARRAY LONGINT:C221(TbNumEnrRaemaParticipeLié;0)
	For ($Salé;1;$FT)
		$CodeCourant:=OB Get:C1224($TbArg{$Salé};"CodeRaemaLié";Est un texte:K8:3)
		If ($CodeCourant="")
			VarParticipe:=$TbTexteParticipe{$Salé}
			APPEND TO ARRAY:C911(PUMRaemaParticipeLié;String:C10(RAEMADemoduleMdPWeb ([Personnes:12]Identificateur:4)))
			APPEND TO ARRAY:C911(TbNumEnrRaemaParticipeLié;$TbNumEnrRaemaParticipeLié{$Salé})
		Else 
			APPEND TO ARRAY:C911(PUMRaemaParticipeLié;String:C10(RAEMADemoduleMdPWeb ($CodeCourant)))
			APPEND TO ARRAY:C911(TbNumEnrRaemaParticipeLié;$TbNumEnrRaemaParticipeLié{$Salé})
		End if 
	End for 
	SORT ARRAY:C229(PUMRaemaParticipeLié;TbNumEnrRaemaParticipeLié;>)
	PUMRaemaParticipeLié:=1
	OBJECT SET VISIBLE:C603(PUMRaemaParticipeLié;True:C214)
End if 
