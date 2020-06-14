//%attributes = {}
  //  ResP4MF
  // permet d'envoyer un mail d'accusé de réception
  // appelée par la page 4 si le labo veut un AR

C_TEXT:C284($ResumeCampagne)
<>ZCRWeb:=<>ZCR+Char:C90(10)
ARRAY TEXT:C222(TbNomsP5;0)
ARRAY TEXT:C222(TbValeursP5;0)
WEB GET VARIABLES:C683(TbNomsP5;TbValeursP5)
$ValeurAdresseCourrielA:=WebTrouveValeurParNom ("mail1";->TbNomsP5;->TbValeursP5)
$ValeurAdresseCourrielB:=WebTrouveValeurParNom ("mail12";->TbNomsP5;->TbValeursP5)
UUIDParticipation:=WebTrouveValeurParNom ("hiddenField";->TbNomsP5;->TbValeursP5)  // mot de passe
NumLaboActuelA:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerNumLaboRAEMAA)
LangueCourante:=WebTrouveValeurParNom ("langage";->TbNomsP5;->TbValeursP5)

WebLireTableauxAnterieurs 
WebActualiseConnexionSaisie (NumLaboActuelA;5;$ValeurAdresseCourrielA)
AlerteMail:=""
If ($ValeurAdresseCourrielA#$ValeurAdresseCourrielB)
	  //AlerteMail:=TraducUtiliseTableau (64)+<>ZCR
	  //AlerteMail:=AlerteMail+TraducUtiliseTableau (65)
	  //ALERTE(AlerteMail)
	MotifErreur1:=RaemaTraducUtiliseTableau (64)+<>ZCR
	MotifErreur2:=RaemaTraducUtiliseTableau (65)+<>ZCR
	MotifErreur3:=""
	RapAffichePb ("Erreur de mail";"VERIFICATION DES SAISIES";MotifErreur1;MotifErreur2;MotifErreur3)
Else 
	If (YTesteValiditeCourriel ($ValeurAdresseCourrielA))
		If (Find in array:C230(TbNomsP5;"checkbox")>0)  // il a coché la case pour qu'on se rappelle son mail
			READ WRITE:C146([Personnes:12])
			QUERY:C277([Personnes:12];[Personnes:12]Identificateur:4=MotDePasseActuel)
			OB SET:C1220([Personnes:12]Arguments:7;"EmailRAEMA";$ValeurAdresseCourrielA)
			SAVE RECORD:C53([Personnes:12])
			ZAmnistiePartielle (->[Personnes:12])
		End if 
	End if 
	
	$NumRaema:=<>NumCampagneEnCoursSaisie
	$Objet:=RaemaTraducUtiliseTableau (57)+$NumRaema
	$Texte:=RaemaTraducUtiliseTableau (58)+<>ZCRWeb+RaemaTraducUtiliseTableau (59)+$NumRaema
	
	$Texte:=$Texte+<>ZCRWeb+RaemaTraducUtiliseTableau (60)+<>ZCRWeb+RaemaTraducUtiliseTableau (61)
	$Texte:=$Texte+<>ZCRWeb+RaemaTraducUtiliseTableau (62)
	$Texte:=$Texte+<>ZCRWeb+<>ZCRWeb+RaemaTraducUtiliseTableau (63)
	If (LangueCourante="F")
		$PS:="PS : Veuillez trouver en pièce-jointe le fichier des résultats que vous pouvez ouvrir "
		$PS:=$PS+"avec un tableur si vous le désirez (codage iso-latin 1)"
	Else 
		$PS:="Please find enclosed the results file (iso-latin 1 encoding). "
		$PS:=$PS+"You can, if you would like,  open it by using spreadsheet software (e.g. Excel)"
	End if 
	$Texte:=$Texte+<>ZCRWeb+<>ZCRWeb+$PS+<>ZCRWeb+<>ZCRWeb
	
	$CD:=Get 4D folder:C485(Dossier 4D actif:K5:10)+"Resume"+"_"+$NumRaema+"_"+NumLaboActuelA+".txt"
	If (Test path name:C476($CD)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CD)
	End if 
	USE CHARACTER SET:C205("ISO-8859-1";0)
	$Doc:=Create document:C266($CD)
	$UUID:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerUUID)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=<>NumCampagneEnCoursSaisie;*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=$UUID)
	$ResumeCampagne:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"RésuméRésultats";Est un texte:K8:3)
	SEND PACKET:C103($Doc;$ResumeCampagne)
	CLOSE DOCUMENT:C267($Doc)
	USE CHARACTER SET:C205(*;0)
	
	ASAPChercheDonneesCouriel 
	  // ZBlobVersVariable (->[XData]XBlob;->TbMailCopie;->VarSignatureCourriel;->TbMailRes;->TbMailAR;->TbMailMAJC;->TbMailEnvoi;->TbMailMAJL)
	
	  //$OK:=EnvoiMailDiscret ([XData]XTexte;"asa-spv@wanadoo.fr";$Texte;$ValeurAdresseCourrielA;->TbMailAR;$Objet;$CD)
	$OK:=EnvoiMailDiscretVintage ("smtp.orange.fr";"asa-spv@wanadoo.fr";$Texte;"asa.eloise@gmail.com";->TbMailAR;$Objet;$CD)
	SET TEXT TO PASTEBOARD:C523($Texte)
	  // ProcNom:=$ProcNom
	If ($OK)
		ResP4AROK 
		WebHistoireConnexion (NumLaboActuelA;4)
	Else 
		ResP4ARKO 
	End if 
End if 
