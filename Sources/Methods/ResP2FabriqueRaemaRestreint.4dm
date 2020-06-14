//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/07/18, 08:26:59
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP2FabriqueRaemaRestreint. <= ResP2MF = traitement de la page 2
  // Description
  // Ecrit et envoie la page 3 = saisie des résultats

  // déclarations de variables
C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($THTML)
$H1:=Milliseconds:C459

  // Ecriture du HTML
$THTML:=ResRaemaCréationET ("Saisie des résultats")
  //Si (Faux)
$THTML:=$THTML+"      <form name="+<>ZGuil+"form1"+<>ZGuil+" method="+<>ZGuil+"Post"+<>ZGuil
$THTML:=$THTML+" action="+<>ZGuil+"mw2ResP3MF"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <p>"+<>ZCR
$THTML:=$THTML+"          <input type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hiddenField"
$THTML:=$THTML+<>ZGuil+" value="+<>ZGuil+UUIDParticipation+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"        <table class="+<>ZGuil+"raematbp2"+<>ZGuil+">"+<>ZCR
$FT:=Size of array:C274(TbNCBC)  // tableau des cases cochées en P2 (choix des germes), initalisé dans ResP2MF par ResP2FabriqueTBCaseCochees
Compteur:=1  // Indique le rang de la ligne du tableau général des RAEMA
ARRAY TEXT:C222($TbRangGerme;$FT+1)
$TbRangGerme{1}:="01"  // Pour les conditions d'examen
For ($Salé;1;$FT)
	$TbRangGerme{$Salé+1}:=String:C10(Num:C11(TbNCBC{$Salé})+1;"00")
End for 
SORT ARRAY:C229($TbRangGerme;>)

$FT:=Size of array:C274(TbNCBC)+1  // +1 pour les conditions d'examen
For ($Salé;1;$FT)
	$THTML:=$THTML+ResP2CreationLignesOKP3 ($TbRangGerme{$Salé};$Salé)
	$THTML:=$THTML+<>ZCR+"        </table>"+<>ZCR
End for 
  //Fin du tableau
$THTML:=$THTML+<>ZCR+"        </table>"+<>ZCR+"<br />"+<>ZCR
  // Champ de commentaires libres
$THTML:=$THTML+"        <p class="+<>ZGuil+"grandhautpage"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"          <br /><br />"+<>ZCR

  // Rechercher le commentaire le plus récent
$AncienCommentaire:=WebTrouveValeurParNom ("commentaires";->TbAncNomsP3;->TbAncValeursP3)

If (LangueCourante="A")
	$THTML:=$THTML+"          Comment: <span class="+<>ZGuil+"petittextevert"+<>ZGuil
	$THTML:=$THTML+">Your opinion matters, please feel free to leave a message.</span>"+<>ZCR
Else 
	$THTML:=$THTML+"          Commentaires : <span class="+<>ZGuil+"petittextevert"+<>ZGuil
	$THTML:=$THTML+">Vous pouvez noter ici toutes les remarques que vous souhaitez faire parvenir à l'ASA.</span>"+<>ZCR
End if 
$THTML:=$THTML+"            <textarea name="+<>ZGuil+"commentaires"+<>ZGuil+" id="+<>ZGuil+"commentaires"+<>ZGuil+" cols="
$THTML:=$THTML+<>ZGuil+"100"+<>ZGuil+" rows="+<>ZGuil+"10"+<>ZGuil+">"+$AncienCommentaire+"</textarea>"+<>ZCR
$THTML:=$THTML+"        </p><br />"+<>ZCR

$THTML:=$THTML+"        <p class="+<>ZGuil+"petittextevert"+<>ZGuil+">"+RaemaTraducUtiliseTableau (38)
$THTML:=$THTML+<>ZCR+"          <a href="+<>ZGuil+"javascript:window.print()"+<>ZGuil+">"+RaemaTraducUtiliseTableau (39)+"</a>"+<>ZCR+<>ZCR+"</p>"
$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;NumLaboActuelA)  // Utilisation des tableaux de correspondance
$Email:=WebTrouveValeurParNom (NumLaboActuelA;-><>TbPerNumLaboRAEMAA;-><>TbPAEmailRAEMA)
If ($Email="")  // pas de mail
	$THTML:=$THTML+"          <br />"+<>ZCR+"        <p class="+<>ZGuil+"textebanalgrand rouge"+<>ZGuil
	If (LangueCourante="F")
		$THTML:=$THTML+">Aucune adresse mail n'a été notée pour la récupération des rapports de campagne "+": <br />"
		$THTML:=$THTML+"Merci de contacter au plus tôt l'association"+<>ZCR
		$THTML:=$THTML+"          <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+"> Envoyer un mail à l'ASA</a>"
	Else 
		$THTML:=$THTML+">There is no address for the download of the reports "+": <br />"
		$THTML:=$THTML+"Could you contact the association as soon as possible ?"+<>ZCR
		$THTML:=$THTML+"          <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+"> Send an mail to ASA</a>"
	End if 
Else   // l'adresse mail $Email existe
	$THTML:=$THTML+"          <br />"+<>ZCR+"        <p class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"
	$THTML:=$THTML+RaemaTraducUtiliseTableau (84)+<>ZCR+"<br />"+"Adresse mail :<span class="+<>ZGuil+"plus"+<>ZGuil+">"+$Email+"</span>"+<>ZCR
	$THTML:=$THTML+RaemaTraducUtiliseTableau (97)+"<a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+RaemaTraducUtiliseTableau (98)+"</a>"+<>ZCR
End if 
$THTML:=$THTML+"        </p> <br />"+<>ZCR

$THTML:=$THTML+"       <input type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"langage"+<>ZGuil+" value="+<>ZGuil+LangueCourante+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"titrepage"+<>ZGuil+"><input type="+<>ZGuil+"submit"+<>ZGuil
$THTML:=$THTML+" name="+<>ZGuil+"Submit"+<>ZGuil+" value="+<>ZGuil+RaemaTraducUtiliseTableau (40)+<>ZGuil+" class="+<>ZGuil+"titrepage"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"          <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"Submit2"+<>ZGuil+" value="+<>ZGuil+RaemaTraducUtiliseTableau (41)+<>ZGuil+" />"+<>ZCR2
$THTML:=$THTML+"      </form> <br />"+<>ZCR
  //Fin de si 
$THTML:=$THTML+ResRaemaCréationPied 
$H2:=Milliseconds:C459
  // ALERTE(Chaîne($H2-$H1))

  // FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)


