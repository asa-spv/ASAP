//%attributes = {"publishedWeb":true}
  //   ZEnsembleStocke V11 du 14/08/2010
  //  MG d'écriture sur disque d'un ensemble 
  // mis dans le blob de [XDonnées] avant d'être effacé

SAVE SET:C184("Transit";"Seconde.4st")  //création d'un document sur le disque
CREATE RECORD:C68([XData:1])  //création d'une fiche de [XDonnées] 
[XData:1]XNom:2:=ZDemEns
[XData:1]XDate:4:=Current date:C33
[XData:1]XType:3:=ZTypEns
[XData:1]XValeur:7:=Records in set:C195("Transit")
If (<>ZQuiVaLà="")
	[XData:1]XAlpha:8:="inconnu"
Else 
	[XData:1]XAlpha:8:=<>ZQuiVaLà
End if 
DOCUMENT TO BLOB:C525("Seconde.4st";[XData:1]XBlob:13)
  //  moderne cette première utilisation d'un blob 17/8/98 à 11h 19
SAVE RECORD:C53([XData:1])
UNLOAD RECORD:C212([XData:1])
DELETE DOCUMENT:C159("Seconde.4st")