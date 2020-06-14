//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 10/05/12,
  // ----------------------------------------------------
  // Méthode : ZLBColonnesCharge
  // Description
  // Méthode remise au goût du jour : 
  //  le chargement se fait à partir de [XData]XObjet
  // Paramètres : {$1} = Pt sur Objet descripteur de la liste
  // ----------------------------------------------------
If (False:C215)  /// Structure de [XData]XObjet
	  // {
	  //  "NumTable": 2,
	  //  "Colonne1": {
	  //                "ColNom": "Nom",
	  //                "ColPtChamp": "->[XUtilisateurs]Nom",
	  //                "ColNumTable": 2,
	  //                "ColNumChamp": 2,
	  //                "ColPtVarET": "->tLB0",
	  //                "ColNomVarET": "tLB0",
	  //                "ColTaille": 120,
	  //                "ColTitre": "Nom"
	  //               },
	  //   "Colonne2": {
	  //                "ColNom": "Prenom",
	  //                "ColPtChamp": "->[XUtilisateurs]Prenom",
	  //                "ColNumTable": 2,
	  //                "ColNumChamp": 3,
	  //                "ColPtVarET": "->tLB2",
	  //                "ColNomVarET": "tLB2",
	  //                "ColTaille": 120,
	  //                "ColTitre": "Prenom"
	  //                }
	  //  }
End if 
  // Chargement du format de la LB


C_LONGINT:C283($Salé;$FT;$NumTable)
C_OBJECT:C1216($MonObjet;$ObjetColonne;ObTitreET)
C_POINTER:C301($PtChamp;$PtvariableCol)



  // Récupérons l'objet
If (Count parameters:C259=0)
	$MonObjet:=OB Copy:C1225([XData:1]XObjet:18)
Else 
	$MonObjet:=$1->
End if 



  // Fixons la table par défaut de la LB Sélection
If (GestionTableau=False:C215)
	LISTBOX SET TABLE SOURCE:C1013(*;ZNomListe;ZNumTable)
End if 

  // vidons la LB
$FT:=LISTBOX Get number of columns:C831(*;ZNomListe)
LISTBOX DELETE COLUMN:C830(*;ZNomListe;1;$FT)

  // cherchons le contenu de rang 1 de l'objet
OB GET PROPERTY NAMES:C1232($MonObjet;$TbNomX)
SORT ARRAY:C229($TbNomX;>)  // Permet d'insérer les colonnes dans le bon ordre

$FT:=Size of array:C274($TbNomX)
$Der:=1
ARRAY POINTER:C280(TbPtChampsSelection;0)
For ($Salé;1;$FT)
	If ($TbNomX{$Salé}="Colonne@")
		$ObjetColonne:=OB Get:C1224($MonObjet;$TbNomX{$Salé})
		$Pos:=$Der
		$NumTable:=OB Get:C1224($ObjetColonne;"ColNumTable";Est un entier long:K8:6)
		$NumChamp:=OB Get:C1224($ObjetColonne;"ColNumChamp";Est un entier long:K8:6)
		$PtChamp:=Field:C253($NumTable;$NumChamp)
		$NomCol:=Field name:C257($PtChamp)
		If (GestionTableau)
			$TypeChamp:=Type:C295($PtChamp->)
			$PtTableau:=Get pointer:C304("Tb"+String:C10($NumTable)+"_"+String:C10($NumChamp))
			Case of 
				: (($TypeChamp=Est un champ alpha:K8:1) | ($TypeChamp=Est un texte:K8:3))
					ARRAY TEXT:C222($PtTableau->;0)
					
				: ($TypeChamp=Est un numérique:K8:4)
					ARRAY REAL:C219($PtTableau->;0)
					
				: ($TypeChamp=Est un entier:K8:5)
					ARRAY INTEGER:C220($PtTableau->;0)
					
				: ($TypeChamp=Est un entier long:K8:6)
					ARRAY LONGINT:C221($PtTableau->;0)
					
				: ($TypeChamp=Est une date:K8:7)
					ARRAY DATE:C224($PtTableau->;0)
					
				: ($TypeChamp=Est une heure:K8:8)
					ARRAY TIME:C1223($PtTableau->;0)
					
				: ($TypeChamp=Est un booléen:K8:9)
					ARRAY BOOLEAN:C223($PtTableau->;0)
					
				: ($TypeChamp=Est une image:K8:10)
					ARRAY PICTURE:C279($PtTableau->;0)
					
			End case 
			APPEND TO ARRAY:C911(TbPtChampsSelection;$PtTableau)
			SELECTION TO ARRAY:C260($PtChamp->;$PtTableau->;*)
			$PtCol:=$PtTableau
		Else 
			$PtCol:=Field:C253($NumTable;$NumChamp)
		End if 
		$PtvariableCol:=Get pointer:C304(OB Get:C1224($ObjetColonne;"ColNomVarET";Est un texte:K8:3))
		$NomEnTête:=OB Get:C1224($ObjetColonne;"ColNom";Est un texte:K8:3)
		$VariableEntête:=Get pointer:C304(OB Get:C1224($ObjetColonne;"ColNomVarET";Est un texte:K8:3))
		LISTBOX INSERT COLUMN:C829(*;ZNomListe;$Pos;$NomCol;$PtCol->;$NomEnTête;$VariableEntête->)
		LISTBOX SET COLUMN WIDTH:C833($VariableEntête->;OB Get:C1224($ObjetColonne;"ColTaille"))
		
		$NonChampPerso:=ZLBCracheTitreColonne ($NumTable;$NumChamp)
		If ($NonChampPerso#"")
			OBJECT SET TITLE:C194($VariableEntête->;$NonChampPerso)
		Else 
			OBJECT SET TITLE:C194($VariableEntête->;OB Get:C1224($ObjetColonne;"ColTitre"))
		End if 
		
		$Der:=$Der+1
	End if 
End for 

  // gestion des numéro d'enregistrement dans le cas de la gestion des tableaux
If (GestionTableau)
	SELECTION TO ARRAY:C260
	LONGINT ARRAY FROM SELECTION:C647(ZPtTable->;TbNumEnr)
	$NomEnTête:="NumEnr"
	$NomCol:="TbNumEnr"
	$VariableEntête:=Get pointer:C304("tLB"+String:C10($Der))
	LISTBOX INSERT COLUMN:C829(*;ZNomListe;$Der;$NomCol;TbNumEnr;$NomEnTête;$VariableEntête->)
	LISTBOX SET COLUMN WIDTH:C833($VariableEntête->;50)
	
	OBJECT SET TITLE:C194($VariableEntête->;"NumEnr")
	OBJECT SET VISIBLE:C603(TbNumEnr;False:C215)
End if 