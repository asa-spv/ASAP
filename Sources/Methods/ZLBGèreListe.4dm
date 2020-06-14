//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/04/18, 05:36:49
  // ----------------------------------------------------
  // Méthode : ZLBGèreListe
  // Description
  //  Reprend le m^eme principe que ZGèreListeLB
  //. mais met tous les paramètres  dans un objet
  // Paramètre : $1 = Objet contenant les paramètres de la fonction
  // Contenu de l'objet : 
  //"Champ significatif" "Chemin logo" "Entrée" "Fiche" "Sortie" {"Gestion ensemble" "Méthode lapin" "Sur destruction"}    
  // ----------------------------------------------------

C_OBJECT:C1216($1;$Objet;ObTitreET)
$Objet:=$1

GestionFixe:=(OB Get:C1224($Objet;"Dialogue";Est un texte:K8:3)#"")

  // Allons chercher les réglages des noms d'ET de l'utilisateur
If (GestionFixe=False:C215)
	QUERY:C277([XData:1];[XData:1]XType:3="NomChampAfficheLB";*)
	QUERY:C277([XData:1]; & [XData:1]XNom:2="Nom des ET des ListBox pour "+<>ZQuiCode;*)
	QUERY:C277([XData:1]; & [XData:1]XAlpha:8=<>ZQuiCode)
	ObTitreET:=OB Copy:C1225([XData:1]XObjet:18)
End if 


ZPtChamp:=OB Get:C1224($Objet;"Champ significatif")
ZNumTable:=Table:C252(ZPtChamp)
ZPtTable:=Table:C252(ZNumTable)
ZNomChaDis:=Field name:C257(ZPtChamp)
ZNomTable:=Table name:C256(ZPtTable)
ZTypEns:=String:C10(Table:C252(ZPtTable))  // identifie par le numéro de fichier les ensembles crées
VarCDLogo:=OB Get:C1224($Objet;"Chemin logo")

ZNomListeXData:="LB "+ZNomTable+(Num:C11(Not:C34(<>ZToutNeuf))*<>ZQuiCode)

  // Formulaire de saisie
ZNomForEntrée:=OB Get:C1224($Objet;"Saisie";Est un texte:K8:3)
If (ZNomForEntrée="")
	ZNomForEntrée:="Entrée"
End if 

  // formulaire d'impression d'un enregistrement
ZNomForImpEnr:=OB Get:C1224($Objet;"Fiche";Est un texte:K8:3)
If (ZNomForImpEnr="")
	ZNomForImpEnr:="Entrée"
End if 

  // formulaire sortie
ZNomForSortie:=OB Get:C1224($Objet;"Sortie";Est un texte:K8:3)


ZAvantProc:=OB Get:C1224($Objet;"Avant";Est un texte:K8:3)  // Méthode à effectuer sur chargement
ZApresProc:=OB Get:C1224($Objet;"Après";Est un texte:K8:3)  // Méthode à effectuer sur validation
ZBoumProc:=OB Get:C1224($Objet;"Sur destruction";Est un texte:K8:3)  // Méthode à effectuer avant destruction
ZPtChampClefs:=OB Get:C1224($Objet;"Champ clefs";Est un pointeur:K8:14)  // Champ descriptif de l'enregistrement de [XUtilisateurs]

  // Gestion des méthodes lapin
ARRAY TEXT:C222(TbMethodeLapin;0)
$MethodeLapin:=OB Get:C1224($Objet;"Méthode lapin";Est un texte:K8:3)
If ($MethodeLapin#"")
	$Pos:=Position:C15(";";$MethodeLapin)
	If ($pos>0)
		Repeat 
			APPEND TO ARRAY:C911(TbMethodeLapin;Substring:C12($MethodeLapin;1;($Pos-1)))
			$MethodeLapin:=Substring:C12($MethodeLapin;($Pos+1))
			$Pos:=Position:C15(";";$MethodeLapin)
		Until ($Pos=0)
	End if 
	APPEND TO ARRAY:C911(TbMethodeLapin;$MethodeLapin)
End if 

  // gestion de la visibilité de la gestion des ensembles 
ZGereEnsemble:=OB Get:C1224($Objet;"Gestion ensemble";Est un booléen:K8:9)

  // gestion des droits
ZMAJPrivilèges (ZPtTable)

If (ZModif)
	READ WRITE:C146(ZPtTable->)
Else 
	READ ONLY:C145(ZPtTable->)
End if 

If (Records in selection:C76(ZPtTable->)=0)  //autant ne pas afficher une liste vide
	ALL RECORDS:C47(ZPtTable->)
End if 

ZNomEnsembleAvant:="Ceusses avant table "+ZNomTable
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)  //  crée l'ensemble des résultats de recherche

ZAjoutEnr:=False:C215  //  initialise le booléen d'ajout

FORM SET INPUT:C55(ZPtTable->;ZNomForEntrée)
GestionTableau:=OB Get:C1224($Objet;"Gestion tableaux";Est un booléen:K8:9)
If (GestionFixe)
	$Dialogue:=OB Get:C1224($Objet;"Dialogue";Est un texte:K8:3)
Else 
	$Dialogue:=(Num:C11(GestionTableau)*"LBTableaux")+(Num:C11(Not:C34(GestionTableau))*"LBSelection")
End if 
ZNomListe:=(Num:C11(GestionTableau)*"LB_Tableaux")+(Num:C11(Not:C34(GestionTableau))*"LB_Selection")
ZMethodeTableaux:=OB Get:C1224($Objet;"Méthode qui remplit les tableaux";Est un texte:K8:3)
ZSensDuTri:=OB Get:C1224($Objet;"Sens du tri";Est un texte:K8:3)
ZFenetreOuvertureStandard 
ZFenetreActualiseTitre 

DIALOG:C40($Dialogue)  // le format d'accueil doit être un formulaire projet
CLOSE WINDOW:C154
ZAmnistiePartielle (ZPtTable)

ZFini:=False:C215

