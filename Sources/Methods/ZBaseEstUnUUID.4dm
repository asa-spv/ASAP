//%attributes = {}
  //*==============================================================================
  //Methode projet : ZBase_EstUnUUID
  // Publique
  //
  //DESCRIPTION :
  // Cette fonction vérifie qu'une chaine passée ressemble à un UUID
  //
  // PARAMETRES :
  //  $0 (BOOLEEN) <= isUUID (True if it is a UUID)
  //  $1 (TEXTE) => UUID
  //  
  //NOTES : 
  //"D2D37CE1-2DCF-45D5-9F0B-E575750EA920"
  //"d2d37ce1-2dcf-45d5-9f0b-e575750ea920"
  //
  //EXAMPLE D'APPEL : 
  //  C_TEXTE($vt_uuid)
  //  $vt_uuid:=UUID_new 
  //
  //  Si (UUID_isUUID ($vt_uuid))
  //    ALERTE("UUID OK")
  //  Sinon 
  //    ALERTE("UUID ERROR")
  //  Fin de si 
  //  
  //CREATION : Bruno LEGAY (BLE) - 30/05/08, 11:49:26 - v1.00.00
  //
  // 1999-2006 © A&C Consulting
  //*===============================================================================

C_BOOLEAN:C305($0)  //isUUID
C_TEXT:C284($1)  //UUID

C_BOOLEAN:C305($vb_isUUID)
C_TEXT:C284($vt_UUID)

$vb_isUUID:=False:C215
If (Count parameters:C259>0)
	$vt_UUID:=$1
	$0:=$vb_isUUID
	
	If (Length:C16($vt_UUID)=36)
		
		  //"D2D37CE1-2DCF-45D5-9F0B-E575750EA920"
		  //
		  //8 x hex
		  //1 x "-"
		  //4 xhex
		  //1 x "-"
		  //4 x hex
		  //1 x "-"
		  //4 x hex
		  //1 x "-"
		  //12 x hex
		
		  //$vt_UUID:=Minusc($vt_UUID)
		
		C_TEXT:C284($vt_pattern)
		  //basic pattern :
		  //$vt_pattern:="[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}"
		
		  //using the posix character class :
		$vt_pattern:="[:xdigit:]{8}-[:xdigit:]{4}-[:xdigit:]{4}-[:xdigit:]{4}-[:xdigit:]{12}"
		
		$vb_isUUID:=Match regex:C1019($vt_pattern;$vt_UUID)
		
		  //C_BOOLEEN($vb_patternFound)
		  //C_ENTIER LONG($vl_posFound;$vl_lengthFound)
		  //$vb_patternFound:=Trouver regex($vt_pattern;$vt_UUID;1;$vl_posFound;$vl_lengthFound;*)
		  //
		  //$vb_isUUID:=($vb_patternFound & ($vl_posFound=1) & ($vl_lengthFound=36))
		
	End if 
	
End if 
$0:=$vb_isUUID