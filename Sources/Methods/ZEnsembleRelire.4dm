//%attributes = {"publishedWeb":true}
  // ZEnsembleRelire  V11 du 15/08/2010
  //   MP qui va lire  l'ensemble dans le blob de l'enregistrement de [XDonnées]
  // $1= nom de l'ensemble chargé en mémoire


$NomEnsemble:=$1
$vhRefDoc:=Create document:C266("MonDoc.4st")  // Créer un document
CLOSE DOCUMENT:C267($vhRefDoc)  // Nous voulons pas qu'il reste ouvert
$CD:=Document
BLOB TO DOCUMENT:C526($CD;[XData:1]XBlob:13)  // Ecrire le contenu du document
LOAD SET:C185(ZPtTable->;$NomEnsemble;$CD)
DELETE DOCUMENT:C159($CD)