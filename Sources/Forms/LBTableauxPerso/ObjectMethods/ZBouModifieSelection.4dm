
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/04/18, 11:44:56
  // ----------------------------------------------------
  // Méthode : MO du bouton  ZBouModifieSelection de [Personnes];"LBTableauxPerso"
  // Description
  // Méthode qui s'applique à toute modification de sélection
  // dans le cadre d'une gestion LB Standard des [Personnes]
  // ----------------------------------------------------

C_POINTER:C301(ZPtTable)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		$vtItems:="Tous;Fiches sélectionnées;Fiches non sélectionnées;Ajouter à sélection;Recherche standard;Reprendre sélection"
		
		GET MOUSE:C468($vlMouseX;$vlMouseY;$vlBouton)
		$vlChoixUtilisateur:=Pop up menu:C542($vtItems)
		
End case 

  //SUPPRIMER MESSAGES
  //  // SStockage des informations de ZGereListeLB
  //$ZPtTable:=ZPtTable
  //$ZPtChamp:=ZPtChamp

If (GestionTableau)
	CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
End if 
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)  // Utile en cas de gestion de liste pour  Ajouter à sélection
If ($vlChoixUtilisateur>0)
	If ($vlChoixUtilisateur#6)
		COPY NAMED SELECTION:C331(ZPtTable->;"ZNomSelectionAvant")
	End if 
	Case of 
		: ($vlChoixUtilisateur=1)  // Tous
			ZLBToutSelectionnerTable 
			ASAPPerFabriqueTb 
			
		: ($vlChoixUtilisateur=2)  //  Choix utilisateur des sélectionnées
			ZLBUserSet 
			
		: ($vlChoixUtilisateur=3)  //  Choix utilisateur des non sélectionnées
			ZLBAntiUserSet 
			
		: ($vlChoixUtilisateur=4)  //  Ajouter à sélection
			ZLBAjoutASelection 
			ASAPPerFabriqueTb 
			
		: ($vlChoixUtilisateur=5)  //. Recherche standard
			ASAPLaboRechercheStandard 
			ASAPPerFabriqueTb 
			
			
		: ($vlChoixUtilisateur=6)  //  Oups
			ZLBOups 
			ASAPPerFabriqueTb 
			
	End case 
	If (GestionTableau)
		CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
	End if 
	
	
	LISTBOX SELECT ROW:C912(*;"Lb_Tableaux";0;lk supprimer de sélection:K53:3)
	ZNbEnr:=Size of array:C274(TbPerNum)
	ZFenetreActualiseTitre 
End if 

