//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 15:48:08
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZBaseErreurs
  // Description
  // Trappe l'erreur la plus importante
  // En mode <>ZMouchard, écrit le tableau des erreurs dans le dossier "Logs_base" situé au niveau du serveur


C_LONGINT:C283(gError;gOk;OK;Error)
  // Copy the 4D system variables
gError:=Error
gOK:=OK

If (<>ZMouchard)
	
	C_LONGINT:C283($ErrorLine_L)
	C_TEXT:C284($ErrorMethod_T;$Msg_T)
	ARRAY LONGINT:C221($Codes_aL;0)
	ARRAY TEXT:C222($IntComp_aT;0)
	ARRAY TEXT:C222($Text_aT;0)
	
	$ErrorCode_L:=Error
	$ErrorMethod_T:=Error method
	$ErrorLine_L:=Error Line
	
	GET LAST ERROR STACK:C1015($Codes_aL;$IntComp_aT;$Text_aT)
	
	$Msg_T:=String:C10(<>ZDateDuJour;Interne date court:K1:7)+" @ "+String:C10(Current time:C178;h mn s:K7:1)+"\r"
	$Msg_T:=$Msg_T+Current user:C182+" sur "+Current machine:C483+"\r\r"
	
	$Msg_T:=$Msg_T+"Erreur : "+String:C10($ErrorCode_L)+" - "
	$Msg_T:=$Msg_T+"Méthode : \""+$ErrorMethod_T+" - "
	$Msg_T:=$Msg_T+"Ligne # : "+String:C10($ErrorLine_L)+"\r\r"
	
	$Msg_T:=$Msg_T+"Error stack: \r"
	$Msg_T:=$Msg_T+"Error\tInternal Component\tError message\r"
	For ($Ndx;1;Size of array:C274($Codes_aL))
		$Msg_T:=$Msg_T+String:C10($Codes_aL{$Ndx})+"\t"
		$Msg_T:=$Msg_T+$IntComp_aT{$Ndx}+"\t"
		$Msg_T:=$Msg_T+$Text_aT{$Ndx}+"\r"
	End for 
	$Msg_T:=$Msg_T+"-----------------------------------------\r"
	
	
	ZBaseAjouteTrace ($Msg_T)
	
End if 

