
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/04/18, 15:04:00
  // ----------------------------------------------------
  // Méthode : ZLBGestionEnsembles
  // Description
  // Méthode qui s'applique à toute modification de sélection
  // par les ensembles dans le cadre d'une gestion LB Standard
  // ----------------------------------------------------
C_POINTER:C301(ZPtTable)
If (GestionTableau)
	CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
End if 
CUT NAMED SELECTION:C334(ZPtTable->;"ZNomSelectionAvant")
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)  // Utile en cas de gestion de liste pour  Ajouter à sélection
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		$vtItems:="Créer un ensemble;Supprimer un ensemble;Calcul sur ensemble;Appeler un ensemble;Reprendre sélection"
		
		GET MOUSE:C468($vlMouseX;$vlMouseY;$vlBouton)
		$vlChoixUtilisateur:=Pop up menu:C542($vtItems)
		
End case 

  //SUPPRIMER MESSAGES
  //  // SStockage des informations de ZGereListeLB
  //$ZPtTable:=ZPtTable
  //$ZPtChamp:=ZPtChamp
If ($vlChoixUtilisateur>0)
	Case of 
		: ($vlChoixUtilisateur=1)  // Créer un ensemble
			ZEnsembleZSauve 
			
		: ($vlChoixUtilisateur=2)  //  Supprimer un ensemble
			ZEnsembleSupprime 
			
		: ($vlChoixUtilisateur=3)  //  Calcul sur ensemble
			ZEnsembleAfficheCalcul 
			
		: ($vlChoixUtilisateur=4)  //  Appeler un ensemble
			ZEnsembleAppel 
			
		: ($vlChoixUtilisateur=5)  //  Oups
			ZLBOups 
	End case 
	
	ASAPPerFabriqueTb 
	ZNbEnr:=Size of array:C274(TbPerNum)
	
	LISTBOX SELECT ROW:C912(*;"Lb_Tableaux";0;lk supprimer de sélection:K53:3)
	ZFenetreActualiseTitre 
End if 