//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/02/18, 17:43:14
  // ----------------------------------------------------
  // Méthode : ZLBUserSet
  // Description
  // Permet de ne garder que les lignes sélectionnées 
  // ----------------------------------------------------
If (GestionTableau)
	C_LONGINT:C283($Salé;$FT)
	  // gestion suppressions de lignes 
	$FT:=Size of array:C274(TbNumEnr)
	For ($Salé;1;$FT)
		$Rang:=$FT-$Salé+1
		If (Lb_Tableaux{$Rang}=False:C215)
			LISTBOX DELETE ROWS:C914(*;"Lb_Tableaux";$Rang)
		End if 
	End for 
Else 
	USE SET:C118("$ZFichesSurlignees")
End if 