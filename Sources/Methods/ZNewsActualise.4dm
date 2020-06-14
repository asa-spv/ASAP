//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 05/05/18, 19:59:48
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZNewsActualise
  // Description
  // Actualise la variable VarNews qui contient les News à afficher

C_LONGINT:C283($Salé;$FT)
C_TEXT:C284(<>ZVarNews)

QUERY:C277([XData:1];[XData:1]XType:3="MsgNews";*)
QUERY:C277([XData:1]; & ;[XData:1]XBool:14=False:C215)

SELECTION TO ARRAY:C260([XData:1]XAlpha:8;$TbQui;[XData:1]XTexte:9;$TbTexte;[XData:1]XTexteSup:10;$TbQuand)

SORT ARRAY:C229($TbQuand;$TbQui;$TbTexte;<)

$T:=""
$FT:=Size of array:C274($TbQui)

For ($Salé;1;$FT)
	$T:=$T+"<SPAN STYLE="+<>ZGuil+"font-weight:bold"+";"+"font-size:14pt"+";"+"font-style:italic"+<>ZGuil+">"
	$T:=$T+$TbQui{$Salé}+" le "+$TbQuand{$Salé}+"</SPAN>"+<>ZCR
	$T:=$T+$TbTexte{$Salé}+<>ZCR2
End for 

If ($T#<>ZVarNews)
	<>ZVarNews:=$T
End if 