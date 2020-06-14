//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/18, 15:18:21
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP2PiedResultatAvecDilution
  // Description : écrit le HTML du pied de bloc 
  //  incluant l'avertissement du calcul du zscore
  // 

$Germe:=Substring:C12(<>TbRefGerme{Compteur};3)
$THTML:=""
$THTML:=$THTML+"<tr id="+<>ZGuil+"zscore"+$Germe+<>ZGuil+" class="+<>ZGuil+"fondres"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <td></td>"+<>ZCR
$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttb2res"+<>ZGuil+" colspan="+<>ZGuil+"2"+<>ZGuil+">"+<>ZCR
If (LangueCourante="A")
	$THTML:=$THTML+"                   <b>WARNING</b> : If you do not fill 5 values of enumerations, ASA will not be able to calculate z-score"
Else 
	$THTML:=$THTML+"                   <b>ATTENTION</b> : Si vous ne remplissez pas les 5 valeurs de dénombrement,l'ASA ne sera pas en mesure de calculer votre z-score           "+<>ZCR
End if 
$THTML:=$THTML+"      </td>"+<>ZCR
$THTML:=$THTML+"   </tr>"+<>ZCR2
$0:=$THTML

