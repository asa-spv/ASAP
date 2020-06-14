//%attributes = {"publishedWeb":true}
  //  ZMAJDeclareVar V11 du 14/08/2010
  //   sert à placer les déclaration des variables crées hors standard

QUERY:C277([XData:1];[XData:1]XNom:2="Compteur N° de RAEMA liés";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="CompteurRAEMAliés")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="Compteur N° de RAEMA liés"
	[XData:1]XType:3:="CompteurRAEMAliés"
	[XData:1]XEntier:6:=1000
	SAVE RECORD:C53([XData:1])
End if 

