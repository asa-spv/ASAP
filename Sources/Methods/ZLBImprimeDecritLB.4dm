//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/03/18, 16:04:12
  // ----------------------------------------------------
  // Méthode : ZLBImprimeDecritLB
  // Description
  // Méthode projet qui décrit la ListBox dont le nom est passé en premier paramètre
  //.  Très largement piquée à Chrisitan SIMON
  // Paramètre : $1 = nom de la ListBox à imprimer
  // ----------------------------------------------------

C_TEXT:C284($1;$vLBNom)
$vLBNom:=$1

C_LONGINT:C283($Salé;$FT;$NbLignes)

ARRAY TEXT:C222($tColNom;0)
ARRAY TEXT:C222($tEntNom;0)
ARRAY POINTER:C280($tColVar;0)
ARRAY POINTER:C280($tEntVar;0)
ARRAY BOOLEAN:C223($tColVisible;0)
ARRAY POINTER:C280($tColStyle;0)
ARRAY TEXT:C222($tPPNom;0)
ARRAY POINTER:C280($tPPtVar;0)
LISTBOX GET ARRAYS:C832(*;$vLBNom;$tColNom;$tEntNom;$tColVar;$tEntVar;$tColVisible;$tColStyle;$tPPNom;$tPPtVar)

ARRAY OBJECT:C1221(TbObParam;0)
LISTBOX GET TABLE SOURCE:C1014(*;$vLBNom;$numTable)
INSERT IN ARRAY:C227(TbObParam;1;1)
If ($numTable>0)
	OB SET:C1220(TbObParam{1};"LBSource";$numTable)
End if 

  // Adjustement de la largeur PUM PUMLBChoixLargeur sur PUMLBChoixLargeur{1} = "Imprimer toutes les colonnes sur une seule page"
If (PUMLBChoixLargeur=1)
	OB SET:C1220(TbObParam{1};"AjusteLargeur";True:C214)
End if 

  // PUMLBChoixET permet de copier ou non les ET de colonne sur toutes les pages (1), sur aucune page (2), sur la première page(3)
OB SET:C1220(TbObParam{1};"Entete";PUMLBChoixET)


  // VarThermoCoeff est un thermomètre pour régler le % de la largeur d'impression
If (PUMLBChoixLargeur=3)
	OB SET:C1220(TbObParam{1};"coeffL";(bThermoCoeff/100))
End if 

$FT:=Size of array:C274($tColVar)
For ($Salé;1;$FT)
	If (OBJECT Get visible:C1075(*;$tColNom{$Salé})=True:C214)
		$NbLignes:=Size of array:C274(TbObParam)+1
		INSERT IN ARRAY:C227(TbObParam;$NbLignes;1)
		OB SET:C1220(TbObParam{$NbLignes};"colNom";$tColNom{$Salé};"colVar";$tColVar{$Salé};"entNom";$tEntNom{$Salé};"PPNom";$tPPNom{$Salé})
		OB SET:C1220(TbObParam{$NbLignes};"colSize";LISTBOX Get column width:C834(*;$tColNom{$Salé}))
		OB SET:C1220(TbObParam{$NbLignes};"colTitre";OBJECT Get title:C1068(*;$tEntNom{$Salé}))
		If (Is nil pointer:C315($tColVar{$Salé}))
			$Formula:=LISTBOX Get column formula:C1202(*;$tColNom{$Salé})
			OB SET:C1220(TbObParam{$NbLignes};"colFormule";$Formula)
			OB SET:C1220(TbObParam{$NbLignes};"colType";Est un texte:K8:3)
		End if 
	End if 
End for 

