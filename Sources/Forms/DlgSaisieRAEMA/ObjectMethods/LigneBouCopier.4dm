CONFIRM:C162("Vous désirez copier le tableau des lignes pour le coller plus tard ???")
If (OK=1)
	COPY ARRAY:C226(TbNumEnrLigne;TbNECopierLigne)
	OBJECT SET ENABLED:C1123(*;"TbNECopierValeur";(Size of array:C274(TbNECopierLigne)>0))
End if 