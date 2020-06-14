//%attributes = {"publishedWeb":true}
  //  ZEnsembleCracheEnsemble V11 du 14/08/2010
  //  MP qui met dans quatre tableaux 
  // les caractéristiques des ensembles du fichier en cours
  // et initialise ZTbEnsNumEnr (n° d'enregistrement)

C_LONGINT:C283($FT)
ARRAY TEXT:C222(ZTbEnsNom;0)  //  tableau des noms des ensembles
ARRAY DATE:C224(ZTbEnsDate;0)  //  tableau des dates de création
ARRAY TEXT:C222(ZTbEnsQVL;0)  //  tableau des noms des auteurs
ARRAY REAL:C219(ZTbEnsNbre;0)  //  tableau des nombre d'enregistrements
ARRAY LONGINT:C221(ZTbEnsNumEnr;0)  //  tableau des numéro d'enregistrements

QUERY:C277([XData:1];[XData:1]XType:3=ZTypEns)  //sélectionne les ensembles du fichier
SELECTION TO ARRAY:C260([XData:1]XNom:2;ZTbEnsNom\
;[XData:1]XDate:4;ZTbEnsDate\
;[XData:1]XAlpha:8;ZTbEnsQVL\
;[XData:1]XValeur:7;ZTbEnsNbre\
;[XData:1]XEntier:6;ZTbEnsNumEnr)

$FT:=Records in selection:C76([XData:1])
LONGINT ARRAY FROM SELECTION:C647([XData:1];ZTbEnsNumEnr)
SORT ARRAY:C229(ZTbEnsNom;ZTbEnsDate;ZTbEnsNbre;ZTbEnsQVL;ZTbEnsNumEnr;>)

If (Size of array:C274(ZTbEnsNom)=0)
	ALERT:C41("Il faut d'abord créer au moins un ensemble…")
	ZOnContinue:=False:C215  //  assure la quittaison (sic) dans ce cas
End if 