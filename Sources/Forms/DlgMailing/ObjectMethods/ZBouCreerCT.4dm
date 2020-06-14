FORM SET INPUT:C55([CourrielsTypes:28];"Entrée")
ADD RECORD:C56([CourrielsTypes:28];*)
If (OK=1)
	$NomLettre:=[CourrielsTypes:28]NomLettre:2
	ALL RECORDS:C47([CourrielsTypes:28])
	ORDER BY:C49([CourrielsTypes:28];[CourrielsTypes:28]NomLettre:2;>)
	SELECTION TO ARRAY:C260([CourrielsTypes:28]NomLettre:2;ZZonelettre)
	LONGINT ARRAY FROM SELECTION:C647([CourrielsTypes:28];TbNumEnrLT)
	$L:=Find in array:C230(ZZonelettre;$NomLettre)
	LISTBOX SELECT ROW:C912(*;"LBCT";$L)
	  // OBJET FIXER DÉFILEMENT 
	ZEntêteLettre:=""
End if 