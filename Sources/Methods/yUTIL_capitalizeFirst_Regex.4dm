//%attributes = {"invisible":true}
  //Method: UTIL_capitalizeFirst_Regex
  //Inputs: $1 -> String -> String to capitalize
  //Output: $0 -> String -> Capitalized string
  //Description:
  //The method capitalizes the first letter of every word
  //using the Match regex command

C_LONGINT:C283($posf;$lengf;$start)
C_TEXT:C284($regex;$to_upper;$1;$0)
C_BOOLEAN:C305($match)
$regex:="\\b(\\w)+\\b"
$to_upper:=$1

$start:=1
$match:=True:C214
While ($match=True:C214)
	$match:=Match regex:C1019($regex;$to_upper;$start;$posf;$lengf)
	$start:=$posf+$lengf
	If ($match=True:C214)
		$to_upper[[$posf]]:=Uppercase:C13($to_upper[[$posf]])
	End if 
End while 

$0:=$to_upper