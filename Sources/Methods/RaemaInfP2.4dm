//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : IMacASA
  // Date et heure : 14/04/14, 14:02:16
  // ----------------------------------------------------
  // Méthode : RaemaInfP2
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$Fumé;$Sec;$SFT;$Rang)

ZAmnistieInternationale 
  // Initialisation des tableaux présents dans chaque connexion (WebChercheFicheXDonnées)
ARRAY TEXT:C222($TbNoms;0)  // les noms récoltés sur le formulaire Web P1
ARRAY TEXT:C222($TbValeurs;0)  // les valeurs récoltées sur le formulaire Web P1

WEB GET VARIABLES:C683($TbNoms;$TbValeurs)  // Lecture des données de la page Web
$NumCampagneInfo:=<>NumCampagneEnCoursInfoOK  // récupérons le n° de RAEMA actuel (alphanumérique)
RaemaPoudre:=(String:C10(Num:C11($NumCampagneInfo))=$NumCampagneInfo)
  // si Vrai RAEMA traditionnel, Complémentaire si Faux
MotDePasseActuel:=WebTrouveValeurParNom ("hiddenField";->$TbNoms;->$TbValeurs)  // Le mot de passe, bien sur
NumLaboActuelA:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerNumLaboRAEMAA)


  // Les n° existent-ils vraiment ?
$OC:=True:C214
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursInfoOK)
$Rang:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Rang";Est un entier long:K8:6)
$NumEchantillons:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"N° des échantillons";Est un texte:K8:3)
$GloubiBoulga:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)

  // Plaçons les n° d'échantillons dans $TbEchPossibles
ARRAY TEXT:C222($TbEchPossibles;0)
ZTexteVersTableau ($NumEchantillons;->$TbEchPossibles)

  // Comparons aux n° saisis
ARRAY TEXT:C222($TbEchSaisis;0)
$AuMoinsUn:=False:C215
For ($salé;1;5)
	  //$pt:=Pointeur vers("Ech"+Chaîne($salé))
	  //$ValSaisie:=$pt->
	$ValSaisie:=WebTrouveValeurParNom (("Ech"+String:C10($salé));->$TbNoms;->$TbValeurs)
	If (Length:C16($ValSaisie)>0)
		If (Find in array:C230($TbEchPossibles;$ValSaisie)>0)
			If (Find in array:C230($TbEchSaisis;$ValSaisie)<0)
				APPEND TO ARRAY:C911($TbEchSaisis;$ValSaisie)
				$AuMoinsUn:=True:C214
			End if 
		Else 
			$OC:=False:C215
			$Salé:=6
		End if 
	End if 
End for 

If ($OC) & ($AuMoinsUn)
	VarNomTableau:="Niveau de contamination du RAEMA "+$NumCampagneInfo
	RELATE MANY:C262([RAEMACampagnes:20]UUID:1)
	ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
	ARRAY TEXT:C222(TbNomGermeConta;0)
	  //Si (LangueCourante="F")
	SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;TbNomGermeConta)
	DELETE FROM ARRAY:C228(TbNomGermeConta;1)
	  //Sinon 
	  //SÉLECTION VERS TABLEAU([RAEMAGermes]NomEn;TbNomGermeConta)
	  //Fin de si 
	RaemaFabriqueLBContamination ($GloubiBoulga;$NumCampagneInfo)
	  // L'en-tete
	$Texte:=ResRaemaCréationET ("Tableau des niveaux de contamination")
	
	  // Le tableau
	  //Si (LangueCourante="F")
	$TitrePage:="Niveau de contamination des échantillons du RAEMA "
	$TitreNumEch:="Numéro de vos échantillons"
	$NomGermes:="Noms des germes"
	  //Sinon 
	  //$TitrePage:="Level of contamination of samples RAEMA "
	  //$TitreNumEch:="Number of your Samples"
	  //$NomGermes:="Names of germs"
	  //Fin de si 
	$TitrePage:=$TitrePage+<>NumCampagneEnCoursInfoOK
	$THTML:="<br /> <br /> <br /> <br /> <br /> <br /> "+<>ZCR
	$THTML:=$THTML+"<p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+$TitrePage+"</p>"+<>ZCR
	$THTML:=$THTML+"<div align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
	
	$THTML:=$THTML+"  <table width="+<>ZGuil+"90%"+<>ZGuil+">"+<>ZCR
	
	$THTML:=$THTML+"    <tr>"+<>ZCR  // Première ligne
	$THTML:=$THTML+"      <td width="+<>ZGuil+"40%"+<>ZGuil+">&nbsp;</td>"+<>ZCR
	$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttb2"+<>ZGuil+" colspan="+<>ZGuil+"5"+<>ZGuil+">"+$TitreNumEch+"</td>"+<>ZCR
	$THTML:=$THTML+"    </tr>"+<>ZCR
	
	$THTML:=$THTML+"    <tr>"+<>ZCR  // ligne 2 = ET
	$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttb2"+<>ZGuil+">"+$NomGermes+"</td>"+<>ZCR
	
	$FT:=Size of array:C274($TbEchSaisis)
	$SFT:=Size of array:C274(TbNomGermeConta)
	For ($Sec;1;$FT)
		$THTML:=$THTML+"      <td class="+<>ZGuil+"hauttb2"+<>ZGuil+" width="+<>ZGuil+"12%"+<>ZGuil+">"+$TbEchSaisis{$Sec}+"</td>"+<>ZCR
	End for 
	$THTML:=$THTML+"    </tr>"+<>ZCR
	$Pair:=True:C214
	For ($Fumé;1;$SFT)
		$Pair:=Not:C34($Pair)
		$CouleurLigne:="ligne"+(Num:C11($Pair)*"im")+"paire"
		$THTML:=$THTML+"    <tr class="+<>ZGuil+$CouleurLigne+<>ZGuil+">"+<>ZCR  // Ligne germe 1
		$THTML:=$THTML+"      <td>"+TbNomGermeConta{$Fumé}+"</td>"+<>ZCR
		For ($Salé;1;$FT)
			$Ligne:=Substring:C12($TbEchSaisis{$Salé};$Rang;1)
			$Pt:=Get pointer:C304("TbSerie"+$Ligne+"Conta")
			  //$Col:=RaemaInfExtraitRang($TbEchSaisis{$Salé};$Rang)
			  // $Pt:=Pointeur vers("Colonne"+Chaîne($Col+2))
			$THTML:=$THTML+"      <td class="+<>ZGuil+"celluleconta"+<>ZGuil+">"+$Pt->{$Fumé}+"</td>"+<>ZCR
		End for 
	End for 
	$THTML:=$THTML+"    </tr>"+<>ZCR+"</table>"+<>ZCR+"</div>"+<>ZCR
	
	
	  // le pied
	$Texte:=$Texte+$THTML+ResRaemaCréationPied 
	
	
	WEB SEND TEXT:C677($Texte)
Else 
	MotifErreur1:="Les numéros d'échantillons ne sont pas correctements saisis."+<>ZCR
	MotifErreur2:="Veuillez les ressaisir tels qu'ils sont sur les conditionnements"
	MotifErreur3:=""
	RapAffichePb ("Erreur d'échantillon";"VERIFICATION DES SAISIES";MotifErreur1;MotifErreur2;MotifErreur3)
End if 