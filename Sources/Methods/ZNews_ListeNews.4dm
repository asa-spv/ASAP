//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 06/05/18, 13:19:18
  // ----------------------------------------------------
  // Paramètres
  // $1 = si un paramètre est passé, affiche toutes les News
  // ----------------------------------------------------
  // Méthode : ZNews_ListeNews
  // Description
  //  


If (Count parameters:C259=1)
	
	If (OBJECT Get title:C1068(*;"BouToutVoirNews")="Tout voir")
		QUERY:C277([XData:1];[XData:1]XType:3="MsgNews";*)
		QUERY:C277([XData:1]; & ;[XData:1]XBoolSup:15=False:C215)
		OBJECT SET TITLE:C194(*;"BouToutVoirNews";"Voir les News actuelles")
		
	Else 
		QUERY:C277([XData:1];[XData:1]XType:3="MsgNews";*)
		QUERY:C277([XData:1]; & ;[XData:1]XBool:14=False:C215;*)
		QUERY:C277([XData:1]; & ;[XData:1]XBoolSup:15=False:C215)
		OBJECT SET TITLE:C194(*;"BouToutVoirNews";"Tout voir")
		
	End if 
	
Else 
	
	QUERY:C277([XData:1];[XData:1]XType:3="MsgNews";*)
	QUERY:C277([XData:1]; & ;[XData:1]XBool:14=False:C215)
	OBJECT SET TITLE:C194(*;"BouToutVoirNews";"Tout voir")
	
End if 

ORDER BY:C49([XData:1];[XData:1]XDate:4;<)
(OBJECT Get pointer:C1124(Objet nommé:K67:5;"Champ"))->:=Records in selection:C76([XData:1])
