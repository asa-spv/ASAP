
$NomDoc:=Select document:C905("";"*";"Sélectionnez les documents";0)
If (OK=1) & ($NomDoc#"")
	$TailleDoc:=Get document size:C479(Document)
	$PoidsTotal:=Sum:C1(TbCourrielsTaille)+$TailleDoc
	If ($PoidsTotal>(VarTailleMax*1000000))
		$Mess:="Désolé, je ne peux inclure la PJ "+<>ZGuil+$NomDoc+<>ZGuil
		$Mess:=$Mess+" car le poids des PJ ("+String:C10(Round:C94($PoidsTotal/1000000;2))+"Mo)"
		$Mess:=$Mess+" dépasse la taille maximum qui est de "+String:C10(VarTailleMax;"### Mo")
		ALERT:C41($Mess)
	Else 
		APPEND TO ARRAY:C911(TbCourrielsCDPJ;Document)
		APPEND TO ARRAY:C911(TbCourrielsNomPJ;$NomDoc)
		APPEND TO ARRAY:C911(TbCourrielsTaille;$TailleDoc)
	End if 
End if 