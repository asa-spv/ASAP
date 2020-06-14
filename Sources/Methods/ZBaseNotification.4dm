//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 06/05/18, 18:59:07
  // ----------------------------------------------------
  // Paramètres
  // $1 = Titre de la notification
  // $2 = Texte de la notification (max 255 caractères)
  // {$3} = Durée
  // ----------------------------------------------------
  // Méthode : ZBaseNotification
  // Description
  //  

C_TEXT:C284($1;$2)

If (Count parameters:C259<2)
	ALERT:C41("erreur d'appel de la méhode "+Current method name:C684)
	
Else 
	
	C_LONGINT:C283($Time)
	$time:=0
	
	If (Count parameters:C259=3)
		C_LONGINT:C283($3)
		$time:=$3
		DISPLAY NOTIFICATION:C910($1;$2;$3)
		
	Else 
		DISPLAY NOTIFICATION:C910($1;$2)
		
	End if 
	
End if 