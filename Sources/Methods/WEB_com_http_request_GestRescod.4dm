//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // 
  // Date et heure : 31/07/09, 11:53:41
  // ----------------------------------------------------
  // Méthode : WEB_com_http_request_GestRescod
  // Description
  // Retourne le code de réponse d'un blob résultat d'une réponse HTTP
  // Paramètres
  // $1 = BLOB de données contenant un header HTTP
  // $0 = Code de Retour HTTP
  // ----------------------------------------------------

C_TEXT:C284($1;$data)
C_TEXT:C284($0)

ARRAY LONGINT:C221($char_start;0)
ARRAY LONGINT:C221($char_length;0)

C_BOOLEAN:C305($found)

$data:=$1

  //$blob_texte:=BLOB vers texte($blob;UTF8 Texte sans longueur )

$found:=Match regex:C1019("HTTP/[1-2]{1}.[0-2]{1} ([0-9]{3} .*)\\r\\n";$data;1;$char_start;$char_length)

If ($found=True:C214)
	$data:=Substring:C12($data;$char_start{1};$char_length{1})
Else 
	
	WEB_AdminMail ("Error on WEB_com_http_request_getrescode";"Error PARSING HEADERS -> "+$data;Current method name:C684)
	$data:=""
End if 

$0:=$data