CONFIRM:C162("Désirez-vous exporter la traduction du RAEMA n°"+TbNR{TbNR})
If (OK=1)
	C_LONGINT:C283($salé;1;$FT)
	$doc:=Create document:C266("")
	If (OK=1)
		$FT:=Size of array:C274(TbTraducTableauF)
		For ($salé;1;$FT)
			$Var:=String:C10(TbTraducN{$salé})+<>ZTab+TbTraducTableauF{$salé}+<>ZTab+TbTraducTableauA{$salé}+<>ZCR
			SEND PACKET:C103($doc;$Var)
		End for 
	End if 
	CLOSE DOCUMENT:C267($doc)
End if 