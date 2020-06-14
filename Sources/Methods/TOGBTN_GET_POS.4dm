//%attributes = {"invisible":true}
  // method: TOGBTN_GET_POS
  // returns current button position
  // $1 (Object)  - Toggle Object
  // $0 (Longint) - Position of button (0 for left, 1 for right)

C_OBJECT:C1216($togObj;$1)
C_TEXT:C284($container;$button)
C_LONGINT:C283($containerMid;$buttonMid)
C_LONGINT:C283($cl;$ct;$cr;$cb)
C_LONGINT:C283($sl;$st;$sr;$sb)
C_LONGINT:C283($pos)

$togObj:=$1

TOGOBJ_GET_VAL ($togObj;"Container";->$container)
TOGOBJ_GET_VAL ($togObj;"Button";->$button)

OBJECT GET COORDINATES:C663(*;$container;$cl;$ct;$cr;$cb)
OBJECT GET COORDINATES:C663(*;$button;$sl;$st;$sr;$sb)

$containerMid:=$cl+(($cr-$cl)/2)
$buttonMid:=$sl+(($sr-$sl)/2)

If ($buttonMid<$containerMid)
	$pos:=0
Else 
	$pos:=1
End if 

$0:=$pos
