//%attributes = {"publishedWeb":true}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 18/02/18, 08:57:26
  // ----------------------------------------------------
  // Méthode : ZEnsembleAppel
  // Description
  // Historique : ZEnsembleAppel V11 du 10/08/2010
  // Remplace la sélection actuelle 
  // par celle notée préalablement dans un ensemble
  // ----------------------------------------------------
CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)
ZOnContinue:=True:C214  // permet de vérifier la cohérence des demandes
ZEnsembleCracheEnsemble   // sélectionne les fiches de XDonnées contenant les ensembles
If (ZOnContinue)
	ZFenetreModaleAuCentre (580;420;0)  //ouvre une fenêtre centrée
	DIALOG:C40("DlgAfficheEnsemble")
	CLOSE WINDOW:C154
	If (ZBouQuitte=0) & (ZTbEnsNom#0)
		GOTO RECORD:C242([XData:1];ZTbEnsNumEnr{ZTbEnsNom})
		ZEnsembleRelire ("EnsembleLu")
		USE SET:C118("EnsembleLu")  //il devient sélection courante
		CLEAR SET:C117("EnsembleLu")  //il ne sert plus à rien: effaçons-le
	End if 
	ZFenetreActualiseTitre 
End if 