//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/07/18, 19:42:15
  // ----------------------------------------------------
  // Méthode : RaemaTraducUtiliseTableau
  // Paramètre : $1 = Rang du tableau concerné
  // ----------------------------------------------------
  // Description
  //  Méthode qui traduit les termes affichés selon les <>TbF (Français) ou <>TbA (Anglais)
  //  placés dans [RAEMACampagnes]Arguments

C_LONGINT:C283($Rang;$1)
$Rang:=$1
If (LangueCourante="A")
	$0:=<>TbA{$Rang}
Else 
	$0:=<>TbF{$Rang}
End if 