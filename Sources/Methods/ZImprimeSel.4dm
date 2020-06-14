//%attributes = {}
  // ZImprimeSel  V11 du 15/08/2010
  //    méthode d'impression de la sélection en cours
  //  à la cgm avec le dialogue [XVide];"DlgImpSel"
  //  appelée par le bouton ZBouImpSel de la liste standard
  //  utilise ZActualiseTitreFenetre
If (ZImprime)
	
	ZFenetreModaleAuCentre (150;150;1)
	DIALOG:C40("DlgImpSel")
	CLOSE WINDOW:C154
	SET WINDOW TITLE:C213("Impression de "+ZNomTable)
	  // permet de repérer l'impression dans les listes du spooler
	
	If (ZBouImp=1)
		Case of 
			: (RadListe=1)
				FORM SET OUTPUT:C54(ZPtTable->;ZNomForImpLis)
				PRINT SELECTION:C60(ZPtTable->)
				
			: (RadFiche=1)
				FORM SET OUTPUT:C54(ZPtTable->;ZNomForImpEnr)
				PRINT SELECTION:C60(ZPtTable->)
				
			: (RadEti=1)
				PRINT LABEL:C39(ZPtTable->;Char:C90(1))
		End case 
	End if 
	FORM SET OUTPUT:C54(ZPtTable->;ZNomForAffLis)
	ZFenetreActualiseTitre 
Else 
	ALERT:C41("Désolé, vous n'avez pas le droit d'imprimer")
End if 