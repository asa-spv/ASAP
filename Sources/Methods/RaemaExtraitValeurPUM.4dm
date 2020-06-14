//%attributes = {}
  //  RaemaExtraitValeurPUM
  //$1 = valeur du PUM
  // $0 = chaine(ligne du PUM) si >1; "NaN" sinon


$Pos:=Position:C15("-";ValeurProposée)
$Test:=String:C10(Num:C11(Substring:C12(ValeurProposée;1;($Pos-2)))+1)
If ($Test="1")
	$0:="NaN"
Else 
	$0:=$Test
End if 