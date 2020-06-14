
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/12/16, 10:39:47
  // ----------------------------------------------------
  // Méthode : DevisRaemaGel
  // Description
  // Desiste 105 -> 139
  // Annonce 105 -> 178  VarTitreCampagne 
  // Ligne 1 et 2 = Lignemilieu 178 -> 220 VarTitreLigne Var1 -> Var5
  // Ligne 3 = LigneFin 223 -> 257  Var1 -> Var5
  // Pied 260 -> 440  VarAdresse VarPrixHT  
  // ----------------------------------------------------


Case of 
	: (ContexteImpression="ET")
		SET PRINT MARKER:C709(Entête formulaire:K43:3;0)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;93)
		
		
	: (ContexteImpression="Desiste")
		SET PRINT MARKER:C709(Entête formulaire:K43:3;105)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;139)
		
		
	: (ContexteImpression="Annonce")
		SET PRINT MARKER:C709(Entête formulaire:K43:3;105)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;178)
		
		
	: (ContexteImpression="Lignemilieu")
		SET PRINT MARKER:C709(Entête formulaire:K43:3;178)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;200)
		
		
	: (ContexteImpression="LigneFin")
		SET PRINT MARKER:C709(Entête formulaire:K43:3;243)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;248)
		
	: (ContexteImpression="Cofrac")
		SET PRINT MARKER:C709(Entête formulaire:K43:3;881)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;893)
		
	: (ContexteImpression="Pied")
		SET PRINT MARKER:C709(Entête formulaire:K43:3;260)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;460)
		
	: (ContexteImpression="Vide")
		$Taquet:=440
		SET PRINT MARKER:C709(Entête formulaire:K43:3;$Taquet)
		SET PRINT MARKER:C709(Corps formulaire:K43:1;($Taquet+VarHauteurVide))
		
		
		
End case 
