//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/01/19, 06:13:12
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPImporteRetour
  // Description
  // Méthode qui importe les retours d'informations
  //   dans les tables [RetoursAdherents] et [RetoursFiches]
  //   à partir de l'export de GA mis en bas sous si(Faux)
  //   à recopier dans GestAsa

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"Retours")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux retours d'information")
	Else 
		READ WRITE:C146([RetoursAdherents:27])
		ALL RECORDS:C47([RetoursAdherents:27])
		DELETE SELECTION:C66([RetoursAdherents:27])
		
		READ WRITE:C146([RetoursFiches:24])
		ALL RECORDS:C47([RetoursFiches:24])
		DELETE SELECTION:C66([RetoursFiches:24])
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  // ET des tableaux
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		Repeat 
			ARRAY TEXT:C222($TbDescription;10)  // recueil des valeurs exportées
			$FT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$FT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$FT+1}:=Ligne
			CREATE RECORD:C68([RetoursFiches:24])
			[RetoursFiches:24]NumFiche:2:=$TbDescription{1}
			  // $TbDescription{2} = si # "-1" donne le n° de RAEMA du laboratoire
			[RetoursFiches:24]DateRetour:3:=Date:C102($TbDescription{3})
			[RetoursFiches:24]Appel:4:=($TbDescription{4}="VRAI")
			[RetoursFiches:24]TypeRetour:5:=$TbDescription{5}
			[RetoursFiches:24]Domaine:6:=$TbDescription{6}
			[RetoursFiches:24]Campagne:7:=$TbDescription{7}
			[RetoursFiches:24]Classification:8:=$TbDescription{8}
			[RetoursFiches:24]Motif:9:=Replace string:C233($TbDescription{9};"£";<>ZCR)
			[RetoursFiches:24]NumFTNC:10:=$TbDescription{10}
			SAVE RECORD:C53([RetoursFiches:24])
			If ($TbDescription{2}#"-1")  // Le laboratoire est repéré 
				$UUIDPersonne:=ASAPTrouveUUIDLaboParNumero (Num:C11($TbDescription{2}))
				If ($UUIDPersonne#"")
					CREATE RECORD:C68([RetoursAdherents:27])
					[RetoursAdherents:27]IDFiche:2:=[RetoursFiches:24]UUID:1
					[RetoursAdherents:27]IDAdherent:3:=$UUIDPersonne
					SAVE RECORD:C53([RetoursAdherents:27])
				End if 
			End if 
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		Until (Ligne="")
		CLOSE DOCUMENT:C267($Doc)
		
		If (Application type:C494=4D mode distant:K5:5)
			$Pr:=Execute on server:C373("ASAPFabRechercheRetourServeur";0)
		Else 
			ASAPFabRechercheRetourServeur 
		End if 
		
		
		ALERT:C41("Import achevé")
	End if 
End if 
