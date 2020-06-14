  // ZMFDlgEnsemble 6.0 du 30/08/98
  //   Formule Format de [XDonnées]Dlg(G)Ensemble    
  //Appelle ZCracheEnsemble

If (Form event code:C388=Sur chargement:K2:1)
	RadioET:=1
	RadioOu:=0
	RadioSauf:=0
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;"ZNbEnrFinal"))->:="Aucune"
	ZOnContinue:=True:C214
	ZVarEnsDep:=""
	ZVarEnsArr:=""
	ZVarNbarr:="Aucun enregistrement"
	ZVarNbDep:="Aucun enregistrement"
	OBJECT SET VISIBLE:C603(*;"BouEfface@";False:C215)
	OBJECT SET VISIBLE:C603(*;"Calcul@";False:C215)
	
End if 