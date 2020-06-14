//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/0x00008, 0x00005:42:53
  // ----------------------------------------------------
  // Paramètres
  // $0x0000 = 
  // $2 = 
  // ----------------------------------------------------
  // Méthode : Configuration_Stocke
  // Description
  //  

  // ----- Sauvegarde dans le data de l'objet de paramétrage 

READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="Configuration";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Configuration")
[XData:1]XObjet:18:=OB Copy:C1225(Form:C1466)
SAVE RECORD:C53([XData:1])
ZAmnistiePartielle (->[XData:1])
CANCEL:C270