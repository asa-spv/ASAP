//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/07/18, 09:35:36
  // ----------------------------------------------------
  // Paramètre $1 = texte résumant la contamination  {$2} si existe = n° du RAEMA
  // ----------------------------------------------------
  // Méthode : RaemaFabriqueLBContamination <= RaemaInfEcritP2 <= RaemaInfEcritP2 = $2
  //        ou RaemaFabriqueLBContamination <= DlgSaisieRAEMA.BouContamination = pas de $2
  // Description : interprète la variable Casimirienne qui recèle les contaminations.
  // 

C_LONGINT:C283($Salé;$TT;$Fumé)
$Tab:=Char:C90(Tabulation:K15:37)
$CR:=Char:C90(Retour chariot:K15:38)
$Texte:=$1
If (Count parameters:C259=1)
	$NumCampagne:=TbNR{TbNR}
Else 
	$NumCampagne:=$2
End if 
$RaemaPoudre:=($NumCampagne#"@a")

ARRAY TEXT:C222(TbSerie1Conta;0)
ARRAY TEXT:C222(TbSerie2Conta;0)
ARRAY TEXT:C222(TbSerie3Conta;0)
ARRAY TEXT:C222(TbSerie4Conta;0)
ARRAY TEXT:C222(TbSerie5Conta;0)
If (Count parameters:C259=1)
	$NumCampagne:=TbNR{TbNR}
Else 
	$NumCampagne:=$2
End if 
$TT:=Size of array:C274(TbNomGermeConta)
For ($Salé;1;$TT)
	$Pos:=Position:C15($CR;$Texte)
	$Ligne:=Substring:C12($Texte;1;($Pos-1))
	$Texte:=Substring:C12($Texte;($Pos+1))
	If ($RaemaPoudre)
		For ($Fumé;1;4)
			$Pos:=Position:C15($Tab;$Ligne)
			$Cellule:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			$Pt:=Get pointer:C304("TbSerie"+String:C10($Fumé)+"Conta")
			APPEND TO ARRAY:C911($Pt->;$Cellule)
		End for 
		APPEND TO ARRAY:C911(TbSerie5Conta;$Ligne)
	Else   // Raema gel
		APPEND TO ARRAY:C911(TbSerie1Conta;$Ligne)
	End if 
End for 

If (Count parameters:C259=1)  // Modifié par : cgm (14/10/2017)
	OBJECT SET VISIBLE:C603(*;"gel@";Not:C34($RaemaPoudre))
	OBJECT SET VISIBLE:C603(*;"poudre@";$RaemaPoudre)
End if 