//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/04/18, 07:50:18
  // ----------------------------------------------------
  // Méthode : ZGereVisuBoutonNavigationSaisie
  // Description
  // Gère l'aspect activé ou non des boutons 
  //.   du formulaire projet SaisieStandard 
  //    commun à une gestion séléection ou tableau
  // ----------------------------------------------------
OBJECT SET ENABLED:C1123(*;"BouDernier";True:C214)
OBJECT SET ENABLED:C1123(*;"BouSuiv";True:C214)
OBJECT SET ENABLED:C1123(*;"BouPrec";True:C214)
OBJECT SET ENABLED:C1123(*;"BouPrem";True:C214)
If (GestionTableau)  // Gestion LB Tableau
	If (LigneClic=1)
		OBJECT SET ENABLED:C1123(*;"BouPrec";False:C215)
		OBJECT SET ENABLED:C1123(*;"BouPrem";False:C215)
	End if 
	If (LigneClic=Size of array:C274(TbNumEnr))
		OBJECT SET ENABLED:C1123(*;"BouDernier";False:C215)
		OBJECT SET ENABLED:C1123(*;"BouSuiv";False:C215)
	End if 
	$vRecNum:=String:C10(LigneClic)+" / "+String:C10(Size of array:C274(TbNumEnr))
	
Else   // Gestion LB Sélection
	
	If (Selected record number:C246(ZPtTable->)=1)
		OBJECT SET ENABLED:C1123(*;"BouPrec";False:C215)
		OBJECT SET ENABLED:C1123(*;"BouPrem";False:C215)
	End if 
	If (Selected record number:C246(ZPtTable->)=Records in selection:C76(ZPtTable->))
		OBJECT SET ENABLED:C1123(*;"BouDernier";False:C215)
		OBJECT SET ENABLED:C1123(*;"BouSuiv";False:C215)
	End if 
	$vRecNum:=Choose:C955(Selected record number:C246(Current form table:C627->)<0;"";String:C10(Selected record number:C246(Current form table:C627->))+" / "+String:C10(Records in selection:C76(Current form table:C627->)))
End if 
(OBJECT Get pointer:C1124(Objet nommé:K67:5;"vRecNum"))->:=$vRecNum