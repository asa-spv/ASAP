C_LONGINT:C283($Salé;$FT)
ZVerrouAttendre (->[RAEMACampagnes:20])
For ($Salé;1;$FT)
	$Rang:=$FT-$Salé+1
	If (TbFabricant{$Rang}="")
		DELETE FROM ARRAY:C228(TbFabricant;$Rang)
	End if 
End for 

OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbFabricant";TbFabricant)
SAVE RECORD:C53([RAEMACampagnes:20])
ZAmnistiePartielle (->[RAEMACampagnes:20];True:C214)
QUERY:C277([RAEMALignes:22];[RAEMALignes:22]NomFr:4="@fabricant@";*)
QUERY:C277([RAEMALignes:22];[RAEMACampagnes:20]UUID:1=[RAEMACampagnes:20]UUID:1)
SELECTION TO ARRAY:C260([RAEMALignes:22]Identifiant:3;$TbIdentifiant;[RAEMALignes:22]UUID:1;$TbUUIDLigne)
READ WRITE:C146([RAEMAValeurs:23])
RELATE MANY SELECTION:C340([RAEMAValeurs:23]UUIDLigne:2)
DELETE SELECTION:C66([RAEMAValeurs:23])
$FT:=Size of array:C274($TbIdentifiant)
For ($Salé;1;$FT)
	$IdentifiantLigneCourante:=$TbIdentifiant{$Salé}
	$UUIDLigneCourante:=$TbUUIDLigne{$Salé}
	
	$SFT:=Size of array:C274(TbFabricant)
	For ($Fumé;1;$SFT)  // pour chaque valeur du tableau TbFabricant
		CREATE RECORD:C68([RAEMAValeurs:23])
		[RAEMAValeurs:23]Identifiant:3:=$IdentifiantLigneCourante+String:C10($Fumé;"00")
		[RAEMAValeurs:23]NomEn:5:=TbFabricant{$Fumé}
		[RAEMAValeurs:23]NomFr:4:=[RAEMAValeurs:23]NomEn:5
		[RAEMAValeurs:23]UUIDLigne:2:=$UUIDLigneCourante
		SAVE RECORD:C53([RAEMAValeurs:23])
	End for 
End for 
ZAmnistiePartielle (->[RAEMAValeurs:23])