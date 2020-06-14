//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/06/18, 19:26:42
  // ----------------------------------------------------
  // Méthode : ASAPImporteDevisRaemaGel
  // Description
  // méthode pour récupérer les [XDonnees] de Biblio
  //  incluant les connexions Web de réponse des laboratoires
  // ----------------------------------------------------


C_TEXT:C284($Var;$NumLaboA)
C_DATE:C307($Date)
C_BOOLEAN:C305($Bool)
C_TIME:C306($Heure)
C_LONGINT:C283($NumLaboN)
C_BLOB:C604($Blob)
C_REAL:C285($Valeur)

  // SUSPENDRE INDEX([XData])


SET CHANNEL:C77(13;"")
If (OK=1)
	
	RECEIVE VARIABLE:C81($Var)  // devisraemagel
	If ($Var#"devisraemagel")
		ALERT:C41("Désolé, ce fichier ne semble pas être un export de devis pour le RAEMA gel")
	Else 
		READ WRITE:C146([XData:1])
		QUERY:C277([XData:1];[XData:1]XType:3="DemDev")
		DELETE SELECTION:C66([XData:1])
		
		RECEIVE VARIABLE:C81($Var)  // Une autre
		While ($Var="Une autre")
			CREATE RECORD:C68([XData:1])
			[XData:1]XType:3:="DemDev"
			
			RECEIVE VARIABLE:C81($Var)  // Nom du laboratoire
			[XData:1]XNom:2:=$Var
			
			RECEIVE VARIABLE:C81($Date)  // Date du devis
			[XData:1]XDate:4:=$Date  //$Date:=[XDonnées]XDate
			
			
			RECEIVE VARIABLE:C81($Heure)  // Heure du devis
			[XData:1]XHeure:5:=$Heure  //$Heure:=[XDonnées]XHeure
			
			
			RECEIVE VARIABLE:C81($Bool)  // Booléen de validation
			[XData:1]XBool:14:=$Bool  //$Heure:=[XDonnées]XHeure
			
			RECEIVE VARIABLE:C81($NumLaboN)  // N° du laboratoire (numérique)
			[XData:1]XTexte:9:=ASAPTrouveUUIDLaboParNumero ($NumLaboN)  //$NumRaema:=[XDonnées]XEntier
			  //ENVOYER VARIABLE($NumRaema)
			
			RECEIVE VARIABLE:C81($Blob)  // N° du laboratoire (numérique)
			[XData:1]XBlob:13:=$Blob  //$Blob:=[XDonnées]XBlob
			  //ENVOYER VARIABLE($Blob)
			
			RECEIVE VARIABLE:C81($Var)  // Caducité
			[XData:1]XAlpha:8:=$Var  //$Envoi:=[XDonnées]XAlpha
			
			
			RECEIVE VARIABLE:C81($Valeur)  // An Concerné
			[XData:1]XValeur:7:=$Valeur  //$Envoi:=[XDonnées]XAlpha
			
			SAVE RECORD:C53([XData:1])
			
			RECEIVE VARIABLE:C81($Var)  // encore ou fin
		End while 
		SET CHANNEL:C77(11)
	End if 
	ALERT:C41("Import des devis RAEMA gel achevé")
End if 
  // RÉACTIVER INDEX([XData])
ZAmnistieInternationale 


  // Méthode d'origine dans GestAsa

  // ----------------------------------------------------
  // Nom utilisateur (OS) : asa-spv
  // Date et heure : 24/11/19, 08:25:24
  // ----------------------------------------------------
  // Méthode : ASAPExporteDevisRaemaGel
  // Description
  // Méthode qui exporte les [XDonnées]
  //  contenant les devis RAEMA gel
  // ----------------------------------------------------
  //C_ENTIER LONG($Salé;$FT;$NumRaema;$AnConcerné)
  //C_DATE($Date)
  //C_HEURE($Heure)
  //C_BOOLÉEN($Bool)
  //C_BLOB($Blob)

  //CHERCHER([XDonnées];[XDonnées]XType="DemDev")  // Type des devis RAEMA gel
  //RÉGLER SÉRIE(12;"")
  //$Envoi:="devisraemagel"
  //ENVOYER VARIABLE($Envoi)
  //$FT:=Enregistrements trouvés([XDonnées])
  //Boucle ($Salé;1;$FT)
  //$Envoi:="Une autre"
  //ENVOYER VARIABLE($Envoi)

  //$NomLabo:=[XDonnées]XNom
  //ENVOYER VARIABLE($NomLabo)

  //$Date:=[XDonnées]XDate
  //ENVOYER VARIABLE($Date)

  //$Heure:=[XDonnées]XHeure
  //ENVOYER VARIABLE($Heure)

  //$Bool:=[XDonnées]XBool
  //ENVOYER VARIABLE($Bool)

  //$NumRaema:=[XDonnées]XEntier
  //ENVOYER VARIABLE($NumRaema)

  //$Blob:=[XDonnées]XBlob
  //ENVOYER VARIABLE($Blob)

  //$Envoi:=[XDonnées]XAlpha
  //ENVOYER VARIABLE($Blob)

  //$AnConcerné:=[XDonnées]XValeur
  //ENVOYER VARIABLE($AnConcerné)

  //ENREGISTREMENT SUIVANT([XDonnées])
  //Fin de boucle 
  //$Envoi:="Fin"
  //ENVOYER VARIABLE($Envoi)
  //RÉGLER SÉRIE(11)
  //ALERTE("Export achevé")



