//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/04/18, 11:44:56
  // ----------------------------------------------------
  // Méthode : ZLBModifierSelection
  // Description
  // Méthode qui s'applique à toute modification de sélection
  // dans le cadre d'une gestion LB Standard
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
			
		: ($vlChoixUtilisateur=2)  //  Choix utilisateur des sélectionnées
			ZLBUserSet 
			
		: ($vlChoixUtilisateur=3)  //  Choix utilisateur des non sélectionnées
			ZLBAntiUserSet 
			
		: ($vlChoixUtilisateur=4)  //  Ajouter à sélection
			ZLBAjoutASelection 
			
		: ($vlChoixUtilisateur=5)  //. Recherche standard
			ZBoutonListeRecherche 
			
		: ($vlChoixUtilisateur=6)  //  Oups
			ZLBOups 
	End case 
	If (GestionTableau)
		$NomLB:="Lb_Tableaux"
		If ($vlChoixUtilisateur#2) & ($vlChoixUtilisateur#3)
			EXECUTE METHOD:C1007(ZMethodeTableaux)
		End if 
	Else 
		$NomLB:="Lb_Selection"
		
	End if 
	LISTBOX SELECT ROW:C912(*;$NomLB;0;lk supprimer de sélection:K53:3)
	ZFenetreActualiseTitre 
End if 