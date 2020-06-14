$Dem:=Request:C163("Veuillez saisir votre mot de passe")
If (OK=1)
	ZVerrouAttendre (->[XUtilisateurs:2])
	[XUtilisateurs:2]Passoire:5:=$Dem
	SAVE RECORD:C53([XUtilisateurs:2])
	READ ONLY:C145([XUtilisateurs:2])
End if 