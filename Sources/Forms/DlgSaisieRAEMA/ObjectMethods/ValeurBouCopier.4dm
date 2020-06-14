CONFIRM:C162("Vous désirez copier le tableau des valeurs pour le coller plus tard ???")
If (OK=1)
	COPY ARRAY:C226(TbNumEnrValeurs;TbNECopierValeur)
	OBJECT SET ENABLED:C1123(*;"ValeurBouColler";(Size of array:C274(TbNECopierValeur)>0))
End if 