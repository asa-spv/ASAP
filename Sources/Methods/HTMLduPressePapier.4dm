//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/10/16, 13:36:38
  // ----------------------------------------------------
  // Méthode : HTMLduPressePapier
  // Description
  // transforme de texte HTML du Presse-Papier
  //  en code 4D
  // Paramètres
  // ----------------------------------------------------

$CR:=Char:C90(Retour chariot:K15:38)
$LF:=Char:C90(Retour à la ligne:K15:40)
$PP:=Get text from pasteboard:C524
$Pos:=Position:C15($CR;$PP)
$Fin:=$CR
If ($Pos=0)
	$Pos:=Position:C15($LF;$PP)
	$Fin:=$LF
End if 
$T:="$THTML:="+<>ZGuil+<>ZGuil+<>ZCR
While ($Pos>0)
	$Ligne:=Substring:C12($PP;1;($Pos-1))
	$T:=$T+HTMLTraiteLigne ($Ligne)
	$PP:=Substring:C12($PP;($Pos+1))
	$Pos:=Position:C15($Fin;$PP)
End while 
$Ligne:=$PP
$T:=$T+HTMLTraiteLigne ($Ligne)
SET TEXT TO PASTEBOARD:C523($T)


