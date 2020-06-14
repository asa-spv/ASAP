//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/02/16, 07:47:02
  // ----------------------------------------------------
  // Méthode : ResP1ConstruitP2Trad <- ResP1MF <-  WebClicParticipant
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
  //  ResP1ConstruitP2Trad 
  // appelée par 

  // déclarations de variables
C_TEXT:C284($THTML;$Sep;$Guill;$CR)
C_LONGINT:C283($DernierNum;$NbMaxPages;$NbValeurs;$salé)
  // initialisation de variables
$Sep:=<>Sep
$Guill:=<>ZGuil
$CR:=Char:C90(10)+<>ZCR
  // création de la page 2 = programme
  //Si ($MCE=Faux)
$THTML:=ResRaemaCréationET ("Choix des germes")
$THTML:=$THTML+"        <br /> <br /> <br /> "+<>ZCR
If (LangueCourante="A")
	$THTML:=$THTML+"      <p class="+<>ZGuil+"rougeRAEMA"+<>ZGuil+">"+$CR
	$THTML:=$THTML+"      <u> Reminder :</u> if you send several input to ASA, only the last one will be taken into account <br /> <br /> <br />"
	$THTML:=$THTML+"      </p>"+$CR
Else 
	$THTML:=$THTML+"      <p class="+<>ZGuil+"rougeRAEMA"+<>ZGuil+">"+$CR
	$THTML:=$THTML+"      <u>Attention :</u>  Nous vous rappelons que si vous envoyez plusieurs saisies à l’ASA, seule la dernière sera prise en compte <br /> <br /> <br />"
	$THTML:=$THTML+"      </p>"+$CR
End if 
$THTML:=$THTML+"      <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+$CR
$THTML:=$THTML+"       "+RaemaTraducUtiliseTableau (12)+"<br />"+$CR
$THTML:=$THTML+"       "+RaemaTraducUtiliseTableau (13)+"<br />"+$CR
$THTML:=$THTML+"      </p>"+$CR
$THTML:=$THTML+"     <form name="+<>ZGuil+"form1"+<>ZGuil+" method="+<>ZGuil+"Post"+<>ZGuil+" action="+<>ZGuil+"mw2ResP2MF"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       <input type="+$Guill+"hidden"+$Guill+" name="+$Guill+"hiddenField"+$Guill+" value="+$Guill+UUIDParticipation+$Guill+" />"+$CR
$THTML:=$THTML+"       <table class="+<>ZGuil+"raematradtbp1"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+ResP1EcritLigneP2 (RaemaTraducUtiliseTableau (26);"3";"1";RaemaTraducUtiliseTableau (14);"6";RaemaTraducUtiliseTableau (15))+$CR  // ligne 1
$THTML:=$THTML+ResP1EcritLigneP2 (RaemaTraducUtiliseTableau (27);"32";"2";RaemaTraducUtiliseTableau (16);"7";RaemaTraducUtiliseTableau (17))+$CR  // ligne 2
$THTML:=$THTML+ResP1EcritLigneP2 (RaemaTraducUtiliseTableau (28);"33";"3";RaemaTraducUtiliseTableau (18);"8";RaemaTraducUtiliseTableau (19))+$CR  // ligne 3
$THTML:=$THTML+ResP1EcritLigneP2 (RaemaTraducUtiliseTableau (29);"34";"4";RaemaTraducUtiliseTableau (20);"9";RaemaTraducUtiliseTableau (21))+$CR  // ligne 4
$THTML:=$THTML+ResP1EcritLigneP2 (RaemaTraducUtiliseTableau (30);"35";"5";RaemaTraducUtiliseTableau (22);"10";RaemaTraducUtiliseTableau (23))+$CR  // ligne 5
$THTML:=$THTML+"          <tr>"+<>ZCR+"           <td> </td>"+<>ZCR+"           <td> </td>"+<>ZCR+"           <td>"+<>ZCR
$ValeurBoiteACocher:=ResP1SortValeurBoiteP2 ("11")
$THTML:=$THTML+"            <input name="+$guill+"CB11"+$Guill+" Type="+$guill+"checkbox"+$guill
$THTML:=$THTML+" id="+$guill+"CB11"+$guill+" value="+$guill+"checkbox"+$guill+" "+$ValeurBoiteACocher+" />"+<>ZCR
$THTML:=$THTML+"             "+RaemaTraducUtiliseTableau (24)+<>ZCR+"           </td>"+<>ZCR+"          </tr>"+<>ZCR+"         </table>"+<>ZCR
$THTML:=$THTML+"             "+"<br />"+$CR+"         <p class="+$guill+"titrepage"+$guill+">"+<>ZCR
$THTML:=$THTML+"          <input type="+$guill+"submit"+$guill+" name="+$guill+"Submit"+$guill+" value="+$guill+RaemaTraducUtiliseTableau (25)+$guill
$THTML:=$THTML+" class="+$guill+"titrepage"+$guill+" />"+<>ZCR
$THTML:=$THTML+"       <input type="+$Guill+"hidden"+$Guill+" name="+$Guill+"langage"+$Guill+" value="+$Guill+LangueCourante+$Guill+" />"+$CR
$THTML:=$THTML+"         </p><br />"+$cr+"       </form>"+$CR
$THTML:=$THTML+ResRaemaCréationPied 
  // FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)


