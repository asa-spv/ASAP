//%attributes = {"publishedWeb":true}
  // ZOterASel V11 du 15/08/2010
  //  PG de retrancher une séléction à une autre
  //utilisé dans le bouton "Enlever à sélection" en Liste
  //  utilise ZActualiseTitreFenetre

CREATE SET:C116(ZPtTable->;"Ceusses avant")  //conservons la sélection précédente
QUERY:C277(ZPtTable->)  //le critère est donné par l'utilisateur
  // La nouvelle sélection n'est-elle pas vide?
If (Records in selection:C76(ZPtTable->)=0)  // Elle est
	ALERT:C41("Désolé: Aucune fiche à enlever")  //prévenons l'utilisateur
	USE SET:C118("Ceusses avant")  //reprenons l'ancienne sélection
Else   // elle n'est pas
	CREATE SET:C116(ZPtTable->;"EnMoinsse")
	DIFFERENCE:C122("Ceusses avant";"EnMoinsse";"Ceusses après")  //enlevons les fiches de l'ensemble de départ
	CLEAR SET:C117("EnMoinsse")
	If (Records in selection:C76(ZPtTable->)=0)  // est-elle vide??
		ALERT:C41("Désolé, vous avez tout enlévé")  //No comment
		USE SET:C118("Ceusses avant")  //reprenons l'ancienne sélection
	Else 
		USE SET:C118("Ceusses après")  //appelons la sélection définitive
		CLEAR SET:C117("Ceusses après")
	End if 
End if 
ZFenetreActualiseTitre 