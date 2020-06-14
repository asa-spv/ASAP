//%attributes = {"publishedWeb":true}
  //  ZArrêterSurClicSouris V11 du 10/08/2010
  //  Méthode appelée sur evenement pour arrêter quelque chose
  //  par clic de souris

If (MouseDown=1)
	If (<>OnReste) & (Not:C34(<>OnContinue))
		<>OnReste:=False:C215
	End if 
	<>OnContinue:=False:C215
Else 
	<>OnContinue:=True:C214
End if 