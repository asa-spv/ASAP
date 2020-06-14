
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		C_LONGINT:C283(VarRang)
		VarRang:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Rang";Est un numérique:K8:4)
		VarCOFRAC:=String:C10(OB Get:C1224([RAEMACampagnes:20]Arguments:7;"Sous accréditation";Est un booléen:K8:9);"Oui;;Non")
		$VarNumEch:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"N° des échantillons";Est un texte:K8:3)
		If ([RAEMACampagnes:20]NumCampagne:2="@a") | (Length:C16($VarNumEch)<50)
			VarNumEch:=""
		Else 
			VarNumEch:=$VarNumEch
		End if 
		ARRAY TEXT:C222(TbA;0)
		ARRAY TEXT:C222(TbF;0)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbA";TbA)
		OB GET ARRAY:C1229([RAEMACampagnes:20]Arguments:7;"TbF";TbF)
		RELATE MANY:C262([RAEMACampagnes:20]UUID:1)
		ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
		LISTBOX SELECT ROW:C912(*;"ListBoxGermes";0;lk supprimer de sélection:K53:3)
		ZViderSelectionCourante (->[RAEMALignes:22])
		ZViderSelectionCourante (->[RAEMAValeurs:23])
		READ WRITE:C146(*)
End case 
