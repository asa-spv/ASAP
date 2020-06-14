//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/12/18, 17:51:54
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPImporteComSaisieRes
  // Description
  //   Méthode qui importe des commentaires des laboratoires 
  //   laissés lors de la saisie

C_LONGINT:C283($Salé;$FT)

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	If ($Ligne#"Commentaires")
		ALERT:C41("Désolé, ce fichier ne semble pas être un fichier d'exportation des commentaires laissés par le laboratoire lors de la saisie des résultats...")
	Else 
		READ WRITE:C146([WebConnexions:13])
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		Repeat 
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Type:=Substring:C12($Ligne;1;($Pos-1))  // $Type a le schéma "ComCampR125_63A"
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			$Pos:=Position:C15("_";$Type)
			$NumLaboN:=Num:C11(Substring:C12($Type;1;($Pos-1)))
			$L:=Find in array:C230(<>TbPerNumLaboRAEMA;$NumLaboN)
			If ($L<0)
				  // ALERTE("Je n'ai pas trouvé de laboratoire pour le n°"+Chaîne($NumLaboN))
			Else 
				$Identificateur:=<>TbPerIdentificateur{$L}
				$NumCampagne:=Substring:C12($Type;($Pos+1))
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$TexteCom:=Substring:C12($Ligne;1;($Pos-1))
				$TexteCom:=Replace string:C233($TexteCom;"£";<>ZCR)
				$Ligne:=Substring:C12($Ligne;($Pos+1))
				
				$TexteBrut:=$Ligne
				
				QUERY:C277([WebConnexions:13];[WebConnexions:13]CodeConnexion:4=$Identificateur;*)
				QUERY:C277([WebConnexions:13]; & [WebConnexions:13]Campagne:5=$NumCampagne;*)
				QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
				$FT:=Records in selection:C76([WebConnexions:13])
				ARRAY TEXT:C222($TbTexte;$FT)
				For ($Salé;1;$FT)
					$TbTexte{$Salé}:=$TexteCom
				End for 
				ARRAY TO SELECTION:C261($TbTexte;[WebConnexions:13]Commentaire:14)
			End if 
			
			RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		Until ($Ligne="Fin")
		ZAmnistiePartielle (->[WebConnexions:13])
	End if 
	CLOSE DOCUMENT:C267($Doc)
	ALERT:C41("Importation achevée")
End if 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : asa-spv
  // Date et heure : 01/02/19, 06:45:52
  // ----------------------------------------------------
  // Méthode : ASAPExporteComSaisieRes
  // Description
  // Exporte les [XDonnees] 
  //  contenant les commentaires laissés par les labos
  //  lors des saisies des résultats
  // ----------------------------------------------------
  //C_ENTIER LONG($Salé;1;$FT)
  //CHERCHER([XDonnees];[XDonnees]XType="ComCampR@")
  //$FT:=Enregistrements trouvés([XDonnees])
  //$Doc:=Créer document("")
  //Si (OK=1)
  //$Envoi:="Commentaires"+<>ZCR
  //ENVOYER PAQUET($Doc;$Envoi)
  //Boucle ($Salé;1;$FT)
  //$Sujet:=[XDonnees]XType+<>ZTab
  //ENVOYER PAQUET($Doc;$Sujet)
  //$Texte:=Remplacer chaîne([XDonnees]XTexte;<>ZCR;"£")
  //$Texte:=Remplacer chaîne($Texte;Caractère(10);"£")
  //$Texte:=Remplacer chaîne($Texte;<>ZTab;" ")+<>ZTab
  //ENVOYER PAQUET($Doc;$Texte)
  //$Texte:=Remplacer chaîne([XDonnees]XTexteSup;<>ZCR;"£")
  //$Texte:=Remplacer chaîne($Texte;Caractère(10);"£")
  //$Texte:=Remplacer chaîne($Texte;<>ZTab;" ")+<>ZCR
  //ENVOYER PAQUET($Doc;$Texte)
  //ENREGISTREMENT SUIVANT([XDonnees])
  //Fin de boucle 
  //$Envoi:="Fin"+<>ZCR
  //ENVOYER PAQUET($Doc;$Envoi)
  //Fin de si 
  //FERMER DOCUMENT($Doc)