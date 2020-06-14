//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 10/04/18, 14:59:46
  // ----------------------------------------------------
  // Méthode : ZLBStockeLB
  // Description
  // Méthode qui permet de stocker la listBox affichée 
  //  en lui donnant un nom
  // ----------------------------------------------------

$Nom:=Request:C163("Quel nom pour celle liste ?";TbPUMFormatPossible{TbPUMFormatPossible})
If (OK=1) & ($Nom#"")
	$OC:=True:C214
	$Ajout:=False:C215
	$L:=Find in array:C230(TbPUMFormatPossible;$Nom)
	If ($L>0)
		If (Find in array:C230(TbPUMFormatInterdit;$Nom)>0)
			ALERT:C41("Désolé, une liste, réalisée par un autre utilisateur, porte déjà ce nom. Merci d'en proposer un autre....")
			$OC:=False:C215
		Else 
			CONFIRM:C162("La liste "+<>ZGuil+$Nom+<>ZGuil+" existe déjà : voulez-vous la remplacer par celle-ci ???";"Oui c'est ça";"Pas du tout")
			$OC:=(OK=1)
		End if 
	End if 
	
	
	If ($OC)
		If ($L>0)
			TbPUMFormatPossible:=$L
			ZLBColonnesSauve ($Nom)
		Else 
			$UUID:=ZLBColonnesSauve ($Nom)
			$L:=Find in array:C230(TbPUMFormatPossible;"-")  // existe t'il d'autres liste héritée des autres utilisateurs ?
			If ($L<0)
				APPEND TO ARRAY:C911(TbPUMFormatPossible;$Nom)
				APPEND TO ARRAY:C911(TbUUIDFormatPossible;$UUID)
				TbPUMFormatPossible:=Size of array:C274(TbPUMFormatPossible)
			Else 
				INSERT IN ARRAY:C227(TbPUMFormatPossible;$L)  // insertion en fin de liste propritétaire
				TbPUMFormatPossible{$L}:=$Nom
				INSERT IN ARRAY:C227(TbUUIDFormatPossible;$L)  // insertion en fin de liste propritétaire
				TbUUIDFormatPossible{$L}:=$UUID
			End if 
			TbPUMFormatPossible:=Find in array:C230(TbPUMFormatPossible;$Nom)
		End if 
		
	End if 
End if 
