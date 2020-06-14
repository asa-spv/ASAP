//%attributes = {}
  //   ZAjouteASel V11 du 10/08/2010
  //   MP d'ajout d'une séléction à une autre
  //   utilisé dans le bouton "Ajouter à sélection" en liste
  //  utilise ZActualiseTitreFenetre

CREATE SET:C116(ZPtTable->;"Ceusses avant")
QUERY:C277(ZPtTable->)
If (Records in selection:C76(ZPtTable->)=0)
	ALERT:C41("Désolé: Aucune fiche à ajouter")
	USE SET:C118("Ceusses avant")
Else 
	CREATE SET:C116(ZPtTable->;"En pluche")
	UNION:C120("En pluche";"Ceusses avant";"Ceusses après")
	USE SET:C118("Ceusses après")
	CLEAR SET:C117("En pluche")
	CLEAR SET:C117("Ceusses après")
End if 
ZFenetreActualiseTitre 