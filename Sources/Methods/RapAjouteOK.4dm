//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/07/19, 15:59:34
  // ----------------------------------------------------
  // Méthode : RapAjouteOK
  // Description
  // Méthode qui teste l'ajoutabilité d'un laboratoire 
  //   dans le tableau des mails non envoyés
  // Paramètre : $1= n° de laboratoire à ajouter
  // ----------------------------------------------------
$Dem:=String:C10($1)
$DemN:=$1
$0:=False:C215
If (Find in array:C230(TbRapMailNonEnvoi;$DemN)>0)
	ALERT:C41("Le numéro "+$Dem+" existe déjà dans la liste...")
Else 
	  //FabriqueTableauCorrespondance 
	$L:=Find in array:C230(<>TbPerNumLaboRAEMA;$DemN)
	If ($L>0)
		$0:=True:C214
	Else 
		ALERT:C41("Le labo numéro "+$Dem+" n'existe pas dans la liste des laboratoires...")
	End if 
	
End if 