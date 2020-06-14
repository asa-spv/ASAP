//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 06/05/18, 13:22:12
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZNews_SupprimeAnciennes
  // Description
  //  

$n:=Records in set:C195("$ListboxSet0")
CONFIRM:C162("Voulez-vous réellement supprimer "+String:C10($n)+" New"+Choose:C955($n>1;"s";""))

If (OK=1)
	
	ARRAY BOOLEAN:C223($TbBool;0x0000)
	ARRAY BOOLEAN:C223($TbBoolSup;0x0000)
	C_LONGINT:C283($Salé)
	
	USE SET:C118("$ListboxSet0")
	SELECTION TO ARRAY:C260([XData:1]XBoolSup:15;$TbBoolSup;[XData:1]XBool:14;$TbBool)
	For ($Salé;1;Size of array:C274($TbBoolSup))
		$TbBoolSup{$Salé}:=True:C214
		$TbBool{$Salé}:=True:C214
	End for 
	ARRAY TO SELECTION:C261($TbBoolSup;[XData:1]XBoolSup:15;$TbBool;[XData:1]XBool:14)
	ZAmnistiePartielle (->[XData:1])
	
	OBJECT SET TITLE:C194(*;"BouToutVoirNews";"Tout voir")
	ZNews_ListeNews (True:C214)
End if 