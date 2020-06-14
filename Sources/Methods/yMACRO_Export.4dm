//%attributes = {"invisible":true}
  // Méthode projet MACRO_Export
  // ------------------------------------------------------------------------------------------
  // Cette méthode sauvegarde le contenu d'une méthode sur le disque.
  // Par défaut elle est exécutée automatiquement depuis une macro V2 sur l'événement on_save
  // Vous pouvez aussi l'appeler en passant le nom d'une méthode
  // ------------------------------------------------------------------------------------------
  // Créé le 20/06/2010 par Pascal Foubert, 
  // modifié par Patrick EMANUEL pour un fonctionnement avec les méthodes formulaires
  // -------------------------------------------------------------------------------------------


C_TEXT:C284($methodName_t;$1)
C_TEXT:C284($methodContent_t;$folder;$TimeStamp)
C_TIME:C306($vDocRef)
C_BLOB:C604($methodName_b)

  // A modifier selon l'application
$folder:=<>StartPrintFolder+"Sauvegarde Methodes"+Séparateur dossier:K24:12
If (Test path name:C476($folder)#Est un dossier:K24:2)
	  // Le répertoire n'existe pas  
	CREATE FOLDER:C475($folder)
End if 

$methodName_t:=$1

  // $TimeSTamp = temps écoulée depuis le 01/01/2011
$TimeStamp:=ZCapitaliseChaine (String:C10(Year of:C25(<>zdatedujour))+"-"+String:C10(<>Zdatedujour-!2011-01-01!)+" - "+String:C10(<>ZHeureCourante;Heures minutes secondes:K7:3);3)
$MethodName_t2:=$folder+$methodName_t+"_"+$TimeStamp+".txt"

  // Il est nécessaire de filtrer les caractères non acceptés dans les noms de fichier
$Longueur:=Length:C16($MethodName_t2)

$MethodName_t:=""

For ($vlCar;1;Length:C16($MethodName_t2))
	$vlCode:=Character code:C91($MethodName_t2[[$vlCar]])
	Case of 
		: ($vlCode=Character code:C91("["))
			
		: ($vlCode=Character code:C91(":"))
			If ($vlCar=2)
				$MethodName_t:=$MethodName_t+Char:C90($vlCode)
			Else 
				$MethodName_t:=$MethodName_t+" - "
			End if 
			
		: ($vlCode=Character code:C91("]"))
			$MethodName_t:=$MethodName_t+" - "
			
		Else 
			$MethodName_t:=$MethodName_t+Char:C90($vlCode)
			  // ...
	End case 
End for 

GET MACRO PARAMETER:C997(Texte méthode:K5:17;$methodContent_t)

Case of 
	: ((Length:C16($methodContent_t))>1)
		CONVERT FROM TEXT:C1011($methodContent_t;"UTF-8";$methodName_b)
		
		$vDocRef:=Create document:C266($methodName_t)
		
		If (OK=1)  // Si un document a été créé
			CLOSE DOCUMENT:C267($vDocRef)
			BLOB TO DOCUMENT:C526(Document;$methodName_b)  // Ecrire le contenu du document
		Else 
			ALERT:C41("Erreur lors de la sauvegarde")
			TRACE:C157
		End if 
End case 
