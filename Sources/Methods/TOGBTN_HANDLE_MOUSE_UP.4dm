//%attributes = {"invisible":true}
  // method: TOGBTN_HANDLE_MOUSE_UP
  // handle on Mouse Up event for toggle button
  // $1 (Object) - Toggle Object

C_OBJECT:C1216($1;$togObj)
C_BOOLEAN:C305($vMoved;$vTracking)
C_LONGINT:C283($pos)
C_PICTURE:C286($pic)
$togObj:=$1

$vTracking:=True:C214
TOGOBJ_SET_VAL ($togObj;"Tracking";->$vTracking)
TOGBTN_SLIDE ($togObj)  // set button to one side or the other

TOGOBJ_GET_VAL ($togObj;"Dragging";->$vMoved)

If ($vMoved#True:C214)  // only click was performed. Button was not dragged
	
	$pos:=TOGBTN_CLICK ($togObj)
	$pic:=TOGOBJ_GET_PIC ($togObj;$pos)
	TOGCTN_SET_IMAGE ($togObj;$pic)
	
End if 
