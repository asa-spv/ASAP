//%attributes = {"publishedWeb":true}
  //ZfTesteSémaphore V11 du 14/08/2010
  // fonction qui permet d'informer l'utilisateur de l'état des autres postes
  // $1=Nom du sémaphore  $2= message d'attente

OK:=1
$Séma:=True:C214
While ($Séma & (OK=1))
	$Séma:=Semaphore:C143($1)
	If ($séma)
		DELAY PROCESS:C323(Current process:C322;300)
		CONFIRM:C162($2)
	End if 
End while 
$0:=(OK=1)