If (TbChampsExport>0)
	DELETE FROM ARRAY:C228(TbChampsExport;TbChampsExport)
	OBJECT SET VISIBLE:C603(*;"BouExport";(Size of array:C274(TbChampsExport)>0))
	LISTBOX SELECT ROW:C912(*;"ListBoxChampsExport";0;lk supprimer de sélection:K53:3)
Else 
	ALERT:C41("Merci de désigner le renseignement à supprimer")
End if 