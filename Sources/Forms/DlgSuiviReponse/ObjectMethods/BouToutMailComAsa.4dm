  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 17/11/16, 14:51:03
  // ----------------------------------------------------
  // Méthode : DlgSuiviReponse.BouMail
  // Description
  // Permet d'nvoyer les mails de relance pour les participants 
  // du loto n'ayant pas encore envoyé leurs résultats et ne faisant
  // pas parti des cas particuliers
  //
  // ----------------------------------------------------

$message:="Bonjour,"+<>ZCR2+"Les commentaires suivants ont été adressés lors de la campagne "+VarNumRaema+" :"+<>ZCR2
$message:=""
$TT:=Size of array:C274(TbComSaisie)
For ($salé;1;$TT)
	$NumRaemaA:=String:C10(TbComSaisie{$salé})
	$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumRaemaA)
	$Nom:=<>TbPerNomLong{$L}+" ("+<>TbPerAdrLivCP{$L}+"-"+<>TbPerAdrLivVille{$L}+")"
	$Mail:=<>TbPAEmailRAEMA{$L}
	$message:=$message+"Par le laboratoire n°"+$NumRaemaA+" "+$nom+" (mail : "+$mail+" ) :"+<>ZCR+TbComCorps{$salé}+<>ZCR2
End for 

$Sujet:="Commentaires lors de la campagne "+VarNumRaema+" le "+String:C10(Current date:C33;3)+" à"+String:C10(Current time:C178)
$err:=SMTP_Charset (1;1)
$message:=$message+<>ZCR
$message:=$message+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
SET TEXT TO PASTEBOARD:C523($message)

$TT:=Size of array:C274(TbComSaisie)
$err:=SMTP_Charset (1;1)
$err:=SMTP_QuickSend (VarServeurSMTP;VarExpéditeur;VarExpéditeur;$Sujet;$message)
