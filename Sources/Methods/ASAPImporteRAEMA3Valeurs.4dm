//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 10:20:33
  // ----------------------------------------------------
  // Méthode : ASAPImporteRAEMAValeurs
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------


$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"ExportValeurs@")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux valeurs possibles des lignes du RAEMA")
	Else 
		READ WRITE:C146([RAEMAValeurs:23])
		ALL RECORDS:C47([RAEMAValeurs:23])
		DELETE SELECTION:C66([RAEMAValeurs:23])
		SELECTION TO ARRAY:C260([RAEMALignes:22]Identifiant:3;$TbIdentifiantLigne;[RAEMALignes:22]UUID:1;$TbUUIDLigne)
		$Pos:=Position:C15("_";Ligne)
		$TT:=Num:C11(Substring:C12(Ligne;($Pos+1)))
		
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		Repeat 
			ARRAY TEXT:C222($TbDescription;$TT)  // recueil des valeurs exportées
			$FT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$FT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$FT+1}:=Ligne
			
			$LienLigne:=$TbDescription{5}
			QUERY BY ATTRIBUTE:C1331([RAEMALignes:22];[RAEMALignes:22]Arguments:6;"IDLigne";=;$LienLigne)
			  // $IdentifiantValeur:=$TbDescription{7}
			  //$IdentifiantLigne:=Sous chaîne($IdentifiantValeur;1;(Longueur($IdentifiantValeur)-2))
			
			$IdentifiantValeur:=[RAEMALignes:22]Identifiant:3+String:C10(Num:C11($TbDescription{2});"00")
			$UUIDLigne:=[RAEMALignes:22]UUID:1
			If ($UUIDLigne#"")
				QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$IdentifiantValeur)
				If (Records in selection:C76([RAEMAValeurs:23])=0)
					CREATE RECORD:C68([RAEMAValeurs:23])
					[RAEMAValeurs:23]UUIDLigne:2:=$UUIDLigne
					[RAEMAValeurs:23]Identifiant:3:=$IdentifiantValeur
				End if 
				[RAEMAValeurs:23]NomFr:4:=$TbDescription{1}
				[RAEMAValeurs:23]NomEn:5:=$TbDescription{4}
				  // renseignement de [RAEMAValeurs]Arguments
				OB SET:C1220([RAEMAValeurs:23]Arguments:6;"IDValeur";$TbDescription{6})
				If ($TbDescription{3}="VRAI")  // Précision
					OB SET:C1220([RAEMAValeurs:23]Arguments:6;"Précision";True:C214)
				End if 
				SAVE RECORD:C53([RAEMAValeurs:23])
			End if 
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		Until (Ligne="")
		CLOSE DOCUMENT:C267($Doc)
	End if 
End if 
ZAmnistieInternationale 
ALERT:C41("Import des valeurs achevé...")
