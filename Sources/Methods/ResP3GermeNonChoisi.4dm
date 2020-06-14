//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/08/18, 18:11:39
  // ----------------------------------------------------
  // Paramètres : $1 = compteur principal de la boucle
  //                    $2 = Nom du germe courant
  // ----------------------------------------------------
  // Méthode : ResP3GermeNonChoisi
  // Description
  // // Traite du cas où le germe n'a pas été choisi en Page 2 

C_LONGINT:C283($1;$0;$Salé;$Rang;$DécompteNaN;$Sec)
$Salé:=$1
$NomDuGermeCourant:=$2

  // On doit actualiser TbPJMailRaema avec autant de "NaN" que de valeurs attendues pour ce germe et incrémenter $Salé en conséquence
$DécompteNaN:=0
$OnSort:=False:C215
For ($Fumé;1;100)  // 100 lignes pour être sûr qu'on décrochera avant
	$Rang:=$Salé+$Fumé-1
	Case of 
		: ($Rang>Size of array:C274(<>TbRefGerme))  // On a fini le tableau
			$OnSort:=True:C214
			$Fumé:=100  // On sort
			$Salé:=Size of array:C274(<>TbRefGerme)
			
		: (<>TbRefGerme{$Rang}=<>TbRefGerme{$Rang-1}) | ($Fumé=1)  // On n'a pas changé de germe
			If (<>TbMultiple{$Rang}="")  // Pas de valeurs donc un seul NaN
				$DécompteNaN:=$DécompteNaN+1
			Else 
				  // Au moins une valeur ne demande t'elle pas une précision
				$Prec:=False:C215
				$NbPrec:=Num:C11(<>TbNbValeurs{$Rang})
				For ($Sec;1;$NbPrec)
					$CompteurPrec:=$Rang+$Sec-1
					If (<>TbPrecision{$CompteurPrec}#"")
						$Prec:=True:C214
						$Sec:=$NbPrec
					End if 
				End for 
				$DécompteNaN:=$DécompteNaN+1+Num:C11($Prec)
				$Salé:=$Salé+Num:C11(<>TbNbValeurs{$Rang})-1  // On avance dans la liste jusqu'à la dernière valeur
			End if 
			
		Else   // On a changé de germe
			$OnSort:=True:C214
			$Salé:=$Salé+$Fumé-2  // Dernier rang du germe
			$Fumé:=100  // On sort
	End case 
End for 
For ($Sec;1;$DécompteNaN)
	APPEND TO ARRAY:C911(TbPJMailRaema;"NaN")
End for 

$AnnonceKO:=<>ZCR+$NomDuGermeCourant+RaemaTraducUtiliseTableau (67)  // Germe non demandé
APPEND TO ARRAY:C911(TbTexteResume;$AnnonceKO)
$0:=$Salé