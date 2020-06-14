//%attributes = {"publishedWeb":true}
  // ZEnsembleEnregistre V11 du 14/08/2010
  //  permet de stocker l'ensemble nouvellement créé
  //  appelé par le bouton correspondant de [XDonnées];"DlgGEnsemble"

If (Records in set:C195("Transit")#0)  //existe t'il au moins une fiche?  
	  //ZEnsembleSortNom 
	If (ZOnContinue)
		ZEnsembleStoke 
		USE SET:C118("Transit")  //reprend l'ancienne sélection    
		ZEnsembleCracheEnsemble 
	End if 
Else 
	ALERT:C41("Il ne me semble pas très utile de vouloir créer un ensemble ...vide !!")
End if 