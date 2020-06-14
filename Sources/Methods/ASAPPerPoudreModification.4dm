//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/08/19, 17:37:17
  // ----------------------------------------------------
  // Méthode : ASAPPerPoudreModification
  // Description
  // Méthode générale qui entraîne les modifications  
  //  des [CampagneParticipations] par action sur 
  //  les objets de la page 3 (RAEMA) de [Personnes];"SaisieLabo"
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$T;$C)
C_TEXT:C284($NomVariable)

OnAChangéParticipation:=True:C214  // A priori changement dans les [CampagneParticipations]
  // Repérage de l'objet sollicité
$PtObjetCourant:=OBJECT Get pointer:C1124(Objet courant:K67:2)
RESOLVE POINTER:C394($PtObjetCourant;$NomVariable;$T;$C)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		Case of 
			: ($NomVariable="@AR")  // C'est le nombre de colis avec rapport
				ASAPPerPoudreModifColisSupAR 
				
			: ($NomVariable="@SR")  // C'est le nombre de colis sans rapport
				ASAPPerPoudreModifColisSupSR 
				
			: ($NomVariable="@Boite")  // C'est le rang du PUM des boîtes isothermes
				ASAPPerPoudreModifBoite 
				
			: ($NomVariable="@Transporteur")  // C'est le rang du PUM des boîtes isothermes
				ASAPPerPoudreModifTransporteur 
				
		End case 
		
		
	: ($evt=Sur clic:K2:4)  // les boîtes à cocher ne sont sensibles qu'au clic
		Case of 
			: ($NomVariable="@OK")  // C'est une boîte à cocher de participation
				ASAPPerPoudreModifParticipation 
				
			: ($NomVariable="@SP")  // C'est le rang du PUM des boîtes isothermes
				ASAPPerPoudreModifPathogene 
				
			: ($NomVariable="@Transporteur")  // C'est le rang du PUM des boîtes isothermes
				ASAPPerPoudreModifTransporteur 
				
			: ($NomVariable="@Boite")  // C'est le rang du PUM des boîtes isothermes
				ASAPPerPoudreModifBoite 
				
		End case 
		
End case 