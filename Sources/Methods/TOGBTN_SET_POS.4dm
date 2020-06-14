//%attributes = {"invisible":true}
  // method: TOGBTN_SET_POS
  // set button position to left or right
  // $1 (Object)  - Toggle Object
  // $2 (Longint) - Position (0 for left, else right)

C_OBJECT:C1216($togObj;$1)
C_TEXT:C284($container;$button)
C_LONGINT:C283($width;$length)
C_LONGINT:C283($cl;$ct;$cr;$cb)
C_LONGINT:C283($sl;$st;$sr;$sb)
C_LONGINT:C283($pos)  // 0 for left, else right
$togObj:=$1
$pos:=$2

TOGOBJ_GET_VAL ($togObj;"Container";->$container)
TOGOBJ_GET_VAL ($togObj;"Button";->$button)

OBJECT GET COORDINATES:C663(*;$container;$cl;$ct;$cr;$cb)
OBJECT GET COORDINATES:C663(*;$button;$sl;$st;$sr;$sb)
$width:=$sr-$sl
$length:=$sb-$st

If ($pos=0)  // set button to left side of container
	OBJECT SET COORDINATES:C1248(*;$button;$cl;$st;$cl+$width;$sb)
Else   // set button to right side of container
	OBJECT SET COORDINATES:C1248(*;$button;$cr-$width;$st;$cr;$sb)
End if 
