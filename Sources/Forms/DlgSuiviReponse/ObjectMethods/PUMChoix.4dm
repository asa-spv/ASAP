$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY TEXT:C222(PUMChoix;4)
		PUMChoix{1}:="Tous"
		PUMChoix{2}:="Absence"
		PUMChoix{3}:="En cours"
		PUMChoix{4}:="Reçue"
		PUMChoix:=1
		
	: ($evt=Sur données modifiées:K2:15)
		Case of 
			: (PUMChoix=1)  // Tous
				USE SET:C118("Concernées")
				
			: (PUMChoix=2)  // Absence
				USE SET:C118("Absence")
				
			: (PUMChoix=3)  // En cours
				USE SET:C118("Encours")
				
			: (PUMChoix=4)  // Réponse reçue
				USE SET:C118("Envoyé")
		End case 
		RaemaSuiviAfficheTbChoix 
		
End case 
