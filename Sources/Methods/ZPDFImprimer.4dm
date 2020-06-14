//%attributes = {}
  //ZPDFImprimer V12 du 12/01/2013
  // Imprime tout un document dans une tâche unique d'impression
  // $1 : Nom du fichier
  //$2 : Chemin du dossier d'impression
  // $3 = méthode à exécuter pour créer le Pdf et 
$NomFichier:=$1
$CheminDossier:=$2
ZPDFInitPrinter ($NomFichier;$CheminDossier)
OPEN PRINTING JOB:C995
EXECUTE METHOD:C1007($3;*)
CLOSE PRINTING JOB:C996
  // ZPDFRestoreRegistre 


