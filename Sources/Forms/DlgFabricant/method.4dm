

$evt:=Form event code:C388
If ($evt=Sur chargement:K2:1)
	  // Essayons de charger le tableau
	ARRAY TEXT:C222(TbFabricant;0)  // Modifié par : iMacASA2017 (25/04/2019)
	OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbFabricant";TbFabricant)
	
	  // s'il est vide, recalculons le sur la base de la dernière campagne
	If (Size of array:C274(TbFabricant)=0)
		$CampagneAvant:=TbNR{TbNR-1}
		QUERY:C277([RAEMALignes:22];[RAEMALignes:22]NomFr:4="@fabricant@";*)
		QUERY:C277([RAEMALignes:22];[RAEMACampagnes:20]NumCampagne:2=$CampagneAvant)
		RELATE MANY:C262([RAEMALignes:22]UUID:1)
		SELECTION TO ARRAY:C260([RAEMAValeurs:23]NomFr:4;TbFabricant\
			;[RAEMAValeurs:23]Identifiant:3;$TbIdentifiant)
		SORT ARRAY:C229($TbIdentifiant;TbFabricant;>)
		ZVerrouAttendre (->[RAEMACampagnes:20])
		OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbFabricant";TbFabricant)
		SAVE RECORD:C53([RAEMACampagnes:20])
		ZAmnistiePartielle (->[RAEMACampagnes:20];True:C214)
	End if 
End if 