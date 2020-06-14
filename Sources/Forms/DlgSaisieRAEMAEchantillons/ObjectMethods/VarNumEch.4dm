$L:=Find in array:C230(TbNumEchRaema;VarNumEch)
If ($L<0)
	ALERT:C41("Aucun échantillon n'a le n°"+VarNumEch)
Else 
	OBJECT SET SCROLL POSITION:C906(*;"PoudreLBNumEchRaema";$L+10)
	LISTBOX SELECT ROW:C912(*;"PoudreLBNumEchRaema";$L)
End if 