C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxHistorique";$C;$L)
If ($L>0)
	GOTO SELECTED RECORD:C245([PersonnesModifications:29];$L)
	DetailModifTexte:=[PersonnesModifications:29]TexteModification:6
	OBJECT SET VISIBLE:C603(*;"DetailModif@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"DetailModif@";False:C215)
End if 
