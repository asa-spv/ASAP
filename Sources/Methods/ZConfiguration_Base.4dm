//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 14:05:39
  // ----------------------------------------------------
  // Paramètres
  // $1 = Numero de la page du formulaire de configuration
  // ----------------------------------------------------
  // Méthode : Configuration_Base
  // Description
  //  

C_LONGINT:C283($1;$QuellePage)

$QuellePage:=$1

Case of 
		
	: ($QuellePage=1)
		ZObjet_Set_Info ("SousTitre";"Données Générales";True:C214)
		
		
	: ($QuellePage=2)
		ZObjet_Set_Info ("SousTitre";"Gestion des Titres de colonnes de tous les utilisateurs";True:C214)
		
		
	: ($QuellePage=3)
		ZObjet_Set_Info ("SousTitre";"Paramètres de Sauvegarde";True:C214)
		
		
	: ($QuellePage=4)
		ZObjet_Set_Info ("SousTitre";"Paramètres de Mails";True:C214)
		
		
	: ($QuellePage=5)
		ZObjet_Set_Info ("SousTitre";"Gestion de la sécurité";True:C214)
		
	: ($QuellePage=6)
		ZObjet_Set_Info ("SousTitre";"Options";True:C214)
		
		
	Else 
		
		ALERT:C41("Erreur dans l'appel de la méthode "+Current method name:C684)
		
End case 

FORM GOTO PAGE:C247($QuellePage)
