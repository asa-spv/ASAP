//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Date et heure : 31/07/09, 11:53:41
  // ----------------------------------------------------
  // Méthode : WEB_com_http_request_remove_header
  // Description
  // Analyse et supprime le header HTTP dans un blob donné
  // Paramètres
  // $1 = données contenant un header HTTP
  // $0 = données sans le header HTTP
  // ----------------------------------------------------

C_TEXT:C284($0;$1;$data)

C_LONGINT:C283($xml_start_char)

$data:=$1

If (Count parameters:C259=2)
	C_TEXT:C284($resCode;$2)
	$resCode:=$2
Else 
	C_TEXT:C284($resCode)
	$resCode:="200 OK"
End if 

  //$blob_texte:=BLOB vers texte($blob;UTF8 Texte sans longueur )

$find_200ok:=Match regex:C1019("HTTP\\/1.[0-2]{1} "+$resCode;$data;1)

If ($find_200ok=True:C214)
	
	$find_header:=Match regex:C1019("(\\r\\n\\r\\n)";$data;1;$xml_start_char)
	  //SUPPRIMER DANS BLOB($blob;0;$xml_start_char+3)
	$data:=Delete string:C232($data;0;$xml_start_char+3)
	
Else 
	
	WEB_AdminMail ("Error on WEB_com_http_request_remove_header";"Error PARSING HEADERS -> "+$data;Current method name:C684)
	$data:=""
End if 

$0:=$data