//%attributes = {"publishedWeb":true}
  //YImagePressePapiers
  //Récupérer de PoleContact, Mimosa, le 10/09/99
  //$1=POINTEUR VERS L'IMAGE RECEVANT LE PRESSE PAPIERS
  //RETOURNE OK=1 SI TOUT S'EST BIEN PASSÉ


C_POINTER:C301($1)

  // Modifié par : Patrick EMANUEL (09/05/12)
If (Pasteboard data size:C400(Données image:K20:3)>0)  //Le presse-papiers contient bien une image
	
	If (Picture size:C356($1->)#0)  //Si l'image de destination n'est pas vide…
		  //"Remplacer l'image présente par celle du presse-papiers ?"    
		CONFIRM:C162("Remplacer l'image présente par celle du presse-papiers ?")  //…on doit confirmer l'écrasement
		
	Else   //Destination vide
		OK:=1  //Pas besoin de confirmer
	End if 
	
	If (OK=1)  //Action
		GET PICTURE FROM PASTEBOARD:C522($1->)  //Pg 988
		
		If (OK=0)  //Pas assez de mémoire pour coller
			ALERT:C41("Pas assez de mémoire pour coller l'image !")  //"Pas assez de mémoire pour coller l'image !"    
		End if 
	End if 
	
Else   //Aucune image dans le presse-papiers
	ALERT:C41("Pas d'image dans le presse papiers !")  //"Pas d'image dans le presse papiers !"
	OK:=0
End if 
