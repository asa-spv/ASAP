COPY ARRAY:C226(TbChampsPossibles;$TbChampsPossibles)
$TT:=Size of array:C274(TbChampsPossibles)
For ($Salé;1;$TT)
	$L:=Find in array:C230(TbChampsExport;TbChampsPossibles{$Salé})
	If ($L>0)
		$L:=Find in array:C230($TbChampsPossibles;TbChampsPossibles{$Salé})
		DELETE FROM ARRAY:C228($TbChampsPossibles;$L)
	End if 
End for 

$Menu:=ZTableauVersTexte (->$TbChampsPossibles;";")
$Li:=Pop up menu:C542($Menu)
APPEND TO ARRAY:C911(TbChampsExport;$TbChampsPossibles{$Li})
OBJECT SET VISIBLE:C603(*;"BouExport";True:C214)
