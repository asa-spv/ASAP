//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/07/18, 19:19:44
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : ResP2HtmlResultats  <=  ResP2CreationLignesOKP3 <= ResP2FabriqueRaemaRestreint <=  ResP2MF = traitement de la page 2
  // Description
  //  Ecrit et renvoie le HTML du pavé des résultats
  // Création de la ligne d'annonce de "Saisie des dilutions et des concentrations"

C_LONGINT:C283($Fumé)

$THTML:=""
$THTML:=$THTML+"              <tr class="+<>ZGuil+"fondres"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                <td class="+<>ZGuil+"hauttbres"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+ResP2LigneAttentionPoudre 
For ($Fumé;1;5)
	$THTML:=$THTML+ResP2LigneResultatAvecDilution ($Fumé)
End for 
$THTML:=$THTML+ResP2PiedResultatAvecDilution 
Compteur:=Compteur+10
$0:=$THTML
