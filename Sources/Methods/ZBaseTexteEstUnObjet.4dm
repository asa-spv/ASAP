//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 16/02/17, 09:26:14
  // ----------------------------------------------------
  // méthode : UTIL_IS_TEXT_AN_OBJECT
  // description
  // http://forums.4d.fr/Post/FR/19044189/1/19047484#19047484
  // paramètres
  //
  // ----------------------------------------------------
  // $1:= TEXT of JSON to check
  // $0:= BOOLEAN representing validitity
  //
  // example
  //
  // c_TEXT($text)
  // $text:="{\"OK\": true}"
  // if (UTIL_IS_TEXT_AN_OBJECT ($text))
  // c_OBJECT($ob)
  // $ob:=JSON Parse($text;Is object)
  // else
  // ALERT("$text is not an object")
  // end if
  //

If (Count parameters:C259=1)
	
	C_BOOLEAN:C305($0)
	C_TEXT:C284($method;$result;$1)
	$method:=Method called on error:C704
	ON ERR CALL:C155(Current method name:C684)
	$result:=JSON Stringify:C1217(JSON Parse:C1218($1))
	ON ERR CALL:C155($method)
	
	If ($result="")
		$0:=False:C215
	Else 
		$0:=True:C214
	End if 
	
Else 
	
	  // on err call
	  // do nothing
	
End if 
