//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/01/19, 09:58:31
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsImporteChamps
  // Description
  // Permet de transformer l'export de EPB en bilan annuel

C_LONGINT:C283($Salé;$Fumé;$Sec;$NbCompte)

USE CHARACTER SET:C205("Macintosh";1)
$Doc:=Open document:C264("";Mode lecture:K24:5)

ARRAY TEXT:C222($TbChampsIntitule;0)
ARRAY TEXT:C222($TbChampsTable;0)
ARRAY TEXT:C222($TbChampsContexte;0)
ARRAY TEXT:C222($TbChampsExpression;0)
READ WRITE:C146([XData:1])

RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
If ($Ligne="Import Champs pour Courriels@")
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
	For ($Salé;1;10000)
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
		APPEND TO ARRAY:C911($TbChampsIntitule;$ValeurA)
		
		$Ligne:=Substring:C12($Ligne;($Pos+1))
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
		APPEND TO ARRAY:C911($TbChampsTable;$ValeurA)
		
		$Ligne:=Substring:C12($Ligne;($Pos+1))
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$ValeurA:=Substring:C12($Ligne;1;($Pos-1))
		APPEND TO ARRAY:C911($TbChampsContexte;$ValeurA)
		
		$Ligne:=Substring:C12($Ligne;($Pos+1))
		APPEND TO ARRAY:C911($TbChampsExpression;$Ligne)
		
		
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		If ($Ligne="")
			$Salé:=10000
		End if 
	End for 
	
	QUERY:C277([XData:1];[XData:1]XNom:2="Champs pour Courriels-types";*)
	QUERY:C277([XData:1]; & [XData:1]XType:3="ChampsCourrielsTypes")
	If (Records in selection:C76([XData:1])=0)
		CREATE RECORD:C68([XData:1])
		[XData:1]XNom:2:="Champs pour Courriels-types"
		[XData:1]XType:3:="ChampsCourrielsTypes"
	End if 
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Intitulé";$TbChampsIntitule)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Table";$TbChampsTable)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Contexte";$TbChampsContexte)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Expression";$TbChampsExpression)
	SAVE RECORD:C53([XData:1])
End if 

ZAmnistieInternationale 
CLOSE DOCUMENT:C267($Doc)
USE CHARACTER SET:C205(*;1)