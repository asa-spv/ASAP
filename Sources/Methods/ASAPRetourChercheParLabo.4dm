//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/01/19, 06:02:20
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPRetourChercheParLabo
  // Description
  // 
$Num:=Num:C11(Request:C163("Quel n° de labo ?"))
If (OK=1) & ($Num#0)
	
	$UUIDLabo:=ASAPTrouveUUIDLaboParNumero ($Num)
	QUERY:C277([RetoursAdherents:27];[RetoursAdherents:27]IDAdherent:3=$UUIDLabo)
	If (Records in selection:C76([RetoursAdherents:27])=0)
		ALERT:C41("Désolé, le laboratoire n°"+String:C10($Num)+" n'a pas de retours d'information")
	Else 
		RELATE ONE SELECTION:C349([RetoursAdherents:27];[RetoursFiches:24])
		ZFenetreActualiseTitre 
	End if 
End if 