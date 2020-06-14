//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/03/18, 11:12:00
  // ----------------------------------------------------
  // Méthode : GA15AdilvaGelOK
  // Description
  // Méthode qui teste si l'[Adhérents] signalé 
  //   dans le fichier EXCEL est bien un ADILVA
  // ----------------------------------------------------
$0:=False:C215
SAssociation:=OB Get:C1224([Personnes:12]Arguments:7;"Association";Est un texte:K8:3)
Case of 
	: (Records in selection:C76([Personnes:12])=0)
		ALERT:C41("Désolé, je n'ai pas trouvé de laboratoire avec le n° de RAEMA "+NumCourant)
		
	: (SAssociation#"adilva")
		ALERT:C41("Désolé, le laboratoire avec le n° de RAEMA "+NumCourant+" n'est pas ADILVA mais "+SAssociation)
		
	Else 
		$0:=True:C214
		
End case 