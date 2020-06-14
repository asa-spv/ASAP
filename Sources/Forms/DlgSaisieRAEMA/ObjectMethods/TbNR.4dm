RaemaSchemaStockPage   // Stockons les éléments du RAEMA courant
If (VarDateDebCamp=!00-00-00!) | (VarDateFinCamp=!00-00-00!)
	ALERT:C41("Il faut remplir la date de début de campagne ET la date limite de rendu des résultats!")
	If (VarDateDebCamp=!00-00-00!)
		GOTO OBJECT:C206(VarDateDebCamp)
	Else 
		GOTO OBJECT:C206(VarDateFinCamp)
	End if 
	TbNR:=Find in array:C230(TbNR;[RAEMACampagnes:20]NumCampagne:2)
Else 
	RaemaSchemaPUMCampagne 
End if 
