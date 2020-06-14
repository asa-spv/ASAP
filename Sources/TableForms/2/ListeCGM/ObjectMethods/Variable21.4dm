C_LONGINT:C283($SFT)
QUERY:C277([XAttributions:5];[XAttributions:5]UUIDUtilisateur:2=[XUtilisateurs:2]UUID:1)
SELECTION TO ARRAY:C260([XAttributions:5]UUIDFonction:3;$TbUUIDFonction)
$SFT:=Size of array:C274($TbUUIDFonction)
$Ajout:=""
For ($salé;1;$SFT)
	$L:=Find in array:C230(<>TbFonctionsUUID;$TbUUIDFonction{$salé})
	$Ajout:=$Ajout+"; "+<>TbFonctionsNomFonction{$L}
End for 
ZVarAtt:=Substring:C12($Ajout;3;500)