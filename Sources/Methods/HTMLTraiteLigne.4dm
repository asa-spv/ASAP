//%attributes = {}
  // HTMLTraiteLigne
  // $1 = texte à traiter
  // $0 renvoie le texte traité
$TT:=$1
$Guil:=Char:C90(34)
$CR:=Char:C90(13)
$TT:=Replace string:C233($TT;$Guil;($Guil+"+◊ZGuil+"+$Guil))
If (Substring:C12($TT;Length:C16($TT))#$Guil)
	$TT:=$TT+$Guil
End if 
$0:="$THTML:=$THTML+"+$Guil+$TT+"+◊ZCR"+$CR