C_LONGINT:C283($C;$L)
C_POINTER:C301($Pt)

LISTBOX GET CELL POSITION:C971(*;"GermesListBox";$C;$L;$Pt)
$evt:=Form event code:C388
Case of 
		
	: ($evt=Sur double clic:K2:5)
		OBJECT SET ENTERABLE:C238($Pt->;True:C214)
		EDIT ITEM:C870($Pt->;$Pt->)
		
	: ($evt=Sur nouvelle sélection:K2:29)
		GOTO SELECTED RECORD:C245([RAEMAGermes:21];$L)
		RaemaSchemaAfficheLignes 
		RaemaSchemaTitreBoutonSupprimer (->ListBoxGermes)
		
	: ($evt=Sur après frappe clavier:K2:26) & ($C=1)
		$TE:=Get edited text:C655
		If (Length:C16($TE)>1)
			$Candidat:=YSaisieAssiste (-><>TbNomGermeSchémaGEL;1;False:C215)
			If (Find in array:C230(<>TbNomGermeSchémaGEL;$Candidat)>0) & (Find in array:C230(TbNomGermeFr;$Candidat)<0)
				TbNomGermeFr{$L}:=$Candidat
			Else 
				TbNomGermeFr{$L}:=""
			End if 
		End if 
		
	: ($evt=Sur données modifiées:K2:15)
		GOTO SELECTED RECORD:C245([RAEMAGermes:21];TbNomGermeFr)
		ZVerrouAttendre (->[RAEMAGermes:21])
		[RAEMAGermes:21]NomFr:4:=TbNomGermeFr{TbNomGermeFr}
		[RAEMAGermes:21]NomEn:5:=TbNomGermeEn{TbNomGermeFr}
		  //TbCofracGerme{$Salé}:=OB Lire($TbArgumentsGerme{$Salé};"COFRAC";Est un booléen)
		  //TbExperimentalGerme{$Salé}:=ob lire($TbArgumentsGerme{$Salé};"Experimental";Est un booléen)
		OB SET:C1220([RAEMAGermes:21]Arguments:6;"COFRAC";TbCofracGerme{TbNomGermeFr})
		OB SET:C1220([RAEMAGermes:21]Arguments:6;"Experimental";TbExperimentalGerme{TbNomGermeFr})
		SAVE RECORD:C53([RAEMAGermes:21])
		ZAmnistiePartielle (->[RAEMAGermes:21];True:C214)
		
		
	: ($evt=Sur déplacement ligne:K2:32)
		$Ligne:=TbNomGermeFr
		$FT:=Size of array:C274(TbNomGermeFr)
		ARRAY TEXT:C222(TbIdentifiantGerme;$FT)
		For ($Salé;1;$FT)
			TbIdentifiantGerme{$Salé}:=TbNR{TbNR}+String:C10($Salé;"00")
		End for 
		CREATE SELECTION FROM ARRAY:C640([RAEMAGermes:21];TbNumEnrGerme)
		ARRAY TO SELECTION:C261(TbIdentifiantGerme;[RAEMAGermes:21]Identifiant:3)
		
End case 
