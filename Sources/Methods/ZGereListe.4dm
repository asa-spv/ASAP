//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 07:58:43
  // ----------------------------------------------------
  // Méthode : ZGereListe
  // Description
  // // Historique : ZGèreListe V11 du 14/08/2010
  //   Procédure globale qui permet de piloter l'utilisateur
  //    suppose que les formats $2 & $3 possèdent les boutons voulus
  //    et la variable VarNbFic dans l'en-tête qui sert à dénombrer les fiches
  //
  // Paramètres :  
  // $1= pointeur sur la table de travail
  // $2 = Pt de le champ expressif    
  // $3= nom du formulaire projet support, "" si non
  // Formulaires listes $4=liste d'affichage, $5= impression en liste,  $6 = liste visu
  // Formulaires détaillés $7= saisie, $8= impression en page, $9 = visu en page
  // $10= procédure à effectuer avant une destruction, "" sinon
  // ----------------------------------------------------


C_TEXT:C284($3;$4;$5;$6;$7;$8;$9)  // noms des formats ou des méthode
C_LONGINT:C283(ZNumTable;$ZNbEnr)
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
ZNumTable:=Table:C252($1)
ZPtTable:=Table:C252(ZNumTable)
ZPtChamp:=$1
ZNomChaDis:=Field name:C257(ZPtChamp)
ZNomTable:=Table name:C256(ZPtTable)
ZTypEns:=String:C10(Table:C252(ZPtTable))  // identifie par le numéro de fichier les ensembles crées

ZMAJPrivilèges (ZPtTable)

If (ZModif)
	READ WRITE:C146(ZPtTable->)
Else 
	READ ONLY:C145(ZPtTable->)
End if 
$ZNbEnr:=Records in selection:C76(ZPtTable->)

If ($ZNbEnr=0)  //autant ne pas afficher une liste vide
	ALL RECORDS:C47(ZPtTable->)
	$ZNbEnr:=Records in table:C83(ZPtTable->)
End if 

ZNomEnsembleAvant:="Ceusses avant table "+ZNomTable
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)
  //  crée l'ensemble des résultats de recherche
ZAjoutEnr:=False:C215  //  initialise le booléen d'ajout
ZFenetreOuvertureStandard 
ZFenetreActualiseTitre 

CREATE EMPTY SET:C140(ZPtTable->;"UserSet")
CREATE EMPTY SET:C140(ZPtTable->;"LockedSet")
  // l'ensemble de la sélection avant modification
ZNomEnsembleAvant:="Ceusses avant table "+ZNomTable
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)
Case of 
	: (Count parameters:C259>3)  //  loock cgm
		
		ZNomForSortie:=$3  // formulaire sortie
		ZNomForImpLis:=$4  // formulaire impression liste
		ZNomForVisLis:=$5  // formulaire de Visu liste
		ZNomForEntrée:=$6  // formulaire entrée
		ZNomForImpEnr:=$7  // formulaire impression complète
		ZNomForEntVis:=$8  // formulaire de Visu complet
		ZBoumProc:=$9  // Méthode à effectuer avant destruction
		ZAvantProc:=""
		ZApresProc:=""
		If (Count parameters:C259=11)
			ZApresProc:=$11
		End if 
		If (Count parameters:C259=11)
			ZAvantProc:=$10
		End if 
		
		ZNomForAffLis:=ZNomForSortie  // formulaire entrée
		ZNomForAffSai:=ZNomForEntrée  // formulaire entrée
		FORM SET OUTPUT:C54(ZPtTable->;ZNomForSortie)
		FORM SET INPUT:C55(ZPtTable->;ZNomForEntrée)
		
		  //Repeter 
		If (ZModif) & ($2)
			READ WRITE:C146(ZPtTable->)
			MODIFY SELECTION:C204(ZPtTable->;*)  //permet par double-clic de modifier l'enregistrement
		Else 
			READ ONLY:C145(ZPtTable->)
			DISPLAY SELECTION:C59(ZPtTable->;*)  //permet par double-clic de visualiser l'enregistrement
		End if 
		
	: (Count parameters:C259=3)  //  loock Liste hiérarchique
		DIALOG:C40($3)  // le format d'accueil doit être un formulaire projet
		
	Else   //  look Casa
		ZNomForImpLis:="ListImp"
		ZNomForImpFic:="FichImp"
		ZNomForAffLis:="Liste"
		ZNomForSortie:=ZNomForAffLis  // formulaire sortie
		ZNomForAffSai:="Saisie"
		ZNomForEntrée:=ZNomForAffSai  // formulaire entrée
		ZNomForEntVis:="ListeVisu"
		FORM SET OUTPUT:C54(ZPtTable->;"Sortie")
		FORM SET INPUT:C55(ZPtTable->;"Saisie")
		If (ZModif)
			MODIFY SELECTION:C204(ZPtTable->;*)  //permet par double-clic de modifier l'enregistrement
		Else 
			DISPLAY SELECTION:C59(ZPtTable->;*)  //permet par double-clic de visualiser l'enregistrement
		End if 
		
End case 
CLOSE WINDOW:C154
ZFini:=False:C215
