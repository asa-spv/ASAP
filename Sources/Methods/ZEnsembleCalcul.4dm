//%attributes = {"publishedWeb":true}
  // ZEnsembleCalcul V11 du 14/08/2010
  //  permet d'effectuer le calcul sur ensemble
  //appelée par le bouton standard BouCalculEns

C_LONGINT:C283($ZFT)
If ((ZVarEnsDep="") | (ZVarEnsArr=""))  //vérifions que les cases ne soient pas vides
	ALERT:C41("Il serait DE BON TON de remplir le nom des ensembles !")
Else 
	Case of   // selon le bouton radio actif
		: (RadioET=1)
			INTERSECTION:C121("Dep";"Arr";"Transit")
			
		: (RadioOU=1)
			UNION:C120("Dep";"Arr";"Transit")
			
		: (RadioSAUF=1)
			DIFFERENCE:C122("Dep";"Arr";"Transit")
	End case 
End if 
$ZFT:=Records in set:C195("Transit")
Case of 
	: ($ZFT=0)
		$ZNbEnrFinal:="Aucun enregistrement"
		
	: ($ZFT=1)
		$ZNbEnrFinal:="Un enregistrement"
		
	Else 
		$ZNbEnrFinal:=String:C10($ZFT)+" enregistrements"
End case 

(OBJECT Get pointer:C1124(Objet nommé:K67:5;"ZNbEnrFinal"))->:=$ZNbEnrFinal