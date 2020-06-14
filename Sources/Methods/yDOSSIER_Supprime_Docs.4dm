//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 23/04/12
  // ----------------------------------------------------
  // Méthode : DOSSIER_Supprime_Docs
  // Description
  // Supprime tous les documents d'un dossier
  //
  // Paramètres
  // ----------------------------------------------------
  // $0 l'adresse du 1° document qui n'a pu être détruit ou vidé
  // $1 : l'adresse du dossier à vider de ses documents

C_TEXT:C284($1;$Dossier)
C_TEXT:C284($0;$ErreurAdresse;$fichier)

$Dossier:=$1

DOCUMENT LIST:C474($Dossier;$listeDocs)

For ($i;1;Size of array:C274($listeDocs))
	$fichier:=$Dossier+$listeDocs{$i}
	GET DOCUMENT PROPERTIES:C477($fichier;$verrouille;$invisible;$creele;$creea;$modifiele;$modifiea)
	
	If ($verrouille)
		$ErreurAdresse:=$fichier
	Else 
		DELETE DOCUMENT:C159($fichier)
	End if 
	
End for 

$0:=$ErreurAdresse