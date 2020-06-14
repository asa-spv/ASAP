
C_POINTER:C301(ZPtTable)

C_LONGINT:C283($Salé;$FT)
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$Menu:=""
		$FT:=Size of array:C274(TbMethodeLapin)
		ARRAY TEXT:C222($TbNomMéthode;0)
		For ($Salé;1;$FT)
			$Pos:=Position:C15(":";TbMethodeLapin{$Salé})
			$Menu:=$Menu+";"+Substring:C12(TbMethodeLapin{$Salé};1;($Pos-1))
			APPEND TO ARRAY:C911($TbNomMéthode;Substring:C12(TbMethodeLapin{$Salé};($Pos+1)))
		End for 
		
		$VarChoixUtilisateur:=Pop up menu:C542($Menu)
		If ($VarChoixUtilisateur>0)
			EXECUTE METHOD:C1007($TbNomMéthode{$VarChoixUtilisateur})
			ZFenetreActualiseTitre 
		End if 
End case 


