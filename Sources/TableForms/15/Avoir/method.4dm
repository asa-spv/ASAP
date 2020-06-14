$Evt:=Form event code:C388
Case of 
	: ($Evt=Sur impression corps:K2:18)
		RELATE MANY:C262([Factures:15]NumFacture:3)
		$L:=Find in array:C230(<>TbPerUUID;[Factures:15]UUIDPersonne:2)
		VarETLF:="Soit la somme de "+ZfEtl ([Factures:15]TotalTTC:10)+" en votre aimable réglement."
		VarTVAIntra:=("N° TVA intracommunautaire : "+<>TbPANumTVAIntraCom{$L})*Num:C11(<>TbPANumTVAIntraCom{$L}#"")
		VarNumClient:=<>TbPerNumPersonne{$L}
		If ([Factures:15]NumFacture:3="@d")
			VarTypeFac:="DEVIS"
		Else 
			If ([Factures:15]NumFacture:3="@a")
				VarTypeFac:="AVOIR de la facture "+Substring:C12([Factures:15]NumFacture:3;1;(Length:C16([Factures:15]NumFacture:3)-1))
			Else 
				VarTypeFac:="FACTURE"
			End if 
		End if 
		$Et:=((<>TbPerAdrLivPays{$l}#"france") & (<>TbPerAdrLivPays{$l}#""))
		OBJECT SET VISIBLE:C603(*;"Etran@";$Et)
		
End case 