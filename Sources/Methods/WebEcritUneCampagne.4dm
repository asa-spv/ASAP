//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/03/16, 16:56:43
  // ----------------------------------------------------
  // Méthode : WebEcritUneCampagne
  // Description
  // Ecrit dans l'agenda le HTML de l'enregistrement courant 
  // de [XData] correspondant au RAEMA concerné
  // ----------------------------------------------------

$Anglais:=$1
$THTML:=""
$NumRAEMA:=[RAEMACampagnes:20]NumCampagne:2

If ($Anglais)
	$DateEnvoi:=YEcritDateEnAnglais ([RAEMACampagnes:20]DateEnvoiColis:3)
	$DateLimite:=YEcritDateEnAnglais ([RAEMACampagnes:20]DateLimiteReponse:4)
Else 
	$DateEnvoi:=Replace string:C233(String:C10([RAEMACampagnes:20]DateEnvoiColis:3;3);" 1 ";" 1<span class="+<>ZGuil+"expose"+<>ZGuil+">er </span>")
	$DateLimite:=Replace string:C233(String:C10([RAEMACampagnes:20]DateLimiteReponse:4;3);" 1 ";" 1<span class="+<>ZGuil+"expose"+<>ZGuil+">er </span>")
End if 
  // Extraction des données de la campagne incluse par ReamaCodeXDonneesAlpha dans [XData]XAlpha
  //ReamaCodeXDonneesAlpha -> Chaine(VarDateWebCamp)+<>ZTab+Chaine(VarNbreLabos)+<>ZTab+Chaine(CaseAccredite)+Chaine(CaseRI)
  // RaemaSchemaCodeXDonneesAlpha(Vrai)
VarNbreLabos:=[RAEMACampagnes:20]NbParticipants:6
VarDateWebCamp:=[RAEMACampagnes:20]DateEnvoiColis:3
CaseAccredite:=1
CaseRI:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Sous accréditation";Est un booléen:K8:9)

$derlettre:=$NumRAEMA[[Length:C16($NumRAEMA)]]
If ($Anglais)
	$poudregel:=(Num:C11($derlettre="A")*"gel")+(Num:C11($derlettre#"A")*"powder")
	$NumTypeCampagne:="Campaign n° "+$NumRAEMA+" (RAEMA "+$poudregel+(CaseAccredite*" under accreditation")+") : "
Else 
	$poudregel:=(Num:C11($derlettre="A")*"gel")+(Num:C11($derlettre#"A")*"poudre")
	$NumTypeCampagne:="Campagne n° "+$NumRAEMA+" (RAEMA "+$poudregel+(CaseAccredite*" sous accréditation")+") : "
End if 
$NbreLabosA:=String:C10(VarNbreLabos)
$CDRG:="pdf/RG"+$NumRAEMA+".pdf"
$CDRI:="pdf/RI"+$NumRAEMA+".pdf"

$THTML:=$THTML+"     <br />"+<>ZCR
$THTML:=$THTML+"    <p>"+<>ZCR+"     <span class="+<>ZGuil+"plusbleu"+<>ZGuil+">"+$NumTypeCampagne+" </span> "+<>ZCR
If (VarNbreLabos>1)
	If ($Anglais)
		$THTML:=$THTML+"      "+$NbreLabosA+" laboratories"+<>ZCR
	Else 
		$THTML:=$THTML+"      "+$NbreLabosA+" laboratoires"+<>ZCR
	End if 
	
End if 
$THTML:=$THTML+"    </p>"+<>ZCR
$THTML:=$THTML+"    <table width="+<>ZGuil+"100%"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <tr> "+<>ZCR
$THTML:=$THTML+"       <td width="+<>ZGuil+"75%"+<>ZGuil+" height="+<>ZGuil+"38"+<>ZGuil+" >"+<>ZCR
If ($Anglais)
	$onteteseront:=(Num:C11([RAEMACampagnes:20]DateEnvoiColis:3<=Current date:C33)*"were sent to laboratories on ")
	$onteteseront:=$onteteseront+(Num:C11([RAEMACampagnes:20]DateEnvoiColis:3>Current date:C33)*"will be send to laboratories on ")
	$THTML:=$THTML+"        The samples "+$onteteseront+$DateEnvoi+<>ZCR
	$THTML:=$THTML+"        <br />Deadline for reporting results: "+$DateLimite+<>ZCR
Else 
	$onteteseront:=(Num:C11([RAEMACampagnes:20]DateEnvoiColis:3<=Current date:C33)*"ont été")
	$onteteseront:=$onteteseront+(Num:C11([RAEMACampagnes:20]DateEnvoiColis:3>Current date:C33)*"seront")
	$THTML:=$THTML+"        Les échantillons "+$onteteseront+" envoyés aux laboratoires le "+$DateEnvoi+<>ZCR
	$THTML:=$THTML+"        <br />Date limite de rendu des résultats : "+$DateLimite+<>ZCR
	If (VarDateWebCamp#!00-00-00!)
		If ($Anglais)
			$VarDateWebCampA:=YEcritDateEnAnglais ($VarDateWebCamp)
			$THTML:=$THTML+"        <br /> Online publication of Reports: "+$VarDateWebCampA+<>ZCR
		Else 
			$THTML:=$THTML+"        <br /> Mise en ligne des rapports: le "
			$THTML:=$THTML+Replace string:C233(String:C10(VarDateWebCamp;3);" 1 ";" 1<span class="+<>ZGuil+"expose"+<>ZGuil+">er </span>")+<>ZCR
		End if 
	End if 
End if 

$THTML:=$THTML+"       </td>"+<>ZCR
  // Pièces-jointes ?
If (VarDateWebCamp#!00-00-00!)
	
	$THTML:=$THTML+"       <td width="+<>ZGuil+"5%"+<>ZGuil+" class="+<>ZGuil+"tbcentrev"+<>ZGuil+">"
	$THTML:=$THTML+"        <img src="+<>ZGuil+"images/impdf.gif"+<>ZGuil+" width="+<>ZGuil+"32"+<>ZGuil+" height="+<>ZGuil+"32"+<>ZGuil+" /></td>"+<>ZCR
	$THTML:=$THTML+"       <td width="+<>ZGuil+"20%"+<>ZGuil+" class="+<>ZGuil+"tbcentrev"+<>ZGuil+" >"+<>ZCR
	$THTML:=$THTML+"         <a"+<>ZCR
	$THTML:=$THTML+"          href="+<>ZGuil+$CDRG+<>ZGuil+<>ZCR
	$RG:=(Num:C11($Anglais)*"General Report")+(Num:C11(Not:C34($Anglais))*"Rapport général")
	$THTML:=$THTML+"          target="+<>ZGuil+"_blank"+<>ZGuil+">"+$RG+<>ZCR
	$THTML:=$THTML+"         </a>"+<>ZCR
	If (CaseRI=1)  // Le rapport individuel est préssenti
		$CDRIComplet:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$CDRI
		If (Test path name:C476($CDRIComplet)=Est un document:K24:1)
			$RI:=(Num:C11($Anglais)*"Individual Report")+(Num:C11(Not:C34($Anglais))*"Rapport individuel")
			$THTML:=$THTML+"        <br />"+<>ZCR+"       <a href="+<>ZGuil+$CDRI+<>ZGuil+<>ZCR
			$THTML:=$THTML+"          target="+<>ZGuil+"_blank"+<>ZGuil+">"+$RI+<>ZCR
			$THTML:=$THTML+"        </a>"+<>ZCR
		End if 
	End if 
	$THTML:=$THTML+"       </td>"+<>ZCR
End if 
$THTML:=$THTML+"      </tr>"+<>ZCR
$THTML:=$THTML+"     </table>"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR2
$0:=$THTML