
C_OBJECT:C1216($MonObjet)
C_LONGINT:C283($Salé;$FT;$Pos;$Der;$NumTable;$NumChamp)
C_POINTER:C301($PtChamp;$PtvariableCol)
QUERY:C277([XData:1];[XData:1]XType:3="ObjetLB")
$MonObjet:=OB Copy:C1225([XData:1]XObjet:18)

LISTBOX SET TABLE SOURCE:C1013(*;"LB_Balance";OB Get:C1224($MonObjet;"NumTable";Est un entier long:K8:6))

OB GET PROPERTY NAMES:C1232($MonObjet;$TbNomX)
SORT ARRAY:C229($TbNomX;>)
  // vidons la LB
$FT:=LISTBOX Get number of columns:C831(*;"LB_Balance")
LISTBOX DELETE COLUMN:C830(*;"LB_Balance";1;$FT)

$FT:=Size of array:C274($TbNomX)
$Der:=1
For ($Salé;1;$FT)
	If ($TbNomX{$Salé}="Colonne@")
		$ObjetColonne:=OB Get:C1224($MonObjet;$TbNomX{$Salé})
		$Pos:=$Der
		$NumTable:=OB Get:C1224($ObjetColonne;"ColNumTable";Est un entier long:K8:6)
		$NumChamp:=OB Get:C1224($ObjetColonne;"ColNumChamp";Est un entier long:K8:6)
		$PtChamp:=Field:C253($NumTable;$NumChamp)
		$NomCol:=Field name:C257($PtChamp)
		$PtvariableCol:=Get pointer:C304(OB Get:C1224($ObjetColonne;"ColNomVarET";Est un texte:K8:3))
		$NomEnTête:=OB Get:C1224($ObjetColonne;"ColNom";Est un texte:K8:3)
		$VariableEntête:=Get pointer:C304(OB Get:C1224($ObjetColonne;"ColNomVarET";Est un texte:K8:3))
		LISTBOX INSERT COLUMN:C829(*;"Lb_Balance";$Pos;$NomCol;$PtChamp->;$NomEnTête;$VariableEntête->)
		LISTBOX SET COLUMN WIDTH:C833($VariableEntête->;OB Get:C1224($ObjetColonne;"ColTaille"))
		OBJECT SET TITLE:C194($VariableEntête->;OB Get:C1224($ObjetColonne;"ColTitre"))
		$Der:=$Der+1
	End if 
End for 
