//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/18, 15:08:50
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ResP2LigneAttentionPoudre <= ResP2HtmlResultats  <=  ResP2CreationLignesOKP3 <= ResP2FabriqueRaemaRestreint <=  ResP2MF = traitement de la page 2
  // Description : écrit le HTML du bloc d'avertissement sur les valeurs à noter pour les dilutions et les résultats
  // 
$THTML:=""
If (RaemaPoudre)
	If (LangueCourante="A")
		$DilAnnonce:="Entering dilutions<br />and concentrations"
		$Attention:="<b>WARNING</b> : <br />"+<>ZCR
		$Attention:=$Attention+"                  (1) Please enter the dilution corresponding to the 1st retained dilution"+<>ZCR
		$Attention:=$Attention+"                  (initial suspension is considered the dilution <b>-1</b>, the first decimal dilution as <b>-2</b>, ...). <br />"+<>ZCR
		$Attention:=$Attention+"                  In agreement with the method you use, you can inform values such as 1/400."+<>ZCR
		$Attention:=$Attention+"                  <span class="+<>ZGuil+"souligne"+<>ZGuil+">Example</span> : if you retain dilutions <b>-1</b> and <b>-2</b>, please indicate <b>-1</b> in the square dilution."+<>ZCR
		$Attention:=$Attention+"                  <br />"+<>ZCR
		$Attention:=$Attention+"                  (2) <b>Concentrations</b> are in principle <b>strictly positive integers</b>.<br /> "+<>ZCR
		$Attention:=$Attention+"                  However, when the value is below a threshold, enter <b>'0.1'</b>"+<>ZCR
		$Attention:=$Attention+"                  <br />"+<>ZCR
	Else 
		$THTML:=$THTML+" <tr class="+<>ZGuil+"fondres"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                <td class="+<>ZGuil+"hauttbres"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                  Saisie des dilutions<br />et des concentrations"+<>ZCR
		$THTML:=$THTML+"                </td>"+<>ZCR
		$THTML:=$THTML+"                <td class="+<>ZGuil+"hauttb2res"+<>ZGuil+" colspan="+<>ZGuil+"2"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                  <b>ATTENTION</b> : <br />"+<>ZCR
		$THTML:=$THTML+"                  (1) Veuillez saisir la dilution correspondant à la 1ère dilution retenue"+<>ZCR
		$THTML:=$THTML+"                  (la suspension mère est considérée comme la dilution <b>-1</b>, la 1ère dilution décimale comme la dilution <b>-2</b>, …).<br /> "+<>ZCR
		$THTML:=$THTML+"                  En accord avec la méthode que vous utilisez, vous avez la possibilité de renseigner des valeurs de type 1/400."+<>ZCR
		$THTML:=$THTML+"                  <span class="+<>ZGuil+"souligne"+<>ZGuil+">Exemple</span> : si vous retenez les dilutions <b>-1</b> et <b>-2</b>, indiquez <b>-1</b> dans le champ dilution."+<>ZCR
		$THTML:=$THTML+"                  <br />"+<>ZCR
		$THTML:=$THTML+"                  (2) Les résultats de <b>concentrations</b> sont, en principe, des <b>nombres entiers strictement positifs</b>.<br /> "+<>ZCR
		$THTML:=$THTML+"                  Toutefois, lorsque la réponse est inférieure à un seuil, mettre <b>'0.1'</b>"+<>ZCR
		$THTML:=$THTML+"                  <br />"+<>ZCR
		$THTML:=$THTML+"                </td>"+<>ZCR
		$THTML:=$THTML+"       </tr>"+<>ZCR
	End if 
End if 
$0:=$THTML+""+<>ZCR
