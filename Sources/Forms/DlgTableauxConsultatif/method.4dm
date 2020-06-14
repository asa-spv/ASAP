$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		  // Ecriture du PumDomaine
		ARRAY TEXT:C222(PumDomaine;6)
		PumDomaine{1}:="Global"
		PumDomaine{2}:="Technique"
		PumDomaine{3}:="Administratif"
		PumDomaine{4}:="Qualité"
		PumDomaine{5}:="Informatique"
		PumDomaine{6}:="Statistique"
		PumDomaine:=1
		
		  // Initialisation des variables
		VarDateDebut:=Current date:C33-365
		VarDateFin:=Current date:C33
		VarTitre:="Tableau récapitulatif du Groupe Consultatif pour le domaine "+PumDomaine{PumDomaine}+" du "+String:C10(VarDateDebut)+" au "+String:C10(VarDateFin)
		
		
		
		RetourCalculTableauConsultatif (True:C214)
		
		
		
	: ($evt=Sur impression corps:K2:18)
		Case of 
			: (Contexte="Titre")
				SET PRINT MARKER:C709(Entête formulaire:K43:3;0)
				SET PRINT MARKER:C709(Pied de page formulaire:K43:2;28)
				
			: (Contexte="Tableaux")
				SET PRINT MARKER:C709(Entête formulaire:K43:3;54)
				SET PRINT MARKER:C709(Pied de page formulaire:K43:2;247)
				
		End case 
		
End case 