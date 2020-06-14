//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 03/05/18, 20:11:42
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZTacheDeFondAccomplir
  // Description
  //  teste et traite les [XTachesDeFond] non accomplies

  // TacheFond
$MachineOperante:=$1
  // TODO gestion des tâches de fond
C_POINTER:C301($PtOK)
C_LONGINT:C283($Table)


ARRAY TEXT:C222($TbNomMethodes;0)
METHOD GET NAMES:C1166($TbNomMethodes)
READ WRITE:C146([XTachesDeFond:10])
QUERY BY ATTRIBUTE:C1331([XTachesDeFond:10];[XTachesDeFond:10]ObjetTdF:2;"Accompli";=;False:C215;*)
QUERY BY ATTRIBUTE:C1331([XTachesDeFond:10]; & ;[XTachesDeFond:10]ObjetTdF:2;"Destinataire";=;$MachineOperante)
If (Records in selection:C76([XTachesDeFond:10])>0)
	  // TRACE
	ORDER BY:C49([XTachesDeFond:10];[XTachesDeFond:10]OrdrePassage:4;>)
	$Objet:=[XTachesDeFond:10]ObjetTdF:2
	$Méthode:=OB Get:C1224($Objet;"NomMéthode";Est un texte:K8:3)
	$NomVariableOK:=OB Get:C1224($Objet;"NomVariableOK";Est un texte:K8:3)
	If ($NomVariableOK#"")
		$PtOK:=Get pointer:C304($NomVariableOK)
	End if 
	$Table:=OB Get:C1224($Objet;"NumTable";Est un entier long:K8:6)
	$NumEnrOK:=OB Is defined:C1231($Objet;"NumEnr")
	$TbNumEnrOK:=OB Is defined:C1231($Objet;"TbNumEnrSélection")
	If (Find in array:C230($TbNomMethodes;$Méthode)>0)
		If ($Table>0)  // On applique la méthode sur une sélection
			If (Find in array:C230(<>TbNumChampTableBase;$Table)>0) & ($NumEnrOK | $TbNumEnrOK)
				$PtTable:=Table:C252($Table)
				If ($NumEnrOK)
					GOTO RECORD:C242($PtTable->;OB Get:C1224($Objet;"NumEnr";Est un entier long:K8:6))
				End if 
				If ($TbNumEnrOK)
					ARRAY LONGINT:C221($TbNumEnrSel;0)
					OB GET ARRAY:C1229($Objet;"TbNumEnrSélection";$TbNumEnrSel)
					CREATE SELECTION FROM ARRAY:C640($PtTable->;$TbNumEnrSel)
				End if 
			End if 
		End if 
		OB SET:C1220($Objet;"DateHeureDebutExécution";Current date:C33)  // La date et heure de début d'exécution
		EXECUTE METHOD:C1007($Méthode)
		OB SET:C1220($Objet;"DateHeureFinExécution";Current date:C33)  // La date et heure de fin d'exécution
		If ($NomVariableOK#"")
			OB SET:C1220($Objet;"Accompli";$PtOK->)  // Le caractère accompli est rendu par la variable process
		Else 
			OB SET:C1220($Objet;"Accompli";True:C214)  // On considère la tâche comme accomplie
		End if 
		[XTachesDeFond:10]ObjetTdF:2:=$Objet
		SAVE RECORD:C53([XTachesDeFond:10])
	Else 
		DELETE RECORD:C58([XTachesDeFond:10])
	End if 
End if 
ZAmnistieInternationale 
