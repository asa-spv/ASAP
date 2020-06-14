
C_LONGINT:C283($Salé;$FT)
$FT:=Size of array:C274(ListBoxChoixEnsemble)
ARRAY LONGINT:C221($TbPeloton;0)
For ($Salé;1;$FT)
	If (ListBoxChoixEnsemble{$Salé})
		APPEND TO ARRAY:C911($TbPeloton;ZTbEnsNumEnr{$Salé})
	End if 
End for 
$SFT:=Size of array:C274($TbPeloton)
If ($SFT=0)
	ALERT:C41("Désignez au moins un ensemble à supprimer...")
Else 
	Case of 
		: ($SFT=1)
			$Ensemblepeloton:="l'ensemble "
			$s:=""
			
		: ($SFT>1)
			$Ensemblepeloton:="les "+String:C10($SFT)+" ensembles "
			$s:="s"
	End case 
	
	CONFIRM:C162("Désirez-vous VRAIMENT supprimer "+$Ensemblepeloton+" sélectionné"+$s)
	If (OK=1)
		READ WRITE:C146([XData:1])
		CREATE SELECTION FROM ARRAY:C640([XData:1];$TbPeloton)
		DELETE SELECTION:C66([XData:1])
		ZEnsembleCracheEnsemble 
		ZAmnistiePartielle (->[XData:1])
	End if 
End if 