//%attributes = {"publishedWeb":true}
  // ZEnsembleChoix  V11 du 14/08/2010
  // MF  qui met le nom des ensemble dans le tableau de [ExVariables];"DlgEnsemble"
$evt:=Form event code:C388
If ($evt=Sur chargement:K2:1)
	ZEnsembleCracheEnsemble 
End if 

  //Si ($evt=Sur clic )
  //Au cas ou 
  //: (ZVarEnsDep="")  `la première case est vide
  //ZVarEnsDep:=ZTbEnsNom{ZTbEnsNom}  `remplissons là avec la valeur cliquée
  //: (ZVarEnsArr="")  `la seconde case est vide
  //ZVarEnsArr:=ZTbEnsNom{ZTbEnsNom}  `remplissons là avec la valeur cliquée
  //Sinon 
  //ALERTE("Effacez au moins une case...")  `no comment
  //Fin de cas 
  //Fin de si 
