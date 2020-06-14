//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/08/18, 11:13:56
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ChercheDonneesCourielEntrant
  // Description
  // 

QUERY:C277([XData:1];[XData:1]XNom:2="Données courriel entrant";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="MWb")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="Données courriel entrant"
	[XData:1]XType:3:="MWb"
	[XData:1]XDate:4:=Current date:C33
	SAVE RECORD:C53([XData:1])
End if 
VarServeurMail:=[XData:1]XTexte:9