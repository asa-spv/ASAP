//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/01/19, 09:43:33
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsTbDestinataires
  // Description
  // Remplit les tableaux des destinataires à partir de la sélection courante

C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222(ZZoneCli;0)
SELECTION TO ARRAY:C260([Personnes:12]NomLong:2;ZZoneCli\
;[Personnes:12]Arguments:7;$TbArgument\
;[Personnes:12]UUID:1;TbMailPerUUID)

$FT:=Size of array:C274(ZZoneCli)
ARRAY TEXT:C222(TbEM;$FT)
ARRAY BOOLEAN:C223(TbBrut;$FT)
For ($Salé;1;$FT)
	$L:=Find in array:C230(<>TbPerNomLong;ZZoneCli{$Salé})
	OB GET PROPERTY NAMES:C1232($TbArgument{$Salé};$TbNomProprio)
	If (Find in array:C230($TbNomProprio;"EMail@")>0)
		TbEM{$Salé}:=$TbArgument{$Salé}.EMail
	Else 
		TbEM{$Salé}:=""
	End if 
	TbBrut{$Salé}:=(<>TbPAMailTexteBrut{$L}="true")
End for 
VarNbEMail:=$FT
