//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 09:54:01
  // ----------------------------------------------------
  // Méthode : ZBoutonListeImprimer
  // Description
  //  Historique : ZImprimera V11 du 15/08/2010
  //   
  //
  // Paramètres
  // ----------------------------------------------------

  //  le fait s'il a le droit
If (ZImprime)
	If (Records in selection:C76(ZPtTable->)#0)
		CREATE SET:C116(ZPtTable->;"SEL")
		ZFenetreModaleAuCentre (100;150)
		DIALOG:C40("DlgImpressionEnListe")
		CLOSE WINDOW:C154
		If (OK=1)
			Case of 
				: (ZBRIMP1=1)
					If (Records in set:C195("UserSet")#0)
						USE SET:C118("UserSet")
						FORM SET OUTPUT:C54(ZPtTable->;"LISTIMP")
						PRINT SELECTION:C60(ZPtTable->)
					Else 
						FORM SET OUTPUT:C54(ZPtTable->;"LISTIMP")
						PRINT SELECTION:C60(ZPtTable->)
					End if 
				: (ZBRIMP3=1)
					PRINT LABEL:C39(ZPtTable->;Char:C90(1))
				: (ZBRIMP2=1)
					If (Records in set:C195("UserSet")#0)
						USE SET:C118("UserSet")
						FORM SET OUTPUT:C54(ZPtTable->;"FICHIMP")
						PRINT SELECTION:C60(ZPtTable->)
					Else 
						FORM SET OUTPUT:C54(ZPtTable->;"FICHIMP")
						PRINT SELECTION:C60(ZPtTable->)
					End if 
				: (ZBRIMP4=1)
					QR REPORT:C197(ZPtTable->;Char:C90(1))
			End case 
		End if 
		FORM SET OUTPUT:C54(ZPtTable->;"sortie")
		USE SET:C118("SEL")
		CLEAR SET:C117("SEL")
	End if 
Else 
	ALERT:C41("Désolé, vous n'avez pas le droit d'imprimer")
End if 