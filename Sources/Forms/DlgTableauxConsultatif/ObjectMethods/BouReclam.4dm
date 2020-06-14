QUERY:C277([RetoursFiches:24];[RetoursFiches:24]TypeRetour:5="Réclamation";*)
QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3>=VarDateDebut;*)
QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3<=VarDateFin)
ORDER BY:C49([RetoursFiches:24];[RetoursFiches:24]NumFiche:2;>)
SELECTION TO ARRAY:C260([RetoursFiches:24]NumFiche:2;$TbNumFiche;\
[RetoursFiches:24]UUID:1;$TbIDFiche;\
[RetoursFiches:24]Domaine:6;$TbDomaine;\
[RetoursFiches:24]Campagne:7;$TbCampagne;\
[RetoursFiches:24]Motif:9;$TbMotif;\
[RetoursFiches:24]NumFTNC:10;$TbFTNC)
$TT:=Size of array:C274($TbNumFiche)
$texte:=""
For ($salé;1;$TT)
	QUERY:C277([RetoursAdherents:27];[RetoursAdherents:27]IDFiche:2=$TbIDFiche{$salé})
	SELECTION TO ARRAY:C260([RetoursAdherents:27]IDAdherent:3;$TbNumRAEMAN)
	$labo:=ZTableauVersTexte (->$TbNumRAEMAN;", ")
	$Motif:=Replace string:C233($TbMotif{$salé};<>ZCR;" ")
	$Motif:=Replace string:C233($Motif;<>ZTab;" ")
	$texte:=$texte+$TbNumFiche{$salé}+<>ZTab+$Labo+<>ZTab+$TbDomaine{$salé}+<>ZTab+$TbCampagne{$salé}+<>ZTab+$Motif+<>ZTab+$TbFTNC{$salé}+<>ZCR
End for 
SET TEXT TO PASTEBOARD:C523($texte)
