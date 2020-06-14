//%attributes = {}
  // InfRAEMACreationTbConta <- RaemaInfEcritP2

C_LONGINT:C283($Salé;$FT;$Fumé)
If (LangueCourante="F")
	$TitreNumEch:="Numéro de vos échantillons"
	$NomGermes:="Noms des germes"
Else 
	$TitreNumEch:="Number of your Samples"
	$NomGermes:="Names of germs"
End if 
$THTML:="<div align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR

$THTML:=$THTML+"  <table width="+<>ZGuil+"90%"+<>ZGuil+">"+<>ZCR

$THTML:=$THTML+"    <tr>"+<>ZCR  // Première ligne
$THTML:=$THTML+"      <td width="+<>ZGuil+"40%"+<>ZGuil+">&nbsp;</td>"+<>ZCR
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttb2"+<>ZGuil+" colspan="+<>ZGuil+"5"+<>ZGuil+">"+$TitreNumEch+"</td>"+<>ZCR
$THTML:=$THTML+"    </tr>"+<>ZCR

$THTML:=$THTML+"    <tr>"+<>ZCR  // ligne 2 = ET
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+$NomGermes+"</td>"+<>ZCR
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttbech"+<>ZGuil+">"+TbNumEch{1}+"</td>"+<>ZCR
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttbech"+<>ZGuil+">"+TbNumEch{2}+"</td>"+<>ZCR
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttbech"+<>ZGuil+">"+TbNumEch{3}+"</td>"+<>ZCR
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttbech"+<>ZGuil+">"+TbNumEch{4}+"</td>"+<>ZCR
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttbech"+<>ZGuil+">"+TbNumEch{5}+"</td>"+<>ZCR
$THTML:=$THTML+"    </tr>"+<>ZCR
$Pair:=True:C214
For ($Fumé;1;11)
	$Pair:=Not:C34($Pair)
	$CouleurLigne:="ligne"+(Num:C11($Pair)*"in")+"paire"
	$THTML:=$THTML+"    <tr class="+<>ZGuil+$CouleurLigne+<>ZGuil+">"+<>ZCR  // Ligne germe 1
	$THTML:=$THTML+"      <td>"+TbNomGermeConta{$Fumé}+"</td>"+<>ZCR
	For ($Salé;1;5)
		$L:=Find in array:C230(TbNumEchT;TbNumEch{$Salé})
		$Pt:=Get pointer:C304("TbSerie"+String:C10($L)+"Conta")
		$THTML:=$THTML+"      <td>"+$Pt->{$Fumé}+"</td>"+<>ZCR
	End for 
	$THTML:=$THTML+"    </tr>"+<>ZCR
End for 

$0:=$THTML+"</table>"+<>ZCR+"</div>"+<>ZCR

