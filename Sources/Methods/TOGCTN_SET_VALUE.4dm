//%attributes = {"invisible":true}
C_LONGINT:C283($1;$pos)
C_POINTER:C301($2;$fieldPtr;$3;$valuePtr)

$pos:=$1
$fieldPtr:=$2
$valuePtr:=$3

If ($pos=1)
	$fieldPtr->:=True:C214
	  // $valuePtr->:="On"
Else 
	  // $valuePtr->:="Off"
	$fieldPtr->:=False:C215  // update field by pointer
End if 
