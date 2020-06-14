//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 08/05/18, 08:35:45
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZLBSupprimeLB
  // Description
  // Méthode du bouton de suppression des Listes
  //

QUERY:C277([XData:1];[XData:1]XNom:2=ZNomListeXData;*)
QUERY:C277([XData:1]; & [XData:1]XAlpha:8#"Liste par défaut";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="LB"+ZNomTable)

If (Records in selection:C76([XData:1])=0)
	ALERT:C41("Il faut déjà créer une liste autre que Liste par défaut pour pouvoir la détruire…")
Else 
	$UUIDCourant:=TbUUIDFormatPossible{TbPUMFormatPossible}
	ZFenetreModaleAuCentre (635;450)
	DIALOG:C40("DlgLBSupprime")
	  // modifions le PUM en conséquence
	$FT:=ZLBFabriquePUMListes 
	$L:=Find in array:C230(TbUUIDFormatPossible;$UUIDCourant)
	If ($L<0)
		$L:=Find in array:C230(TbPUMFormatPossible;"Liste par défaut")
		QUERY:C277([XData:1];[XData:1]XNom:2=ZNomListeXData;*)
		QUERY:C277([XData:1]; & [XData:1]XAlpha:8="Liste par défaut";*)
		QUERY:C277([XData:1]; & [XData:1]XType:3="LB"+ZNomTable)
		ZLBColonnesCharge 
	End if 
	TbPUMFormatPossible:=$L
End if 