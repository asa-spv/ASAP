//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 10:20:33
  // ----------------------------------------------------
  // Méthode : ASAPImporteRAEMA2Lignes
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"ExportRAEMA@")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux lignes du RAEMA")
	Else 
		READ WRITE:C146([RAEMALignes:22])
		ALL RECORDS:C47([RAEMALignes:22])
		DELETE SELECTION:C66([RAEMALignes:22])
		
		
		READ WRITE:C146([RAEMAGermes:21])
		ALL RECORDS:C47([RAEMAGermes:21])
		  //SUPPRIMER SÉLECTION([RAEMAGermes])
		
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
			
			
			QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$TbDescription{1})
			If (Records in selection:C76([RAEMACampagnes:20])=1)
				$NumCampagne:=$TbDescription{1}
				$Page:=(Num:C11(Length:C16($TbDescription{2})=1)*"0")+$TbDescription{2}
				$Rang:=(Num:C11(Length:C16($TbDescription{5})=1)*"0")+$TbDescription{5}
				
				  // traitement de [RAEMAGermes]
				QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$NumCampagne+$Page)
				If (Records in selection:C76([RAEMAGermes:21])=0)
					CREATE RECORD:C68([RAEMAGermes:21])
					[RAEMAGermes:21]UUIDCampagne:2:=[RAEMACampagnes:20]UUID:1
					[RAEMAGermes:21]Identifiant:3:=$NumCampagne+$Page
					SAVE RECORD:C53([RAEMAGermes:21])
				End if 
				If ($TbDescription{5}="0")  // C'est un germe
					[RAEMAGermes:21]NomFr:4:=$TbDescription{3}
					[RAEMAGermes:21]NomEn:5:=$TbDescription{9}
					SAVE RECORD:C53([RAEMAGermes:21])
				End if 
				
				
				
				If ($TbDescription{5}#"0")  // C'est une ligne
					$IdLigne:=$NumCampagne+$Page+$Rang
					QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=$IdLigne)
					If (Records in selection:C76([RAEMALignes:22])=0)
						CREATE RECORD:C68([RAEMALignes:22])
						[RAEMALignes:22]Identifiant:3:=$IdLigne
					End if 
					[RAEMALignes:22]UUIDGerme:2:=[RAEMAGermes:21]UUID:1
					[RAEMALignes:22]NomFr:4:=$TbDescription{3}
					[RAEMALignes:22]NomEn:5:=$TbDescription{9}
					
					  // renseignement de [RAEMALignes]Arguments
					
					If ($TbDescription{7}="VRAI")  // Choix multiple
						OB SET:C1220([RAEMALignes:22]Arguments:6;"ChoixMultiple";True:C214)
					End if 
					
					If ($TbDescription{10}="VRAI")  // Escamotable
						OB SET:C1220([RAEMALignes:22]Arguments:6;"Escamotable";True:C214)
					End if 
					
					Case of 
						: ($TbDescription{3}="Nature@")  // Nature de la ligne (fabricant ou milieu)
							OB SET:C1220([RAEMALignes:22]Arguments:6;"Nature";"Milieu")
							
						: ($TbDescription{3}="@Fabrican@")  // Nature de la ligne (fabricant ou milieu)
							OB SET:C1220([RAEMALignes:22]Arguments:6;"Nature";"Fabricant")
							
					End case 
					
					OB SET:C1220([RAEMALignes:22]Arguments:6;"IDLigne";$TbDescription{4})  // l'ID fait le lien avec [RAEMAValeurs]
					
					SAVE RECORD:C53([RAEMALignes:22])
					
					
				End if 
			Else 
				
			End if 
			
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		Until (Ligne="")
		CLOSE DOCUMENT:C267($Doc)
		ALERT:C41("Import achevé")
	End if 
End if 
ZAmnistieInternationale 