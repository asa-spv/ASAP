
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/07/19, 07:04:58
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : LBTableauxPerso.ZBouAjouteEnr
  // Description  : Ajout d'un enregistrement de [Personnes]
  // 
If (Test semaphore:C652("Ajout personne"))
	ALERT:C41("Désolé, quelqu'un est en train d'ajouter une personne sur un autre poste...")
Else 
	  // Initialisation des Tb des n° d'adhérent et de labo
	ARRAY LONGINT:C221($TbNumPersonne;0)
	COPY ARRAY:C226(<>TbPerNumPersonne;$TbNumPersonne)
	SORT ARRAY:C229($TbNumPersonne;<)
	DerNumPersonne:=$TbNumPersonne{1}
	ARRAY LONGINT:C221($TbNumRAEMA;0)
	COPY ARRAY:C226(<>TbPerNumLaboRAEMA;$TbNumRAEMA)
	SORT ARRAY:C229($TbNumRAEMA;<)
	DerNumRAEMA:=$TbNumRAEMA{1}
	
	ZLBZNouveau ("*")
	
	CLEAR SEMAPHORE:C144("Ajout personne")
	ASAPFabriqueTbPersonnes 
	EXECUTE METHOD:C1007(ZMethodeTableaux)
End if 
