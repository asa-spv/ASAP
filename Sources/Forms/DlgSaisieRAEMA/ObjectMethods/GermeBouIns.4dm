If (TbNomGermeFr>0)
	C_LONGINT:C283($Salé;$FT)
	CREATE RECORD:C68([RAEMAGermes:21])
	[RAEMAGermes:21]NomEn:5:="New germ"
	[RAEMAGermes:21]NomFr:4:="Nouveau germe"
	  //Si (TbNomGermeFr=1)
	  //[RAEMAGermes]Identifiant:=TbNR{TbNR}
	  //Sinon 
	  //[RAEMAGermes]Identifiant:=TbIdentifiantGerme{TbNomGermeFr-1}+"a"
	  //Fin de si 
	[RAEMAGermes:21]Identifiant:3:=TbIdentifiantGerme{TbNomGermeFr}+"a"
	[RAEMAGermes:21]UUIDCampagne:2:=TbUUIDCampagne{TbNR}
	SAVE RECORD:C53([RAEMAGermes:21])
	RaemaSchemaAfficheGermes 
	$FT:=Size of array:C274(TbNomGermeFr)
	ARRAY TEXT:C222($TbIdentifiants;$FT)
	For ($Salé;1;$FT)
		$TbIdentifiants{$Salé}:=TbNR{TbNR}+String:C10($Salé;"00")
	End for 
	ARRAY TO SELECTION:C261($TbIdentifiants;[RAEMAGermes:21]Identifiant:3)
Else 
	ALERT:C41("Désignez d'abord la ligne après laquelle insérer une valeur...")
End if 
