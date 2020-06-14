C_LONGINT:C283($C;$L)
C_POINTER:C301($Pt)
LISTBOX GET CELL POSITION:C971(*;"LignesListBox";$C;$L;$Pt)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		GOTO SELECTED RECORD:C245([RAEMALignes:22];$L)
		RaemaSchemaAfficheValeurs 
		RaemaSchemaTitreBoutonSupprimer (->ListBoxLignes)
		
	: ($evt=Sur données modifiées:K2:15)
		
		GOTO SELECTED RECORD:C245([RAEMALignes:22];TbNomLigneFr)
		ZVerrouAttendre (->[RAEMALignes:22])
		[RAEMALignes:22]NomFr:4:=TbNomLigneFr{TbNomLigneFr}
		[RAEMALignes:22]NomEn:5:=TbNomLigneEn{TbNomLigneEn}
		OB SET:C1220([RAEMALignes:22]Arguments:6;"Escamotable";TbEscamotable{TbEscamotable})
		OB SET:C1220([RAEMALignes:22]Arguments:6;"ChoixMultiple";TbMultiple{TbMultiple})
		SAVE RECORD:C53([RAEMALignes:22])
		ZAmnistiePartielle (->[RAEMALignes:22];True:C214)
		OBJECT SET ENTERABLE:C238($Pt->;False:C215)
		
	: ($evt=Sur double clic:K2:5)
		
		OBJECT SET ENTERABLE:C238($Pt->;True:C214)
		EDIT ITEM:C870($Pt->{$Pt->})
		
	: ($evt=Sur déplacement ligne:K2:32)
		$FT:=Size of array:C274(TbNomLigneFr)
		ARRAY TEXT:C222(TbIdentifiantLigne;$FT)
		For ($Salé;1;$FT)
			TbIdentifiantLigne{$Salé}:=[RAEMAGermes:21]Identifiant:3+String:C10($Salé;"00")
		End for 
		CREATE SELECTION FROM ARRAY:C640([RAEMALignes:22];TbNumEnrLigne)
		ARRAY TO SELECTION:C261(TbIdentifiantLigne;[RAEMALignes:22]Identifiant:3)
		
		
End case 
