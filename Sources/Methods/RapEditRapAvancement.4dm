//%attributes = {}
  // RapEditRapAvancement
PRINT SETTINGS:C106
If (OK=1)
	VarETRapportAv:="RAPPORT sur l'état d'avancement de la campagne RAEMA n°"+<>PUMCampagne{<>PUMCampagne}
	VarETRapportAv:=VarETRapportAv+<>ZCR+"Le "+String:C10(Current date:C33;Système date long:K1:3)+" à "+String:C10(Current time:C178)
	$C:="Préalable des adresses courriel : "+Replace string:C233(VarEtaMailRap;<>ZCR;" ")
	$InfoRap:=Replace string:C233(VarValDosRap;<>ZCR;",  ")
	$InfoRap:=Replace string:C233($InfoRap;" : ";"")
	$C:=$C+<>ZCR2+"Préalable rapport de campagne : "+$InfoRap
	$TT1:=Size of array:C274(TbRapMailNonEnvoi)
	$TT2:=Size of array:C274(TbRapMailEnvoi)
	$S:=Num:C11($TT1>1)*"s"
	$C:=$C+<>ZCR2+"Envoi des courriels : sur "+String:C10($TT1+$TT2)+" participants, il y a "+String:C10($TT1)+" non envoyé"+$s+<>ZCR
	$S:=Num:C11($TT2>1)*"s"
	$Détail:=" ("+ZTableauVersTexte (->TbRapMailNonEnvoi;", ")+")"+<>ZCR
	$C:=$C+(Num:C11($TT1>0)*$Détail)+" et "+String:C10($TT2)+" envoyé"+$s+<>ZCR
	$Détail:=" ("+ZTableauVersTexte (->TbRapMailEnvoi;", ")+")"+<>ZCR
	$C:=$C+(Num:C11($TT2>0)*$Détail)
	$TT1:=Size of array:C274(TbRapportsNonPris)
	$TT2:=Size of array:C274(TbRapportsPris)
	$TT3:=Size of array:C274(TbRapportsRetenus)
	$srr:=Num:C11($TT3>1)*"s"
	$C:=$C+<>ZCR2+"Rapport"+$srr+" retenu"+$srr+" : sur "+String:C10($TT1+$TT2+$TT3)+" participants, il y a "+String:C10($TT3)+" retenu"+$srr+<>ZCR
	If ($TT3>0)
		$Détail:=" ("+ZTableauVersTexte (->TbRapportsRetenus;", ")+")"
		$C:=$C+$Détail
	End if 
	$C:=$C+<>ZCR2+"Récupération des rapports : sur "+String:C10($TT1+$TT2)+" participants dont le rapport n'a pas été retenu, il y a "+<>ZCR+String:C10($TT1)+" non pris"+<>ZCR
	$Détail:=" ("+ZTableauVersTexte (->TbRapportsNonPris;", ")+")"
	$C:=$C+(Num:C11($TT1>0)*$Détail)+<>ZCR+" et "+String:C10($TT2)+" pris"+<>ZCR
	$Détail:=" ("+ZTableauVersTexte (->TbRapportsPris;", ")+")"
	$C:=$C+(Num:C11($TT2>0)*$Détail)+"."
	
	
	
	VarCorpsRapportAv:=$C
	$L:=Print form:C5("RapportImpAvancement")
	PAGE BREAK:C6
End if 