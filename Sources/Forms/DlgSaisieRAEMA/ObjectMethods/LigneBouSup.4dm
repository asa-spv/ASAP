If (TbNomLigneFr>0)
	C_LONGINT:C283($Salé;$FT)
	  // Actualisation du peloton
	$FT:=Size of array:C274(ListBoxLignes)
	$L:=0
	$Compteur:=0
	ARRAY LONGINT:C221($TbNumEnrLigneNoircie;0)
	For ($Salé;1;$FT)
		$L:=Find in array:C230(ListBoxLignes;True:C214;($L+1))
		If ($L<0)
			$Salé:=$FT
		Else 
			$Compteur:=$Compteur+1
			APPEND TO ARRAY:C911($TbNumEnrLigneNoircie;TbNumEnrLigne{$L})
		End if 
	End for 
	$FT:=Size of array:C274($TbNumEnrLigneNoircie)
	If ($FT=1)
		CONFIRM:C162("Voulez-vous VRAIMENT supprimer DEFINITIVEMENT la ligne "+<>ZGuil+" "+TbNomLigneFr{TbNomLigneFr}+" "+<>ZGuil+" ????")
	Else 
		CONFIRM:C162("Voulez-vous VRAIMENT supprimer DEFINITIVEMENT les "+String:C10($FT)+" lignes sélectionnées ????")
	End if 
	If (ok=1)
		READ WRITE:C146([RAEMALignes:22])
		CREATE SELECTION FROM ARRAY:C640([RAEMALignes:22];$TbNumEnrLigneNoircie)
		DELETE SELECTION:C66([RAEMALignes:22])
		ZAmnistiePartielle (->[RAEMALignes:22];True:C214)
		RELATE MANY:C262([RAEMAGermes:21]UUID:1)
		$FT:=Records in selection:C76([RAEMALignes:22])
		ARRAY TEXT:C222($TbIdentifiantLigne;$FT)
		For ($Salé;1;$FT)
			$TbIdentifiantLigne{$Salé}:=[RAEMAGermes:21]Identifiant:3+String:C10($Salé;"00")
		End for 
		ARRAY TO SELECTION:C261($TbIdentifiantLigne;[RAEMALignes:22]Identifiant:3)
		RaemaSchemaAfficheLignes 
	End if 
Else 
	ALERT:C41("Désignez d'abord la ligne à supprimer...")
End if 
