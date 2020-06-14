If (TbNomGermeFr>0)
	C_LONGINT:C283($Salé;$FT)
	  // Actualisation du peloton
	$FT:=Size of array:C274(ListBoxGermes)
	$L:=0
	$Compteur:=0
	ARRAY LONGINT:C221($TbNumEnrLigneNoircie;0)
	For ($Salé;1;$FT)
		$L:=Find in array:C230(ListBoxGermes;True:C214;($L+1))
		If ($L<0)
			$Salé:=$FT
		Else 
			$Compteur:=$Compteur+1
			APPEND TO ARRAY:C911($TbNumEnrLigneNoircie;TbNumEnrGerme{$L})
		End if 
	End for 
	$FT:=Size of array:C274($TbNumEnrLigneNoircie)
	If ($FT=1)
		CONFIRM:C162("Voulez-vous VRAIMENT supprimer DEFINITIVEMENT le germe "+<>ZGuil+" "+TbNomGermeFr{TbNomGermeFr}+" "+<>ZGuil+" ????")
	Else 
		CONFIRM:C162("Voulez-vous VRAIMENT supprimer DEFINITIVEMENT les "+String:C10($FT)+" germes sélectionnés "+" ????")
	End if 
	If (ok=1)
		READ WRITE:C146([RAEMAGermes:21])
		CREATE SELECTION FROM ARRAY:C640([RAEMAGermes:21];$TbNumEnrLigneNoircie)
		DELETE SELECTION:C66([RAEMAGermes:21])
		ZAmnistiePartielle (->[RAEMAGermes:21])
		RELATE MANY:C262([RAEMACampagnes:20]UUID:1)
		ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
		$FT:=Records in selection:C76([RAEMAGermes:21])
		ARRAY TEXT:C222($TbIdentifiantGerme;$FT)
		For ($Salé;1;$FT)
			$TbIdentifiantGerme{$Salé}:=TbNR{TbNR}+String:C10($Salé;"00")
		End for 
		ARRAY TO SELECTION:C261($TbIdentifiantGerme;[RAEMAGermes:21]Identifiant:3)
		RaemaSchemaAfficheGermes 
	End if 
Else 
	ALERT:C41("Désignez d'abord le germe à supprimer...")
End if 
