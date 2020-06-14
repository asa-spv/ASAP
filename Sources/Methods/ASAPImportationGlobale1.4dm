//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/11/19, 07:01:59
  // ----------------------------------------------------
  // Méthode : ASAPImportationGlobale1
  // Description
  // Méthode qui importe les données 
  //   en provenance de GestAsa et de Biblio
  // ----------------------------------------------------


CONFIRM:C162("Importer le fichier d'exportation des poudres avec rapport")
$OC:=(OK=1)
If ($OC)
	ASAPImportePoudresSupAR 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier des adhérents")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteAdherents 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier des factures")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteFactures 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier des prestations")
	$OC:=(OK=1)
	If ($OC)
		ASAPImportePrestations 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier des ventes")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteVentes 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier RAEMA1")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteRAEMA1Descriptif 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier RAEMA2")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteRAEMA2Lignes 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier RAEMA3")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteRAEMA3Valeurs 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier RAEMA4")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteRAEMA4ValeursSup 
	Else 
		ASAPViderBase 
	End if 
End if 

CONFIRM:C162("La première partie des données est importée : voulez-vous redémarrer pour actualiser les tableaux généraux ?")
If (OK=1)
	RESTART 4D:C1292
End if 
