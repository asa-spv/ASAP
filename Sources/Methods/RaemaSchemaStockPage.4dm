//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/18, 20:19:49
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : StockPageRaema
  // Description
  // Méthode qui enregistre les modifications du schéma affiché

If (Size of array:C274(TbTraducTableauA)>0)
	ZVerrouAttendre (->[RAEMACampagnes:20])
	OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbA";TbTraducTableauA)
	OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbF";TbTraducTableauF)
	SAVE RECORD:C53([RAEMACampagnes:20])
	ZAmnistiePartielle (->[RAEMACampagnes:20];True:C214)
End if 