
C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222($TbTests;5)
For ($Salé;1;5)
	$PtTb:=Get pointer:C304("TbNumEchRaema"+String:C10($Salé))
	$LigneHasard:=ZBaseNombreHasardEncadré (1;Size of array:C274($PtTb->))
	$TbTests{$Salé}:=$PtTb->{$LigneHasard}
	SET TEXT TO PASTEBOARD:C523($TbTests{$Salé})
	DELAY PROCESS:C323(Current process:C322;60)
End for 
ALERT:C41("Les 5 n° d'échantillons sont dans le presse-papier...")