//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 08:55:33
  // ----------------------------------------------------
  // Méthode : ZBoutonListeRecherche
  // Description
  //  Historique : ZTestRecherche  V11 du 15/08/2010
  //  Méthode projet de recherche des enregistrements sur la totalité de la table
  //  qui avertit l'utilisateur si la recherche est infructueuse  
  // ----------------------------------------------------

CUT NAMED SELECTION:C334(ZPtTable->;"Ceusses Avant")
QUERY:C277(ZPtTable->)
If (Records in selection:C76(ZPtTable->)=0)
	CONFIRM:C162("Aucune fiche trouvée: je reprends la sélection précédente ??")
	If (OK=1)
		USE NAMED SELECTION:C332("Ceusses Avant")
	End if 
End if 
