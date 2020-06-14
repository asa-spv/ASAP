//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 25/07/18, 05:07:43
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSchemaPUMCampagne
  // Description
  //  Sélectionne la campagne et affiche les germes correspondants

C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($VarBlodiboulga)

  // Recherche de la campagne
If (Size of array:C274(TbNR)>0)
	$CampagneCourante:=TbNR{TbNR}
	$RaemaPoudre:=($CampagneCourante#"@A")
	
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$CampagneCourante)
	  // Affichage des variables contenant les caractéritiques de la campagne
	VarDateDebCamp:=[RAEMACampagnes:20]DateEnvoiColis:3
	VarDateFinCamp:=[RAEMACampagnes:20]DateLimiteReponse:4
	VarDateWebCamp:=[RAEMACampagnes:20]DateMiseEnLigne:5
	VarNbreLabos:=[RAEMACampagnes:20]NbParticipants:6
	
	  // Constitution des tableaux de traduction des termes du site Web et de ses lignes <>TbN
	ARRAY TEXT:C222(TbTraducTableauF;0)
	ARRAY TEXT:C222(TbTraducTableauA;0)
	OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbF";TbTraducTableauF)
	OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbA";TbTraducTableauA)
	$FT:=Size of array:C274(TbTraducTableauF)
	ARRAY LONGINT:C221(TbTraducN;$FT)
	For ($Salé;1;$FT)
		TbTraducN{$Salé}:=$Salé
	End for 
	
	
	  // Les contaminations
	$VarBlodiboulga:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";Est un texte:K8:3)
	
	  // Constitution des tableaux des dilutions autorisée
	ARRAY TEXT:C222(TbDilution;0)
	OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbDilution";TbDilution)
	If ($RaemaPoudre)
		If (Size of array:C274(TbDilution)=0)
			COPY ARRAY:C226(<>TbDilution;TbDilution)
		End if 
	End if 
	OBJECT SET VISIBLE:C603(*;"gel@";($RaemaPoudre=False:C215))
	
	
	
	  // Recherche du rang et plaçage du menu local sur la bonne ligne
	TbRR:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Rang";Est un entier long:K8:6)-1
	
	
	
	  // Visiblité des éléments variables
	OBJECT SET VISIBLE:C603(*;"RPS@";(TbNR{TbNR}#"@A"))
	OBJECT SET VISIBLE:C603(*;"BouNumEchComp";(TbNR{TbNR}#"@A"))
	OBJECT SET VISIBLE:C603(*;"BouNomGermeComp";(TbNR{TbNR}="@A"))
	OBJECT SET VISIBLE:C603(*;"Gel@";(TbNR{TbNR}="@A"))
	
	OBJECT SET VISIBLE:C603(BouSupRAEMA;True:C214)  // Pour les tests
	
	  // Selection des germes
	RaemaSchemaAfficheGermes 
	
	OBJECT SET ENTERABLE:C238(TbNomGermeFr;False:C215)
	OBJECT SET ENTERABLE:C238(TbNomGermeEn;False:C215)
	
	OBJECT SET VISIBLE:C603(*;"Germe@";True:C214)
	OBJECT SET VISIBLE:C603(*;"Ligne@";False:C215)
	OBJECT SET VISIBLE:C603(*;"Valeur@";False:C215)
	
	$Campagne:=(TbNR{TbNR})
	$TT:=Size of array:C274(TbNomGermeFr)
	If ($TT>0)
		OBJECT SET VISIBLE:C603(*;"@Comp";True:C214)
		If ($Campagne#"@a")
			OBJECT SET VISIBLE:C603(*;"BouNomGermeComp";False:C215)
		End if 
	Else 
		OBJECT SET VISIBLE:C603(*;"@Comp";False:C215)
	End if 
	
	
End if 