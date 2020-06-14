//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 08:58:27
  // ----------------------------------------------------
  // Méthode : ZBoutonListeUserSet
  // Description
  //  sélectionne les enregistrements noircis par l'utilisateur
  // ----------------------------------------------------
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)
If (Records in set:C195("Userset")#0)  //vérification de non vide
	USE SET:C118("Userset")
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;"ZNbEnr"))->:=Records in selection:C76(ZPtTable->)
	ZFenetreActualiseTitre 
Else 
	ALERT:C41("Aucune fiche désignée…")
End if 