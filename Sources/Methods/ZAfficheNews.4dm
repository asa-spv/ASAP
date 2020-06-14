//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/12/16, 06:20:04
  // ----------------------------------------------------
  // Méthode : ZAfficheNews
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283(_WNews)


WINDOW LIST:C442($TbList;*)
If (Find in array:C230($TbList;_WNews)<0)
	
	_WNews:=Open form window:C675("PaletteNews";Form fenêtre palette:K39:9;À droite:K39:3;Centrée verticalement:K39:4;*)
	DIALOG:C40("PaletteNews";*)
End if 