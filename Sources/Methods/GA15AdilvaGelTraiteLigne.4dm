//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/03/18, 10:23:17
  // ----------------------------------------------------
  // Méthode : GA15AdilvaGelTraiteLigne
  // Description
  // Traite la ligne du tableau ADILVA
  // Paramètres $1 = ligne du tableau 

  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
$ligne:=$1
For ($Salé;1;36)  // 37 colonnes = 36 tabulations
	$Pt:=Get pointer:C304("ColRGA"+String:C10($Salé))
	$Pos:=Position:C15(<>ZTab;$ligne)
	APPEND TO ARRAY:C911($Pt->;Substring:C12($ligne;1;($Pos-1)))
	$ligne:=Substring:C12($ligne;($Pos+1))
End for 
APPEND TO ARRAY:C911(ColRGA37;$ligne)