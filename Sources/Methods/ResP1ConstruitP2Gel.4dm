//%attributes = {}
  // ResP1ConstruitP2Gel <- ResP1MF

C_LONGINT:C283($Salé;$FT)
  // recherche des [CampagneGelGermes] à la campagne Gel actuelle pour le laboratoire actuel
$identifiantParticipation:=NumLaboActuelA+"_"+NumCampagneActuelle+"_"
$LigneTableauParticipation:=Find in array:C230(<>TbLotoIdentifiantParticipation;$identifiantParticipation)
  // Fabrication du tableau des germes du laboratoire. 
  // + cas du testeur =13 avec TestLabo13=Vrai initialisé dans WebClicParticipant


  // Affichage des seuls germes commandés
TestLabo13:=(NumLaboActuelA="13")

If ($LigneTableauParticipation>0) | (TestLabo13)
	$THTML:=ResRaemaCréationET ("Choix des germes pertinents")
	$THTML:=$THTML+"      <p class="+<>ZGuil+"rougeRAEMA"+<>ZGuil+"> <br /> "+<>ZCR
	$THTML:=$THTML+"      <u>Attention :</u>  Nous vous rappelons que si vous envoyez plusieurs saisies à l’ASA, seule la dernière sera prise en compte <br />"
	$THTML:=$THTML+"      </p>"+<>ZCR
	$THTML:=$THTML+"     <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR+"<br /> "
	$THTML:=$THTML+"        Veuillez cocher la case ET entrer le numéro d'échantillon"
	$THTML:=$THTML+" des germes concernés par votre laboratoire"+<>ZCR
	$THTML:=$THTML+"    </p>"+<>ZCR
	$THTML:=$THTML+"    <p> <br /> </p>"+<>ZCR
	$THTML:=$THTML+""+<>ZCR
	  // ET du tableau des choix
	$THTML:=$THTML+"   <form name="+<>ZGuil+"form1"+<>ZGuil+" method="+<>ZGuil+"Post"+<>ZGuil+" action="+<>ZGuil+"mw2ResP2MF"+<>ZGuil+"> "+<>ZCR
	$THTML:=$THTML+"    <p> <input type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hiddenField"+<>ZGuil+" value="+<>ZGuil+UUIDParticipation+<>ZGuil+" /> </p> "+<>ZCR
	$THTML:=$THTML+"    <p> <input type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"langage"+<>ZGuil+" value="+<>ZGuil+LangueCourante+<>ZGuil+" /> </p> "+<>ZCR
	$THTML:=$THTML+"    <div align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"         <table width="+<>ZGuil+"650"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        <tr>"+<>ZCR
	$THTML:=$THTML+"            <th class="+<>ZGuil+"colonne2"+<>ZGuil+">Germe choisi</th>"+<>ZCR
	$THTML:=$THTML+"            <th class="+<>ZGuil+"colonne2rc"+<>ZGuil+">N°</th>"+<>ZCR
	  //$THTML:=$THTML+"            <th class="+<>ZGuil+"colonne2rc"+<>ZGuil+">Nb de pots</th>"+<>ZCR
	$THTML:=$THTML+"        </tr>"+<>ZCR2
	  // LIGNES du tableau des choix
	$Impaire:=True:C214  // gestion des lignes paires ou impaires
	$FT:=Size of array:C274(<>TbPtTbParticipeGermeGEL)
	For ($Salé;1;$FT)
		If (<>TbPtTbParticipeGermeGEL{$Salé}->{$LigneTableauParticipation}#"") | (TestLabo13)
			$PaireImpaire:=Num:C11($Impaire)*"im"
			$THTML:=$THTML+"        <tr class="+<>ZGuil+"ligne"+$PaireImpaire+"paire"+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+"            <td class="+<>ZGuil+"rccolonne1"+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+"              <input type="+<>ZGuil+"checkbox"+<>ZGuil+" name="+<>ZGuil+"rgcb"+String:C10($Salé)+<>ZGuil
			$THTML:=$THTML+" value="+<>ZGuil+"checkbox"+<>ZGuil+ResP1SortValeurBoiteP2 (String:C10($Salé);True:C214)
			$THTML:=$THTML+" />"+<>TbNomGermeSchémaGEL{$Salé}+<>ZCR+"            </td>"+<>ZCR
			$THTML:=$THTML+"            <td class="+<>ZGuil+"rccolonne2"+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+"                <input class="+<>ZGuil+"rccolonne2"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil
			$THTML:=$THTML+" name="+<>ZGuil+"rgtextfield"+String:C10($Salé)+<>ZGuil+" size="+<>ZGuil+"6"+<>ZGuil
			$THTML:=$THTML+" value="+<>ZGuil+ResP1SortValeurChampP2 (String:C10($Salé);True:C214)+<>ZGuil+" />"+<>ZCR
			$THTML:=$THTML+"            </td>"+<>ZCR
			$THTML:=$THTML+"        </tr>"+<>ZCR2
			$Impaire:=Not:C34($Impaire)
		End if 
	End for 
	$THTML:=$THTML+"    </table>"+<>ZCR+"        <p> <br /> </p>"+<>ZCR+<>ZCR
	
	$THTML:=$THTML+"<p class="+<>ZGuil+"hautpage"+<>ZGuil+"> "+<>ZCR
	$THTML:=$THTML+"Si les germes cités ci-dessus ne sont pas ceux demandés, contacter l'association"+<>ZCR
	$THTML:=$THTML+"<br />"+<>ZCR
	$THTML:=$THTML+"<a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"Envoyer un mail à l'ASA"+<>ZCR
	$THTML:=$THTML+"</a><br />Sinon<br />"+<>ZCR
	$THTML:=$THTML+"</p>"+<>ZCR
	$THTML:=$THTML+"    <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"Submit"+<>ZGuil+" class="+<>ZGuil+"titrepage"+<>ZGuil
	$THTML:=$THTML+" value="+<>ZGuil+"Construire le questionnaire"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        <p> <br /> <br /> </p>"+<>ZCR
	$THTML:=$THTML+"    </div>"+<>ZCR
	$THTML:=$THTML+"   </form>"+<>ZCR
	
Else 
	$THTML:=ResRaemaCréationET ("Saisie du RAEMA gel impossible")
	$THTML:=$THTML+"<br /><br /> <br /><br />"+<>ZCR
	$THTML:=$THTML+"<p class="+<>ZGuil+"hautpage rouge"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"Vérification des données"+<>ZCR
	$THTML:=$THTML+"</p>"+<>ZCR
	$THTML:=$THTML+"<p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"Après vérification des informations que vous avez saisies, <br />"+<>ZCR
	$THTML:=$THTML+"il semble que votre laboratoire ne soit pas inscrit au RAEMA gel"+<>ZCR
	$THTML:=$THTML+"</p>"+<>ZCR
	$THTML:=$THTML+"<br />"+<>ZCR
	$THTML:=$THTML+"<br /><br /><br />"+<>ZCR
	$THTML:=$THTML+"<p class="+<>ZGuil+"hautpage"+<>ZGuil+"> "+<>ZCR
	$THTML:=$THTML+"Si ce n'est pas le cas, contacter l'association"+<>ZCR
	$THTML:=$THTML+"<br />"+<>ZCR
	$THTML:=$THTML+"<a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"Envoyer un mail à l'ASA"+<>ZCR
	$THTML:=$THTML+"</a>"+<>ZCR
	$THTML:=$THTML+"</p>"+<>ZCR
End if 

$THTML:=$THTML+ResRaemaCréationPied 
$Pragma:="pragma: no-cache"
WEB SET HTTP HEADER:C660($Pragma)
WEB SEND TEXT:C677($THTML)
  // FIXER TEXTE DANS CONTENEUR($THTML)
