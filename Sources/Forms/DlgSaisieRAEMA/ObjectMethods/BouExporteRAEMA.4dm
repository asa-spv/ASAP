  // Export du schéma du RAEMA
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/05/16, 06:37:56
  // ----------------------------------------------------
  // Méthode : DlgSaisieRAEMA.BouExporteRAEMA
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($FT;$Compteur)

SET CHANNEL:C77(12;"")  // OBLIGATOIRE car ENVOYER ENREGISTREMENT
If (OK=1)
	C_LONGINT:C283($NumTable)
	  // Export de la campagne
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=TbNR{TbNR})
	$NumTable:=Table:C252(->[RAEMACampagnes:20])
	SEND VARIABLE:C80($NumTable)  // n° de la table des [RAEMACampagnes]
	$NumCampagne:=TbNR{TbNR}
	SEND VARIABLE:C80($NumCampagne)  // n° de la campagne courante
	SEND RECORD:C78([RAEMACampagnes:20])  // le n° de la campagne
	RaemaSchemaExporteUneTable (->[RAEMAGermes:21]Identifiant:3)  // les [RAEMAGermes]
	RaemaSchemaExporteUneTable (->[RAEMALignes:22]Identifiant:3)  // les [RAEMALignes]
	RaemaSchemaExporteUneTable (->[RAEMAValeurs:23]Identifiant:3)  // les [RAEMAValeurs]
	$Envoi:="Fin"
	SEND VARIABLE:C80($Envoi)  // Tag [RAEMACampagnes]
	CLOSE WINDOW:C154
End if 
SET CHANNEL:C77(11)
ALERT:C41("Export achevé")
