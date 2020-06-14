$Evt:=Form event code:C388
Case of 
	: ($Evt=Sur chargement:K2:1)
		
		RELATE MANY:C262([Factures:15]NumFacture:3)
		$L:=Find in array:C230(<>TbPerUUID;[Factures:15]UUIDPersonne:2)
		$MontantFactureAvoir:=(Num:C11([Factures:15]TotalTTC:10<0)*(-[Factures:15]TotalTTC:10))+(Num:C11([Factures:15]TotalTTC:10>=0)*[Factures:15]TotalTTC:10)
		If ($MontantFactureAvoir>0)
			VarETLF:="Soit la somme de "+ZfEtl ($MontantFactureAvoir)+" en votre aimable réglement."
		Else 
			VarETLF:=""
		End if 
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
		
		If ($Et)
			VarRetenueSource:="La somme due ne tient pas compte d'éventuels frais bancaires qui restent entièrement à la charge de : "+<>TbPerAdrFacAd1{$L}
		Else 
			VarRetenueSource:=""
		End if 
		  // OBJET FIXER VISIBLE(*;"Etran@";$Et)
		
	: ($Evt=Sur impression corps:K2:18)
		  //OBJET FIXER FORMATAGE([Factures]TotalHT;<>PermEnE)
		  //OBJET FIXER FORMATAGE([Factures]TotalTVA;<>PermEnE)
		  //OBJET FIXER FORMATAGE([Factures]TotalTTC;<>PermEnE)
		  //OBJET FIXER FORMATAGE(VarTFF;<>PermEnF)
		
End case 