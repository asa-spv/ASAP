  // ZClicTbEnsemble 6.0  du 18/8/98
  //  script du tableau ZTbEnsNom
  //   remplit le tableau d'ensemble de [ExVariables];"DlgGEnsemble"
  //remplit les cases ensembles de départ et d'arrivée
  //  utilise ZCracheEnsemble

$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxChoixEnsemble";$C;$L)
		If ($L>0)
			Case of 
				: (ZVarEnsDep="")
					ZVarEnsDep:=ZTbEnsNom{$L}
					GOTO RECORD:C242([XData:1];ZTbEnsNumEnr{$L})
					ZEnsembleRelire ("Dep")
					$ZFT:=Records in set:C195("Dep")
					Case of 
						: ($ZFT=0)
							ZVarNbDep:="Aucun enregistrement"
						: ($ZFT=1)
							ZVarNbDep:="Un seul enregistrement"
						: ($ZFT>1)
							ZVarNbDep:=String:C10($ZFT)+" enregistrements"
					End case 
					OBJECT SET VISIBLE:C603(*;"BouEffaceDep";True:C214)
					
				: (ZVarEnsArr="")
					ZVarEnsArr:=ZTbEnsNom{$L}
					GOTO RECORD:C242([XData:1];ZTbEnsNumEnr{$L})
					ZEnsembleRelire ("Arr")
					$ZFT:=Records in set:C195("Arr")
					Case of 
						: ($ZFT=0)
							ZVarNbarr:="Aucun enregistrement"
						: ($ZFT=1)
							ZVarNbarr:="Un seul enregistrement"
						: ($ZFT>1)
							ZVarNbarr:=String:C10($ZFT)+" enregistrements"
					End case 
					OBJECT SET VISIBLE:C603(*;"BouEffaceArr";True:C214)
					
				Else 
					ALERT:C41("Les deux ensembles sont déja désignés...")
					
			End case 
		End if 
		$ToutRempli:=(ZVarEnsArr#"") & (ZVarEnsDep#"")
		OBJECT SET VISIBLE:C603(*;"Calcul@";$ToutRempli)
		
		
End case 
