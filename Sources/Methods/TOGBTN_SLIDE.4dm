//%attributes = {"invisible":true}
  // method: TIGBTN_SLIDE
  // slide button to one side or the other
  // $1 (Object) - Toggle object

C_OBJECT:C1216($togObj;$1)
C_TEXT:C284($container;$button)
C_LONGINT:C283($width;$length)
C_LONGINT:C283($cl;$ct;$cr;$cb)
C_LONGINT:C283($sl;$st;$sr;$sb)
$togObj:=$1

TOGOBJ_GET_VAL ($togObj;"Container";->$container)
TOGOBJ_GET_VAL ($togObj;"Button";->$button)

OBJECT GET COORDINATES:C663(*;$container;$cl;$ct;$cr;$cb)
OBJECT GET COORDINATES:C663(*;$button;$sl;$st;$sr;$sb)
$width:=$sr-$sl
$length:=$sb-$st

If (($sl-$cl)<($cr-$sr))
	TOGBTN_SET_POS ($togObj;0)
Else 
	TOGBTN_SET_POS ($togObj;1)
End if 
