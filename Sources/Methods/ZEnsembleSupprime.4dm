//%attributes = {"publishedWeb":true}
  // ZEnsembleSupprime  V11 du 15/08/2010
  //  supprime les ensembles désignés dans [XDonnées];"Liste"
  //  appelé par le bouton standard ZBouSupEns
  //  appelle ZFenêtreCeintrée, ZDestroyListe

QUERY:C277([XData:1];[XData:1]XType:3=ZTypEns)
If (Records in selection:C76([XData:1])=0)
	ALERT:C41("Il faut déjà créer un ensemble pour pouvoir le détruire…")
Else 
	ZEnsembleCracheEnsemble 
	ZFenetreModaleAuCentre (635;450)
	DIALOG:C40("DlgEnsembleSupprime")
	
End if 