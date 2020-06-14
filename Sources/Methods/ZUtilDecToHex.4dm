//%attributes = {"invisible":true}
  // ----------------------------------------------------------------------
  // name: UTIL_DecToHex
  // description: Takes in the integer and converts the value into hex.
  // parameters:
  // $1 (LONGINT) - Number to convert to HEX
  // output:
  // $0 (TEXT) - Hex representation
  // http://kb.4d.com/assetid=77217
  // ----------------------------------------------------------------------

C_TEXT:C284($0)
C_LONGINT:C283($1)

If (Count parameters:C259=1)
	$0:=Substring:C12(String:C10($1;"&$");2)
End if 
