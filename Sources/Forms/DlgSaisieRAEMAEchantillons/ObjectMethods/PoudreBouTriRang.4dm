
C_LONGINT:C283($Salé;$FT)
$FT:=Size of array:C274(TbNumEchRaema)
ARRAY TEXT:C222(TbNumEchTriés;$FT)
For ($Salé;1;$FT)
	TbNumEchTriés{$Salé}:=Substring:C12(String:C10(TbNumEchRaema{$Salé});TbRR{TbRR})
End for 
SORT ARRAY:C229(TbNumEchTriés;TbNumEchRaema;>)