If (Size of array:C274(TbNR)>0)
	If (VarDateDebCamp=!00-00-00!) | (VarDateFinCamp=!00-00-00!)
		ALERT:C41("Il faut remplir la date de début de campagne ET la date limite de rendu des résultats!")
		If (VarDateDebCamp=!00-00-00!)
			GOTO OBJECT:C206(VarDateDebCamp)
		Else 
			GOTO OBJECT:C206(VarDateFinCamp)
		End if 
	Else 
		RaemaSchemaStockPage 
		RaemaInitPUMCampagne 
		ASAPFabriqueTbCampagnesToutes 
		ASAPFabriqueTbCampagneUne 
		ASAPFabriqueTbPrestations 
		  // ASAPFabriqueTbRAEMACourant 
		ZAmnistieInternationale 
		If (<>Alfort)
			  //WebRAEMACreationAgenda(Vrai)
			  //WebRAEMACreationAgenda(Faux)
			  //WebRAEMACreationAgenda(Vrai;Vrai)
			  //WebRAEMACreationAgenda(Faux;Vrai)
		End if 
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 
