//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 04/05/18, 14:04:24
  // ----------------------------------------------------
  // Paramètres
  //    $1 = Pointeur vers le champ récipiendaire
  //   {$2} = Vrai si on doit passer tout en majuscules
  //          Faux on ne capitalise que la première lettre
  //   {$3} = Nombre maximal de caractères autorisés
  //    $0 = Vrai si $1#""
  //    $1-> = la chainde traitée
  // ----------------------------------------------------
  // Méthode : ZCapitaliseCaractère
  // ZCapitaliseCaractère V11 du 10/08/2010
  // Description
  // REND LES SAISIES CONFORMES

C_POINTER:C301($1)  //Pointeur vers la rubrique récipiendaire
C_BOOLEAN:C305($2)  //{Optionnel} : Vrai si on doit passer tout en majuscules
  //Faux pour seulement la première lettre
  //Si le paramètre est absent, on laisse la saisie telle quelle
C_LONGINT:C283($3)  //{Optionnel} : longueur maxi de la saisie
C_TEXT:C284($Entree)
C_BOOLEAN:C305($0)

$Entree:=$1->

If ($Entree#"")
	If (Count parameters:C259=3)
		$Entree:=Substring:C12($Entree;1;$3)  //Nombre maximal de caractères autorisés
	End if 
	
	$Entree:=ZCapitaliseChaine ($Entree;11)  //Eliminations des espaces superflus
	
	If ($Entree#"")
		If (Count parameters:C259>1)
			If ($2)
				$Entree:=Uppercase:C13($Entree)  //On passe tout en majuscules
			Else 
				$Entree[[1]]:=Uppercase:C13($Entree[[1]])  //Première lettre seulement en majuscule        
			End if 
			
		Else   //Pas de conversion en majuscules du tout
			  //On ne fait rien
		End if 
		
	End if   //($Entree # "")
End if   //($Entree # "")

$1->:=$Entree
$0:=($Entree#"")