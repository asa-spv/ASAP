PRINT SETTINGS:C106
If (OK=1)
	C_LONGINT:C283($salé;$fumé;$sec;$TT;$FT;$HauteurMax)
	GET PRINTABLE AREA:C703($HauteurMax)
	$HauteurRestante:=$HauteurMax
	ARRAY TEXT:C222(TbQuoi;3)
	TbQuoi{1}:="Méthode"
	TbQuoi{2}:="Fabricant"
	TbQuoi{3}:="Milieu"
	$TT:=Size of array:C274(ZoneChose)
	VarC1:=OBJECT Get title:C1068(Campagne1)
	VarC2:=OBJECT Get title:C1068(Campagne2)
	CouleurFond:=0x00FFFFFF
	For ($salé;1;$TT)
		VarGerme:=ZoneChose{$salé}
		For ($fumé;1;3)
			VarNature:=TbQuoi{$fumé}
			VarTitre:=Num:C11(($salé=1) & ($fumé=1))*("Valeurs et occurrences"+<>ZCR+"des campagnes "+VarC1+" et "+VarC2)
			$H:=Print form:C5("DlgTendanceImprime";0;106)
			$HauteurRestante:=$HauteurRestante-$H
			  // recalcul méthode BouFinal
			RaemaTendanceBouFinal (True:C214)
			$FT:=Size of array:C274(Colonne9)
			$HauteurImpressionBloc:=106+($FT*(119-106))
			  //Si ($HauteurImpressionBloc>$HauteurRestante)
			  //SAUT DE PAGE(>)
			  //$HauteurRestante:=$HauteurMax
			  //Fin de si 
			For ($sec;1;$FT)
				VarValeur:=Colonne9{$sec}
				VarOccurrence1:=Colonne10N{$sec}
				VarOccurrence2:=Colonne11N{$sec}
				CouleurFond:=(Num:C11($sec%2=1)*0x00F2F2F2)+(Num:C11($sec%2=0)*0x00FEFEFE)
				$H:=Print form:C5("DlgTendanceImprime";106;119)
			End for 
		End for 
	End for 
	PAGE BREAK:C6
End if 