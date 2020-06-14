//%attributes = {}
  //  ResP1SortValeurChampP2  $1=rang du champ "textfield"  {$2}=Vrai si RaemaGel
  // Permet d'initialiser le champ des n° de prélèvements
  // selon une première saisie antérieure
  // appelée par RaemaEcritLigneP2 <- RaemaConstruitP2 <- WebIdentification
C_TEXT:C284($1;$NomChamp;$T;$Résultat)
C_LONGINT:C283($L)
$NomChamp:=$1

$Résultat:=""
$T:=(Num:C11(Count parameters:C259=2)*"Rg")+"textfield"+$NomChamp
$L:=Find in array:C230(TbNomsP2;$T)  // Test si le n° d'échantillon existe
If ($L>0)
	$Résultat:=TbValeursP2{$L}  // restitution éventuelle
End if 
$0:=$Résultat