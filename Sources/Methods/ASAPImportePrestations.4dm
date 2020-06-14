//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/12/18, 17:51:54
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPImportePrestations
  // Description
  // 

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	If ($Ligne#"Code@")
		ALERT:C41("Désolé, ce fichier ne semble pas être un fichier d'exportation de prestations...")
	Else 
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		Repeat 
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Code:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Intitule:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$FacturationA:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$PrixA:=Substring:C12($Ligne;1;($Pos-1))
			$PrixN:=Num:C11($PrixA)
			
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$TVAA:=Substring:C12($Ligne;1;($Pos-1))
			$TVAN:=Num:C11($TVAA)
			
			$AnA:=Substring:C12($Ligne;($Pos+1))
			$AnN:=Num:C11($AnA)
			READ WRITE:C146([Prestations:26])
			QUERY:C277([Prestations:26];[Prestations:26]CodePrestation:2=$Code;*)
			QUERY:C277([Prestations:26]; & [Prestations:26]NomPrestation:3=$Intitule;*)
			QUERY:C277([Prestations:26]; & [Prestations:26]AnneePrestation:6=$AnN)
			If (Records in selection:C76([Prestations:26])=0)
				CREATE RECORD:C68([Prestations:26])
				[Prestations:26]CodePrestation:2:=$Code
				[Prestations:26]NomPrestation:3:=$Intitule
				[Prestations:26]AnneePrestation:6:=$AnN
			End if 
			[Prestations:26]TauxTVAPrestation:5:=$TVAN
			[Prestations:26]PrixPrestation:4:=$PrixN
			[Prestations:26]RAEMAPrestation:7:=($FacturationA="Vrai")
			SAVE RECORD:C53([Prestations:26])
			RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		Until ($Ligne="")
		ZAmnistiePartielle (->[Prestations:26])
	End if 
	CLOSE DOCUMENT:C267($Doc)
	ALERT:C41("Import des prestations terminé")
End if 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 19/06/18, 06:17:47
  // ----------------------------------------------------
  // Méthode : ASAPExportePrestations
  // Description
  // Méthode exportant les [Ventes] de GAv15 
  //  pour importation dans ASAP
  // ----------------------------------------------------

  //C_ENTIER LONG($Salé;$FT)
  //CHERCHER([XDonnées];[XDonnées]XType="prest")
  //SÉLECTION VERS TABLEAU([XDonnées]XAlpha;$TbCode\
;[XDonnées]XNom;$TbIntitule\
;[XDonnées]XBool;$TbFacRAEMA\
;[XDonnées]XValeur;$TbPrix\
;[XDonnées]XValeurSup;$TbTVA\
;[XDonnées]XEntier;$TbAnN)
  //$Doc:=Créer document("")
  //$FT:=Taille tableau($TbCode)
  //$Envoi:="Code"+<>ZTab+"Intitulé"+<>ZTab+"Facturation"+<>ZTab+"Prix"
  //$Envoi:=$Envoi+<>ZTab+"TVA"+<>ZTab+"Année"+<>ZCR
  //ENVOYER PAQUET($Doc;$Envoi)
  //Boucle ($Salé;1;$FT)
  //$Envoi:=$TbCode{$Salé}+<>ZTab+$TbIntitule{$Salé}+<>ZTab+Chaîne($TbFacRAEMA{$Salé})+<>ZTab+Chaîne($TbPrix{$Salé})
  //$Envoi:=$Envoi+<>ZTab+Chaîne($TbTVA{$Salé})+<>ZTab+Chaîne($TbAnN{$Salé})+<>ZCR
  //ENVOYER PAQUET($Doc;$Envoi)
  //Fin de boucle 
  //FERMER DOCUMENT($Doc)