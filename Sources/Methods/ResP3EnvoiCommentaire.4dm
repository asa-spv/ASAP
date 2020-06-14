//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 02/05/19, 16:59:35
  // ----------------------------------------------------
  // Méthode : ResP3EnvoiCommentaire
  // Description
  // Envoi le commentaire du laboratoire à l'ASA
  // ----------------------------------------------------

If (NumLaboActuelA#"13")
	
	  // 
	  // Sélection des [WebConnexions] de la campagne avec un commentaire
	QUERY:C277([WebConnexions:13];[WebConnexions:13]Campagne:5=NumCampagneCourante;*)  // dans l'absolu, NumCampagneCourante doit être renseigné
	QUERY:C277([WebConnexions:13]; & [WebConnexions:13]Commentaire:14#"";*)
	QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
	
	If (Records in selection:C76([WebConnexions:13])>0)  // Si on en trouve
		SELECTION TO ARRAY:C260([WebConnexions:13]CodeConnexion:4;$TbCodePersonne\
			;[WebConnexions:13]Commentaire:14;$TbCom)  // on met les éléments pertinents de la sélection dans des tableaux 
		
		  // Renseignements du laboratoire
		$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;NumLaboActuelA)
		$Nom:=<>TbPerNomLong{$L}+" ("+<>TbPerAdrLivCP{$L}+"-"+<>TbPerAdrLivVille{$L}+")"
		$Mail:=<>TbPAEmailRAEMA{$L}
		$CodeLabo:=<>TBPERIDENTIFICATEUR{$L}
		$L2:=Find in array:C230($TbCodePersonne;$CodeLabo)  // lien avec les [WebConnexions]
		$Commentaire:=$TbCom{$L2}
		$message:="Bonjour,"+<>ZCR2+"Le commentaire suivant a été adressé lors de la campagne "+NumCampagneCourante
		$message:=$message+" par le laboratoire n°"+NumLaboActuelA+" "+$Nom+" (mail : "+$Mail+" ) :"+<>ZCR2+$Commentaire+<>ZCR
		$message:=$message+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
		$Sujet:="Commentaires du RAEMA n°"+NumCampagneCourante+" par le laboratoire "+NumLaboActuelA
		ChercheDonneesCourielSortant 
		$err:=SMTP_Charset (1;1)
		$err:=SMTP_QuickSend (VarServeurSMTP;VarExpéditeur;VarExpéditeur;$Sujet;$message)
		  //$err:=SMTP_QuickSend ("smtp.free";"asa-spv@wanadoo.fr";"cegeheme@wanadoo.fr";$Sujet;$message)
	End if 
End if 