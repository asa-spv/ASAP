//%attributes = {}
  //ZRécupeSel V11 du 15/08/2010
  //MP (MO de BouRécupSel) qui permet de récuperer une sélection précédente
  //  utilise ZActualiseTitreFenetre

If (Records in set:C195("Ceusses avant")#0)
	CREATE SET:C116(ZPtTable->;"Ceusses après")
	  //  permet une annulation en bascule
	USE SET:C118("Ceusses avant")
	COPY SET:C600("Ceusses après";"Ceusses avant")
	CLEAR SET:C117("Ceusses après")
Else 
	ALERT:C41("Pas de sélection précédente")
End if 
ZFenetreActualiseTitre 