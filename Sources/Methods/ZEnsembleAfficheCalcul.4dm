//%attributes = {"publishedWeb":true}
  //ZEnsembleCalcul V11 du 14/08/2010
  //   MP qui appelle le calcul sur ensembles
  //  appelée par le  bouton standard ZBouCalculEns 
  //  utilise ZEnsembleCracheEnsemble, ZActualiseTitreFenetre

QUERY:C277([XData:1];[XData:1]XType:3=ZTypEns)
If (Records in selection:C76([XData:1])<2)
	ALERT:C41("Il faut au moins créer deux ensembles pour pouvoir les combiner...")
Else 
	CREATE SET:C116(ZPtTable->;"Comme avant")  //conserve la sélection précédente
	CREATE EMPTY SET:C140(ZPtTable->;"Transit")
	ZEnsembleCracheEnsemble 
	ZFenetreModaleAuCentre (650;415)
	DIALOG:C40("DlgEnsembleCalcul")
	CLOSE WINDOW:C154
	CLEAR SET:C117("Transit")  //efface le dernier ensemble créé
	CLEAR SET:C117("Dep")  //efface le dernier ensemble de départ
	CLEAR SET:C117("Arr")  //efface le dernier ensemble d'arrivée
	If (Records in selection:C76(ZPtTable->)=0)  // si on pilote la liste et qu'il y a une sélection non vide 
		USE SET:C118("Comme avant")  //reprend la liste précédente
	End if 
	CLEAR SET:C117("Comme avant")  //efface l'ensemble précédent
	ZFenetreActualiseTitre 
End if 