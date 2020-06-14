C_LONGINT:C283($C;$L)
C_POINTER:C301($Pt)
LISTBOX GET CELL POSITION:C971(*;"ValeursListBox";$C;$L;$Pt)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		C_TEXT:C284($Milieu;$Fabricant)
		GOTO SELECTED RECORD:C245([RAEMAValeurs:23];$L)
		VarValeur:=[RAEMAValeurs:23]NomEn:5
		$Milieu:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Milieu";Est un texte:K8:3)
		$Fabricant:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Fabricant";Est un texte:K8:3)
		VarTipsFr:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"TipsFr";Est un texte:K8:3)
		VarTipsEn:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"TipsEn";Est un texte:K8:3)
		$LMilieu:=Find in array:C230(TbNomLigneFr;"Nature@")
		$LFabricant:=Find in array:C230(TbNomLigneFr;"@Fabricant@")
		
		OBJECT SET VISIBLE:C603(*;"@prec";True:C214)
		If (TbNomLigneFr=1)
			ARRAY TEXT:C222(PUMMilieuLien;0)
			ARRAY TEXT:C222(PUMFournisseurLien;0)
			CUT NAMED SELECTION:C334([RAEMAValeurs:23];"EnCours")
			OBJECT SET VISIBLE:C603(*;"@lien";False:C215)
			  // Fabrication et sélection du PUM des milieux
			If ($LMilieu>0)
				QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=(TbIdentifiantLigne{$LMilieu}+"@"))
				ORDER BY:C49([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3;>)
				SELECTION TO ARRAY:C260([RAEMAValeurs:23]NomFr:4;PUMMilieuLien)
				INSERT IN ARRAY:C227(PUMMilieuLien;1)
				PUMMilieuLien:=Find in array:C230(PUMMilieuLien;$Milieu)
				OBJECT SET VISIBLE:C603(PUMMilieuLien;True:C214)
			End if 
			
			  // Fabrication et sélection du PUM des fabricants
			If ($LFabricant>0)
				QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=(TbIdentifiantLigne{$LFabricant}+"@"))
				ORDER BY:C49([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3;>)
				SELECTION TO ARRAY:C260([RAEMAValeurs:23]NomFr:4;PUMFournisseurLien)
				INSERT IN ARRAY:C227(PUMFournisseurLien;1)
				PUMFournisseurLien:=Find in array:C230(PUMFournisseurLien;$Fabricant)
				OBJECT SET VISIBLE:C603(PUMFournisseurLien;True:C214)
			End if 
			USE NAMED SELECTION:C332("EnCours")
		Else 
			OBJECT SET VISIBLE:C603(*;"@lien";False:C215)
		End if 
		
	: ($evt=Sur données modifiées:K2:15)
		GOTO SELECTED RECORD:C245([RAEMAValeurs:23];TbNomValeurFr)
		ZVerrouAttendre (->[RAEMAValeurs:23])
		[RAEMAValeurs:23]NomFr:4:=TbNomValeurFr{TbNomValeurFr}
		[RAEMAValeurs:23]NomEn:5:=TbNomValeurEn{TbNomValeurFr}
		OB SET:C1220([RAEMAValeurs:23]Arguments:6;"Escamotage";TbEscamotage{TbEscamotage})
		OB SET:C1220([RAEMAValeurs:23]Arguments:6;"Précision";TbPrécision{TbPrécision})
		SAVE RECORD:C53([RAEMAValeurs:23])
		ZAmnistiePartielle (->[RAEMAValeurs:23];True:C214)
		
	: ($evt=Sur double clic:K2:5)
		OBJECT SET ENTERABLE:C238($Pt->;True:C214)
		EDIT ITEM:C870($Pt->{$Pt->})
		
	: ($evt=Sur déplacement ligne:K2:32)
		$FT:=Size of array:C274(TbNumEnrValeurs)
		For ($Salé;1;$FT)
			TbIdentifiantValeur{$Salé}:=[RAEMALignes:22]Identifiant:3+String:C10($Salé;"00")
		End for 
		CREATE SELECTION FROM ARRAY:C640([RAEMAValeurs:23];TbNumEnrValeurs)
		ARRAY TO SELECTION:C261(TbIdentifiantValeur;[RAEMAValeurs:23]Identifiant:3)
		
End case 
