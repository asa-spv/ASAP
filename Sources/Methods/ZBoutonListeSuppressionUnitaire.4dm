//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 09:04:26
  // ----------------------------------------------------
  // Méthode : ZBoutonListeSuppressionUnitaire
  // Description
  //  Historique :  ZDestroyEnr V11 du 14/08/2010
  //   supprime l'enregistrement courant
  // ----------------------------------------------------

If (ZSupprime)
	CREATE SET:C116(ZPtTable->;"Avant Carnage")
	USE SET:C118("Userset")
	DIFFERENCE:C122("Avant Carnage";"Userset";"Avant Carnage")
	CONFIRM:C162("Voulez-vous VRAIMENT détruire cette fiche")
	If (OK=1)
		READ WRITE:C146(ZPtTable->)
		LOAD RECORD:C52(ZPtTable->)
		If (ZVerrouTester (ZPtTable))  //  la fiche est destructible
			START TRANSACTION:C239
			ON ERR CALL:C155("ZAnnuleTransaction")
			  //  l'enregistrement est-il destructible ? ZBoumProc est elle correcte?
			If (ZBoumProc#"")  //  initialisée dans ZGereListe
				EXECUTE FORMULA:C63(ZBoumProc)  // procédure de mise à jour logique
			End if 
			ZVerrouAttendre (ZPtTable)
			DELETE RECORD:C58(ZPtTable->)
			VALIDATE TRANSACTION:C240
			ON ERR CALL:C155("")
		End if 
	End if 
	USE SET:C118("Avant Carnage")
	CLEAR SET:C117("Avant Carnage")
	ZFenetreActualiseTitre 
Else 
	ALERT:C41("Désolé, vous ne pouvez pas détruire cette fiche")
End if 