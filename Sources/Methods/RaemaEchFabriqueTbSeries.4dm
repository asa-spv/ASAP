//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 10/08/19, 06:57:05
  // ----------------------------------------------------
  // Méthode : RaemaEchFabriqueTbSeries
  // Description
  // Méthode qui affiche les n° d'échantillons 
  //  dans la Listbox ListBoxRaemaEchantillons
  //  du formulaire projet "DlgSaisieRAEMAEchantillons"
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
If (Size of array:C274(TbNumEchRaema)>0)
	  // initialisons les tableaux des séries
	ARRAY TEXT:C222(TbNumEchRaema1;0)
	ARRAY TEXT:C222(TbNumEchRaema2;0)
	ARRAY TEXT:C222(TbNumEchRaema3;0)
	ARRAY TEXT:C222(TbNumEchRaema4;0)
	ARRAY TEXT:C222(TbNumEchRaema5;0)
	  // tri du tableau par le rang
	$FT:=Size of array:C274(TbNumEchRaema)
	For ($Salé;1;$FT)
		$CarN:=Num:C11(TbNumEchRaema{$Salé}[[TbRR{TbRR}]])
		$RangSérie:=1+(Num:C11($CarN>1))+(Num:C11($CarN>3))+(Num:C11($CarN>5))+(Num:C11($CarN>7))
		$PtTb:=Get pointer:C304("TbNumEchRaema"+String:C10($RangSérie))
		APPEND TO ARRAY:C911($PtTb->;TbNumEchRaema{$Salé})
	End for 
End if 