//%attributes = {"publishedWeb":true}
  //Méthode : YEtatBoutonsPhoto
  //Crée le lundi 28 septembre 1998 par Mimosa
  //ACTIVE/INACTIVE LES BOUTONS ET LA TAILLE DE L'IMAGE
  //$1 = POINTEUR VERS LA PHOTO

  // Adapté à la V12 le 28 avril 2012 par PE

C_POINTER:C301($1)

If (Picture size:C356($1->)#0)
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;"TaillePhoto"))->:=String:C10(Int:C8(Picture size:C356($1->)/1024);"#### ko;;(-)")
	OBJECT SET ENABLED:C1123(*;"bCopierImage";True:C214)
	OBJECT SET ENABLED:C1123(*;"bEffacerImage";True:C214)
	  //OBJET FIXER VISIBLE(TaillePhoto;Vrai)  //Visibilité de la taille de l'image
	
Else   //Pas de photo
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;"TaillePhoto"))->:=""
	  // TaillePhoto:=""
	OBJECT SET ENABLED:C1123(*;"bCopierImage";False:C215)
	OBJECT SET ENABLED:C1123(*;"bEffacerImage";False:C215)
	  //OBJET FIXER VISIBLE(TaillePhoto;Faux)
End if 
OBJECT SET VISIBLE:C603(*;"TaillePhoto";Picture size:C356($1->)#0)  //Visibilité de la taille de l'image


  //Si (Tester conteneur(Données image)>0)  //Si le presse-papiers contient une image…
  //OBJET FIXER ACTIVATION(bCollerImage;Vrai)  //…on active le bouton 'Coller'
  //Sinon 
  //OBJET FIXER ACTIVATION(bCollerImage;Faux)
  //Fin de si 

  //Si le presse-papiers contient une image…
  //…on active le bouton 'Coller'

OBJECT SET ENABLED:C1123(*;"bCollerImage";Pasteboard data size:C400(Données image:K20:3)>0)
