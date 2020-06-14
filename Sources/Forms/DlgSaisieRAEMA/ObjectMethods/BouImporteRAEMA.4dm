  // Import du schéma du RAEMA

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/05/16, 06:38:57
  // ----------------------------------------------------
  // Méthode : DlgSaisieRAEMA.BouImporteRAEMA
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($ReceptionN)
C_TEXT:C284($ReceptionA;$NumCampagne)
SET CHANNEL:C77(10;"")
If (OK=1)
	RECEIVE VARIABLE:C81($ReceptionN)  // Doit être le n° de la table [RAEMACampagnes] = 20
	If (Undefined:C82($ReceptionN)) | ($ReceptionN#Table:C252(->[RAEMACampagnes:20]))
		ALERT:C41("Désolé, le fichier sélectionné ne correspondent pas à un export d'une campagne")
	Else 
		RECEIVE VARIABLE:C81($NumCampagne)  // Le n° de la campagne à importer
		$OC:=True:C214  // A priori on va importer les données 
		  // Testons si une campagne de même n° existe
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
		If (Records in selection:C76([RAEMACampagnes:20])=1)
			CONFIRM:C162("La campagne "+$NumCampagne+" existe déjà : voulez-vous la remplacer ????";"Oui, c'est ça";"Absolument pas")
			If (OK=1)
				  // Supprimons toutes traces des enregistremens anétrieurs
				READ WRITE:C146(*)
				ZVerrouAttendre (->[RAEMACampagnes:20])
				DELETE RECORD:C58([RAEMACampagnes:20])
				$Test:=$NumCampagne+"@"
				QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$Test)
				DELETE SELECTION:C66([RAEMAGermes:21])
				QUERY:C277([RAEMALignes:22];[RAEMAGermes:21]Identifiant:3=$Test)
				DELETE SELECTION:C66([RAEMALignes:22])
				QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$Test)
				DELETE SELECTION:C66([RAEMAValeurs:23])
				ZAmnistieInternationale 
			End if 
			$OC:=(OK=1)
		End if 
		If ($OC)
			RECEIVE RECORD:C79([RAEMACampagnes:20])
			SAVE RECORD:C53([RAEMACampagnes:20])
			$NumTableA:=RaemaSchemaImporteUneTable 
			$NumTableA:=RaemaSchemaImporteUneTable ($NumTableA)
			$NumTableA:=RaemaSchemaImporteUneTable ($NumTableA)
			ALERT:C41("Récupération achevée")
			RaemaInitPUMCampagne 
			COPY ARRAY:C226(<>PUMCampagne;TbNR)
			TbNR:=Find in array:C230(TbNR;$NumCampagne)
			RaemaSchemaPUMCampagne 
		End if 
	End if 
Else 
	ALERT:C41("Bon, je ne fais rien")
End if 
SET CHANNEL:C77(11)

