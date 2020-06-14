//%attributes = {"publishedWeb":true}
  // ZfSémaphoreIci  V11 du 15/08/2010
  //   fonction qui renvoie la valeur du sémaphore
  // $1=Nom du sémaphore  $2= message d'attente

_O_C_STRING:C293(80;$1)
$Séma:=Semaphore:C143($1)
If ($séma)
	ALERT:C41($2)
Else 
	CLEAR SEMAPHORE:C144($1)
End if 
$0:=$Séma