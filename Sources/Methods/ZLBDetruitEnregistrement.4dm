//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/04/18, 10:28:54
  // ----------------------------------------------------
  // Méthode : ZLBDetruitEnregistrement
  // Description
  // Historique
  //  utilisée par le bouton standard de suppression dans le formulaire LB ZBouSupEnr
  //  supprime la sélection ou le ou les enregistrement(s) désigné(s-
  // Paramètre : {$1} si existe, supprime toute la sélection  sinon le ou les enregistrement(s) désigné(s)
  // ----------------------------------------------------

C_LONGINT:C283($FT)

If (ZSupprime)
	$Designe:=(Count parameters:C259=0)
	If ($Designe)
		CREATE SET:C116(ZPtTable->;"Les Condamnés")
		$FT:=Records in set:C195(NomEnsembleUserSet)
		USE SET:C118(NomEnsembleUserSet)
		FIRST RECORD:C50(ZPtTable->)
	Else 
		$FT:=Records in selection:C76(ZPtTable->)
	End if 
	If ($FT#0)
		$Txt:=Choose:C955($FT=1;"l'enregistrement sélectionné "+<>Zguil+ZPtChamp->+<>Zguil;String:C10($FT)+" enregistrements sélectionnés")
		CONFIRM:C162("Voulez-vous VRAIMENT détruire "+$Txt)
		If (OK=1)
			CONFIRM:C162("Présenter l'accord écrit du responsable à l'écran")
			If (OK=1)
				CONFIRM:C162("Etait-il à jeun ??!")
				If (OK=1)
					ZAdieuSel 
					If ($Designe)
						DIFFERENCE:C122("Les Condamnés";"$ZFichesSurlignees";"Les Condamnés")
						USE SET:C118("Les Condamnés")
						CLEAR SET:C117("Les Condamnés")
					End if 
				End if 
			End if 
		End if 
		ZFenetreActualiseTitre 
	Else 
		ALERT:C41("Il n'y a pas de sélection à détruire...")
	End if 
Else 
	ALERT:C41("vous n'avez pas l'autorisation de détruire cette sélection")
End if 
