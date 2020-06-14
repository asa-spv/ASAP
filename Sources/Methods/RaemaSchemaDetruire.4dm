//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 28/07/18, 10:24:12
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSchemaDetruire
  // Description
  // // Permet de détruire un RAEMA affiché
  // devrait être réservé aux tests


CONFIRM:C162("Désirez-vous supprimer le questionnaire du RAEMA n°"+TbNR{TbNR})
If (OK=1)
	CONFIRM:C162("Désirez-vous VRAIMENT supprimer le questionnaire du RAEMA n°"+TbNR{TbNR})
	If (OK=1)
		READ WRITE:C146(*)
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=TbNR{TbNR})
		RELATE MANY:C262([RAEMACampagnes:20]UUID:1)  // Rappel des germes
		RELATE MANY SELECTION:C340([RAEMALignes:22]UUIDGerme:2)  // Rappel des lignes
		RELATE MANY SELECTION:C340([RAEMAValeurs:23]UUIDLigne:2)  // Rappel des valeurs
		DELETE SELECTION:C66([RAEMACampagnes:20])
		DELETE SELECTION:C66([RAEMAGermes:21])
		DELETE SELECTION:C66([RAEMALignes:22])
		DELETE SELECTION:C66([RAEMAValeurs:23])
		
		ZAmnistieInternationale 
		RaemaSchemaAffichePUMTbNR 
		TbNR:=1
		RaemaSchemaPUMCampagne 
	End if 
End if 