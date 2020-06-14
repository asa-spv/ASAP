//%attributes = {"invisible":true}
  // method: TOGBTN_MOVE
  // move button according to where user mouse position is
  // $1 (Object) - Toggle Object
  // $0 (Longint) - Position of button

C_OBJECT:C1216($togObj;$1)
C_LONGINT:C283($pos;$0)
C_TEXT:C284($container;$button)
C_BOOLEAN:C305($moved)
C_LONGINT:C283($width;$length)
C_LONGINT:C283($cl;$ct;$cr;$cb)
C_LONGINT:C283($sl;$st;$sr;$sb)
C_LONGINT:C283($mX;$mY;$mB)
C_LONGINT:C283($left;$right)

$togObj:=$1

TOGOBJ_GET_VAL ($togObj;"Container";->$container)
TOGOBJ_GET_VAL ($togObj;"Button";->$button)

OBJECT GET COORDINATES:C663(*;$container;$cl;$ct;$cr;$cb)
OBJECT GET COORDINATES:C663(*;$button;$sl;$st;$sr;$sb)
$width:=$sr-$sl
$length:=$sb-$st
GET MOUSE:C468($mX;$mY;$mB)

  // check bounds to keep switch in container

Case of 
		
	: ($sl<=$cl) & (($mX-($width/2))<$cl)
		OBJECT SET COORDINATES:C1248(*;$button;$cl;$st;$cl+$width;$sb)
		
	: ($sr>=$cr) & (($mX+($width/2))>$cr)
		OBJECT SET COORDINATES:C1248(*;$button;$cr-$width;$st;$cr;$sb)
		
	Else 
		
		$moved:=True:C214
		TOGOBJ_SET_VAL ($togObj;"Dragging";->$moved)
		$left:=$mX-($width/2)
		$right:=$mX+($width/2)
		OBJECT SET COORDINATES:C1248(*;$button;$left;$st;$right;$sb)
		
End case 

$pos:=TOGBTN_GET_POS ($togObj)
TOGOBJ_SET_VAL ($togObj;"Position";->$pos)
$0:=$pos
