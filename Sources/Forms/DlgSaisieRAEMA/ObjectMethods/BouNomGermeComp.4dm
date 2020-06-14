  // Page 3 = contamination

VarNomTableau:="Niveau de contamination du RAEMA "+TbNR{TbNR}
$RaemaPoudre:=(TbNR{TbNR}#"@a")
COPY ARRAY:C226(TbNomGermeFR;TbNomGermeConta)
DELETE FROM ARRAY:C228(TbNomGermeConta;1)
$GloubiBoulga:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)
RaemaFabriqueLBContamination ($GloubiBoulga)
ARRAY TEXT:C222(TbNumEchRaema;0)
If ($RaemaPoudre)  // Seulement pour la poudre
	$listeEch:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"N° des échantillons";Est un texte:K8:3)
	ZTexteVersTableau ($listeEch;->TbNumEchRaema)
End if 
OBJECT SET VISIBLE:C603(*;"Poudre@";$RaemaPoudre)
OBJECT SET VISIBLE:C603(*;"BouGermeGel@";False:C215)

