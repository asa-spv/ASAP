//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 10/05/12, 10:25:53
  // ----------------------------------------------------
  // Méthode : ZNouveauLB
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
  //  script de BouAjouteEnr permet d'ajouter des fiches à la sélection
  //  si {$1} = avec transaction 
  //  utilise ZActualiseTitreFenetre

C_BOOLEAN:C305($Transac)

If (ZAjout)
	ZAjoutEnr:=True:C214  // permet un script plus parlant en FFSaisie
	If (GestionTableau)
		CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
	End if 
	CREATE SET:C116(ZPtTable->;"SélectionEnCours")
	
	If (Count parameters:C259>0)
		$Transac:=True:C214
	Else 
		$Transac:=False:C215
	End if 
	
	Repeat 
		If ($Transac)
			START TRANSACTION:C239
		End if 
		ADD RECORD:C56(ZPtTable->;*)
		If ($Transac)
			If (OK=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
		End if 
		ADD TO SET:C119(ZPtTable->;"SélectionEnCours")
	Until (OK=0)
	
	USE SET:C118("SélectionEnCours")
	CLEAR SET:C117("SélectionEnCours")
	ZAjoutEnr:=False:C215
	
	ZFenetreActualiseTitre 
	
Else 
	ALERT:C41("Désolé, vous ne pouvez pas saisir de nouvelle fiche")
End if 