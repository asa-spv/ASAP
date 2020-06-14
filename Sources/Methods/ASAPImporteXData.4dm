//%attributes = {}

SET CHANNEL:C77(10;"")
If (OK=1)
	RECEIVE VARIABLE:C81($var)
	If ($Var="XData")
		RECEIVE RECORD:C79([XData:1])
		SAVE RECORD:C53([XData:1])
	End if 
	
End if 



  //Procédure d'export
  //CHERCHER([XData];[XData]XType="TraductionEC";*)
  //CHERCHER([XData]; & [XData]XNom="Traduction de l'espace client")
  //RÉGLER SÉRIE(12;"")
  //$Envoi:="XData"
  //ENVOYER VARIABLE($Envoi)
  //ENVOYER ENREGISTREMENT([XData])
  //RÉGLER SÉRIE(11)