//%attributes = {}
  //    ZNouveau  V11 du 15/08/2010
  //  script de BouAjouteEnr permet d'ajouter des fiches à la sélection
  // {$1} si "*" = avec transaction  si alpha=nom du format page
  // {$2} alpha=nom du format page si $1="*"
  //  utilise ZActualiseTitreFenetre
C_TEXT:C284($1;$2)
If (ZAjout)
	ZAjoutEnr:=True:C214  // permet un script plus parlant en FFSaisie
	$Transac:=False:C215
	If (Count parameters:C259>0)
		If ($1="*")
			$Transac:=True:C214
		Else 
			FORM SET INPUT:C55(ZPtTable->;$1)
		End if 
	End if 
	If (Count parameters:C259=2)
		FORM SET INPUT:C55(ZPtTable->;$2)
	End if 
	CREATE SET:C116(ZPtTable->;"SélectionEnCours")
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
	FORM SET INPUT:C55(ZPtTable->;ZNomForAffSai)
	ZAjoutEnr:=False:C215
	ZFenetreActualiseTitre 
Else 
	ALERT:C41("Désolé, vous ne pouvez pas saisir de nouvelle fiche")
End if 