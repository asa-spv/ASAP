//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/11/19, 07:01:59
  // ----------------------------------------------------
  // Méthode : ASAPImportationGlobale2
  // Description
  // Méthode qui importe les données 
  //   en provenance de GestAsa et de Biblio
  // ----------------------------------------------------
$OC:=True:C214
ALL RECORDS:C47([Personnes:12])
If (Records in selection:C76([Personnes:12])=0)
	ALERT:C41("Désolé, il faut exécuter la méthode ASAPImportationGlobale1 avant ASAPImportationGlobale2")
	$OC:=False:C215
End if 
If ($OC)
	CONFIRM:C162("Importer le fichier des participations")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteParticipations 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier des RAEMA gel")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteRAEMAGel 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier des connexions Web")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteConnexions 
	Else 
		ASAPViderBase 
	End if 
End if 

If ($OC)
	CONFIRM:C162("Importer le fichier des demandes de devis RAEMA gel")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteDevisRaemaGel 
	Else 
		ASAPViderBase 
	End if 
End if 


If ($OC)
	CONFIRM:C162("Importer le fichier des commentaires des internautes")
	$OC:=(OK=1)
	If ($OC)
		ASAPImporteComSaisieRes 
	Else 
		ASAPViderBase 
	End if 
End if 


If ($OC)
	ALERT:C41("Importations achevées")
Else 
	ALERT:C41("Importation échouée : recommencez avec des données vides")
End if 
CONFIRM:C162("Voulez-vous lancer la vérification de cohérence ?")
If (OK=1)
	ASAPImportationVerifieCoherence 
End if 
