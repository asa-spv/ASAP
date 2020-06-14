If (TbComSaisie=0)
	ALERT:C41("Merci de désigner quel laboratoire...")
Else 
	$NumRaemaA:=String:C10(TbComSaisie{TbComSaisie})
	$L:=Find in array:C230(<>TbPerNumLaboRAEMA;Num:C11($NumRaemaA))
	$CodeLabo:=<>TBPERIDENTIFICATEUR{$L}
	GOTO RECORD:C242([WebConnexions:13];TbNumEnrComSaisie{TbComSaisie})
	  //CHERCHER([WebConnexions];[WebConnexions]Campagne=VARNUMRAEMA;*)
	  //CHERCHER([WebConnexions];[WebConnexions]CodeConnexion=$CodeLabo;*)
	  //CHERCHER([WebConnexions];[WebConnexions]Commentaire#"")
	If (Records in selection:C76([WebConnexions:13])>0)
		  //SÉLECTION VERS TABLEAU([WebConnexions]CodeConnexion;$TbCodePersonne\
			;[WebConnexions]TexteMail;$TbSaisie)
		  //$L2:=Chercher dans tableau($TbCodePersonne;$CodeLabo)
		  //$Saisie:=$TbSaisie{$L2}
		$message:="Bonjour,"+<>ZCR2+"Vous avez souhaitez recevoir la saisie du laboratoire "+$NumRaemaA
		$message:=$message+" pour la campagne n°"+VARNUMRAEMA+" :"+<>ZCR2+[WebConnexions:13]TexteMail:6+<>ZCR
		$message:=$message+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
		
		$Sujet:="Saise du RAEMA n°"+VARNUMRAEMA+" par le laboratoire "+$NumRaemaA
		ChercheDonneesCourielSortant 
		$err:=SMTP_Charset (1;1)
		$err:=SMTP_QuickSend (VarServeurSMTP;VarExpéditeur;VarExpéditeur;$Sujet;$message)
		If ($err=0)
			ALERT:C41("mail envoyé")
		Else 
			ALERT:C41("mail NON envoyé")
		End if 
	End if 
End if 