//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/06/18, 07:40:44
  // ----------------------------------------------------
  // Méthode : ZEnsembleSortNom
  // Description
  // Méthode qui permet de nommer l'ensemble 
  //  afin d'en coserver la trace
  // ----------------------------------------------------

ZDemEns:=Request:C163("Quel nom donner à cette sélection?")
ZOnContinue:=True:C214  //permet de continuer 
If (OK=1)
	While (((ZDemEns="") | (Length:C16(ZDemEns)>30)) & (ZOnContinue))
		If (ZDemEns="")  //case non remplie
			ZDemEns:=Request:C163("tu me le TAPES ce nom?")
			If (OK=0)  //permet d'annuler
				ZOnContinue:=False:C215  //permet d'arrêter 
			End if 
		Else   // nom de plus de 30 caractères
			ZDemEns:=Request:C163("30 caractères MAXIMUM ...")
			If (OK=0)
				ZOnContinue:=False:C215  //permet d'arrêter 
			End if 
		End if 
	End while 
	If (ZOnContinue)  //le nom est bien rempli
		READ WRITE:C146([XData:1])
		QUERY:C277([XData:1];[XData:1]XNom:2=ZDemEns;*)
		QUERY:C277([XData:1]; & [XData:1]XType:3=ZTypEns)
		If (Records in selection:C76([XData:1])>0)  //il existe déjà le nom
			CONFIRM:C162("Ce nom existe déjà: voulez vous le remplacer?")
			If (OK=1)  // on veut remplacer l'ancien ensemble par le nouveau
				If (ZVerrouTester (->[XData:1]))
					DELETE RECORD:C58([XData:1])
					  //destruction des fiches de [XData]
				End if 
			Else 
				ZOnContinue:=False:C215  //il veut conserver l'ancien ensemble
			End if 
		End if 
		READ ONLY:C145([XData:1])
	End if 
Else 
	ZOnContinue:=False:C215
End if 