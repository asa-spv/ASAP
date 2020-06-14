  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 30/07/17, 10:34:45
  // ----------------------------------------------------
  // Méthode : DlgTableauxRevDirection
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		  // Rempli l'en-tête (n°RAEMA)
		$RaemaEnCours:=RaemaTrouveNumCampagneParAn (Year of:C25(Current date:C33))
		VarNumRaema1:=String:C10(Num:C11($RaemaEnCours)-1)
		VarNumRaema2:=String:C10(Num:C11($RaemaEnCours)-2)
		VarNumRaema3:=String:C10(Num:C11($RaemaEnCours)-3)
		VarNumRaema4:=String:C10(Num:C11($RaemaEnCours)-4)
		ARRAY POINTER:C280(TbPointeur;4)
		TbPointeur{1}:=->VarNumRaema1
		TbPointeur{2}:=->VarNumRaema2
		TbPointeur{3}:=->VarNumRaema3
		TbPointeur{4}:=->VarNumRaema4
		
		VarTbRevDir1:="RAEMA "+VarNumRaema1+<>ZCR+"Dernière campagne n"
		VarTbRevDir2:="RAEMA "+VarNumRaema2+<>ZCR+"Campagne (n-1)"
		VarTbRevDir3:="RAEMA "+VarNumRaema3+<>ZCR+"Campagne (n-2)"
		VarTbRevDir4:="RAEMA "+VarNumRaema4+<>ZCR+"Campagne (n-3)"
		RadPoudre:=1
		
		  // Ecriture du PumDomaine
		ARRAY TEXT:C222(PumDomaine;6)
		PumDomaine{1}:="Global"
		PumDomaine{2}:="Technique"
		PumDomaine{3}:="Administratif"
		PumDomaine{4}:="Qualité"
		PumDomaine{5}:="Informatique"
		PumDomaine{6}:="Statistique"
		PumDomaine:=1
		
		RetourCalculTableauRevDir 
		  // Calcul du nombre de participant
		
		VarTitre:=""
		
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