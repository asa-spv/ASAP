If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283($C;$L)
	LISTBOX GET CELL POSITION:C971(*;"ListBoxValeurs";$C;$Li)
	If ($Li>0)
		GOTO SELECTED RECORD:C245([RAEMAValeurs:23];$Li)
		VarTipsFr:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"TipsFr";Est un texte:K8:3)
		VarTipsEn:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"TipsEn";Est un texte:K8:3)
		VarMilieu:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Milieu";Est un texte:K8:3)
		VarFabricant:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Fabricant";Est un texte:K8:3)
		If (VarMilieu#"")
			SELECTION TO ARRAY:C260([RAEMALignes:22]NomFr:4;$TbNomLigne;[RAEMALignes:22]Identifiant:3;$TbId)
			$L:=Find in array:C230($TbNomLigne;"Nature@")
			If ($L>0)
				$IdentifiantLigne:=$TbId{$L}
				CUT NAMED SELECTION:C334([RAEMAValeurs:23];"bons")
				QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=($IdentifiantLigne+"@"))
				SELECTION TO ARRAY:C260([RAEMAValeurs:23]NomEn:5;PUMMilieu;[RAEMAValeurs:23]Identifiant:3;$TbId)
				SORT ARRAY:C229($TbId;PUMMilieu;>)
				PUMMilieu:=Find in array:C230(PUMMilieu;VarMilieu)
				USE NAMED SELECTION:C332("bons")
				LISTBOX SELECT ROW:C912(*;"ListBoxValeurs";$Li)
			End if 
		End if 
	End if 
End if 
