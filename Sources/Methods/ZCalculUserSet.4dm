//%attributes = {}
  // ZCalculUserSet  V11 du 10/08/2010
  //  sélectionne les enregistrements noircis par l'utilisateur
  //  script de BouListeSel 
  //  appelle ZActualiseTitreFenetre

CREATE SET:C116(ZPtTable->;"Ceusses avant")
If (Records in set:C195("Userset")#0)  //vérification de non vide
	USE SET:C118("Userset")
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;"ZNbEnr"))->:=Records in selection:C76(ZPtTable->)
	ZFenetreActualiseTitre 
Else 
	ALERT:C41("Aucune fiche désignée…")
End if 