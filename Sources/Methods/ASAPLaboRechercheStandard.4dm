//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/01/19, 20:09:33
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPLaboRechercheStandard
  // Description
  // Méthode qui recherche les laboratoires selon une recherche ASAP


$F:=Open form window:C675("DlgRecherchePerso")
DIALOG:C40("DlgRecherchePerso")
CLOSE WINDOW:C154
If (Records in selection:C76([Personnes:12])=0)
	CONFIRM:C162("Aucune fiche trouvée: je reprends la sélection précédente ??")
	If (OK=1)
		USE NAMED SELECTION:C332("ZNomSelectionAvant")
	End if 
End if 
