$T:=""
$Poudre:=(TbNR{TbNR}#"@a")
$TT:=Size of array:C274(TbNomGermeConta)
If ($Poudre)
	For ($Salé;1;$TT)
		$T:=$T+TbSerie1Conta{$Salé}+<>ZTab+TbSerie2Conta{$Salé}+<>ZTab
		$T:=$T+TbSerie3Conta{$Salé}+<>ZTab+TbSerie4Conta{$Salé}+<>ZTab
		$T:=$T+TbSerie5Conta{$Salé}+<>ZCR
	End for 
Else 
	For ($Salé;1;$TT)
		$T:=$T+TbSerie1Conta{$Salé}+<>ZCR
	End for 
End if 
ZVerrouAttendre (->[RAEMACampagnes:20])
OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";$T)
OB SET:C1220([RAEMACampagnes:20]Arguments:7;"N° des échantillons";ZTableauVersTexte (->TbNumEchRaema))
SAVE RECORD:C53([RAEMACampagnes:20])
ZAmnistiePartielle (->[RAEMACampagnes:20];True:C214)
