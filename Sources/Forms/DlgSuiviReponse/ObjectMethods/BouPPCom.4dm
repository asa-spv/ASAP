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

$TT:=Size of array:C274(TbComSaisie)
$message:="Bonjour,"+<>ZCR2+"Les commentaires suivants ont été adressés lors de la campagne "+VarNumRaema+" :"
$Com:=""
For ($salé;1;$TT)
	$Com:=$Com+<>ZCR+"laboratoire n°"+String:C10(TbComSaisie{$salé})+<>ZCR+TbComCorps{$salé}+<>ZCR
End for 
$message:=$message+<>ZCR+$Com
$message:=$message+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
SET TEXT TO PASTEBOARD:C523($message)