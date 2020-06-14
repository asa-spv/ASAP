//%attributes = {}
  // ResP3CreationPageAR
  // appelée par ResP3EnvoiMailAsa


  //CHERCHER([XDonnées];[XDonnées]XType=("Q"+NumRaemaCourant);*)
  //CHERCHER([XDonnées]; & [XDonnées]XValeur=Num(NumLaboActuelA))
  //Si (Enregistrements trouves([XDonnées])=0)
  //MethodeASuivre:="mw2raemapostquestion2"
  //RaemaQuestionnaire 
  //Sinon 
$Guill:=<>ZGuil
$THTML:=ResRaemaCréationET ("Saisie conforme")
$THTML:=$THTML+"       <br /><br />"
$THTML:=$THTML+"       <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"
$THTML:=$THTML+RaemaTraducUtiliseTableau (47)+"<br />"+<>ZCR+"       </p>"+<>ZCR
$THTML:=$THTML+"       <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"
$THTML:=$THTML+RaemaTraducUtiliseTableau (48)+<>ZCR+"       </p><br />"+<>ZCR
$THTML:=$THTML+"       <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"
$THTML:=$THTML+RaemaTraducUtiliseTableau (49)+<>ZCR+"       </p><br />"
If (LangueCourante="A")
	$THTML:=$THTML+"       <p class="+<>ZGuil+"rougeRAEMA"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"           In order to check your input, you can ask for an acknowledgement of receipt. "
	$THTML:=$THTML+"Please note that it will not be possible to correct any mistake from your input once the reports has been published."
	$THTML:=$THTM+"        </p><br />"+<>ZCR
Else 
	$THTML:=$THTML+"       <p class="+<>ZGuil+"rougeRAEMA"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"         Il vous est possible de demander un accusé de réception afin de vérifier votre saisie. "
	$THTML:=$THTML+"Veuillez noter que si vous constatez une erreur de saisie après l’édition des rapports, "
	$THTML:=$THTML+"aucune modification ne pourra être apportée."+"</p><br />"+<>ZCR
End if 
$THTML:=$THTML+"       <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"
$THTML:=$THTML+RaemaTraducUtiliseTableau (50)+RaemaTraducUtiliseTableau (51)+<>ZCR+"       </p><br />"+<>ZCR
$THTML:=$THTML+"       <form name="+<>ZGuil+"form1"+<>ZGuil+" method="+<>ZGuil
$THTML:=$THTML+"Post"+<>ZGuil+" action="+<>ZGuil+"mw2ResP4MF"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <div align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           <p class="+<>ZGuil+"hautpage"+<>ZGuil+">Adresse mail "+<>ZCR
$Email:=WebTrouveValeurParNom (NumLaboActuelA;-><>TbPerNumLaboRAEMAA;-><>TbPAEmailRAEMA)
$THTML:=$THTML+"             <input name="+<>ZGuil+"mail1"+<>ZGuil+" type="+<>ZGuil
$THTML:=$THTML+"text"+<>ZGuil+" size="+<>ZGuil+"50"+<>ZGuil+" value="+<>ZGuil+$Email+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           </p>"+<>ZCR
$THTML:=$THTML+"           <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+RaemaTraducUtiliseTableau (56)+<>ZCR
$THTML:=$THTML+"             <input name="+<>ZGuil+"mail12"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil
$THTML:=$THTML+" size="+<>ZGuil+"50"+<>ZGuil+" value="+<>ZGuil+$Email+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           </p>"+<>ZCR
$THTML:=$THTML+"           <p> "+<>ZCR
$Checked:=" checked"*Num:C11($Email#"")
$THTML:=$THTML+"             <input type="+<>ZGuil+"checkbox"+<>ZGuil+" name="+<>ZGuil+"checkbox"
$THTML:=$THTML+<>ZGuil+" value="+<>ZGuil+"checkbox"+<>ZGuil+$Checked+">"+RaemaTraducUtiliseTableau (53)+<>ZCR
$THTML:=$THTML+"           </p>"+<>ZCR
$THTML:=$THTML+"           <p class="+<>ZGuil+"petittextevert"+<>ZGuil+">"+RaemaTraducUtiliseTableau (52)
$THTML:=$THTML+"           </p>"+" <br />"+<>ZCR
$THTML:=$THTML+"           <p> "+<>ZCR
$THTML:=$THTML+"             <input type="+$Guill+"hidden"+$Guill+" name="+$Guill+"langage"+$Guill+" value="+$Guill+LangueCourante+$Guill+" />"+<>ZCR
$THTML:=$THTML+"             <input class="+<>ZGuil+"titrepage"+<>ZGuil+"type="+<>ZGuil+"submit"+<>ZGuil
$THTML:=$THTML+" name="+<>ZGuil+"Submit"+<>ZGuil+" value="+<>ZGuil+RaemaTraducUtiliseTableau (34)+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"             <input type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hiddenField"+<>ZGuil+" value="+UUIDParticipation+" />"
$THTML:=$THTML+"           </p>"+<>ZCR
$THTML:=$THTML+"         </div>"+<>ZCR+"       </form>"+<>ZCR
$THTML:=$THTML+"         <br />"+<>ZCR
$THTML:=$THTML+"         <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+RaemaTraducUtiliseTableau (54)+"<br />"+<>ZCR
$THTML:=$THTML+"              <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+RaemaTraducUtiliseTableau (55)+"</a>"
$THTML:=$THTML+"         </p>"+<>ZCR
$THTML:=$THTML+ResRaemaCréationPied 
WEB SEND TEXT:C677($THTML)
