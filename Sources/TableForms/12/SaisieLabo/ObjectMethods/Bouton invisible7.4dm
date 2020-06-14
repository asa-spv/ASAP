$evt:=Form event code:C388
Case of 
		
	: ($evt=Sur clic:K2:4)
		  //OBJET FIXER SAISISSABLE(*;"Cgmcg@";Vrai)
		  //OBJET FIXER VISIBLE(BouModifNumAdh;Vrai)
		CONFIRM:C162("Changer le code d'accès au Web "+[Personnes:12]Identificateur:4+"???")
		If (OK=1)
			$NouveauCode:=GAInitIdentificateurPersonne 
			While ($NouveauCode=[Personnes:12]Identificateur:4)
				$NouveauCode:=GAInitIdentificateurPersonne 
			End while 
			$Mess:="Changement du code d'accès au Web de "+[Personnes:12]Identificateur:4+" en "+$NouveauCode
			$Remarques:=OB Get:C1224([Personnes:12]Arguments:7;"Remarques";Est un texte:K8:3)+<>ZCR+"le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" : "+$Mess
			OB SET:C1220([Personnes:12]Arguments:7;"Remarques";$Remarques)
			VarRemarque:=OB Get:C1224([Personnes:12]Arguments:7;"Remarques";Est un texte:K8:3)
			[Personnes:12]Identificateur:4:=$NouveauCode
		End if 
End case 