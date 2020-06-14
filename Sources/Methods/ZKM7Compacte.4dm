//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 21/10/16, 08:54:09
  // ----------------------------------------------------
  // Paramètres :
  // $1=chemin complet du document source
  // {$2}=chemin complet du document zippé (même chemin si "" ou inexistant)
  // {$3}= mot de passe 
  // -----------------// Méthode : QSz7Compacte
  // Description
  // Permet de zipper (z7) un fichier
  //
  // -----------------------------------

C_BOOLEAN:C305($OC)
C_TEXT:C284($v;$erreur)

$NomCompletFichierSource:=$1
$CheminSource:=ZDocNomFichier ($1;1)
$NomCourtFichierSource:=ZDocNomFichier ($1;0)
$CheminCible:=$CheminSource
$NomLongDocCible:=$CheminCible+$NomCourtFichierSource+".zip"
$MdP:=""
$OC:=(Test path name:C476($1)=Est un document:K24:1) | (Test path name:C476($1)=Est un dossier:K24:2)
If (Count parameters:C259>1)
	If (Length:C16($2)>0)
		$CheminCible:=ZDocNomFichier ($2;1)
		$OC:=(Test path name:C476($CheminCible)=Est un dossier:K24:2)
	End if 
End if 

If ($OC)
	If (Count parameters:C259>1)
		If (Length:C16($2)>0)
			$NomLongDocCible:=$2
		End if 
	End if 
	If (Count parameters:C259=3)
		$MdP:=$3
	End if 
	$v:=z7_Get_version 
	If (Test path name:C476($NomLongDocCible)=Est un document:K24:1)
		DELETE DOCUMENT:C159($NomLongDocCible)
	End if 
	$erreur:=""
	$OC:=z7_Archive ($NomCompletFichierSource;$NomLongDocCible;$MdP;->$erreur)
	  // MONTRER SUR DISQUE($NomLongDocCible)
End if 
$0:=$OC