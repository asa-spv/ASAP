//%attributes = {}
  // ZVireLesNoires  V11 du 15/08/2010
  //  méthode (non raciste) qui élimine les enregistrements désignés
  //  de la sélection courante
  //  utilisée par ZBouVireNoirSel
  //  utilise ZActualiseTitreFenetre

CREATE SET:C116(ZPtTable->;"Ceusses avant")  //conservons la sélection précédente
If (Records in set:C195("Userset")=0)
	ALERT:C41("Il faut désigner au moins UNE fiche…")
Else 
	USE SET:C118("Userset")
	CREATE SET:C116(ZPtTable->;"EnNoir")  // en pluche, c'est vite dit !!
	DIFFERENCE:C122("Ceusses avant";"EnNoir";"Ceusses après")  //enlevons les fiches de l'ensemble de départ
	CLEAR SET:C117("EnNoir")
	USE SET:C118("Ceusses après")  //appelons la sélection définitive
	CLEAR SET:C117("Ceusses après")
End if 
ZFenetreActualiseTitre 