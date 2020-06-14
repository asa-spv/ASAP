//%attributes = {"invisible":true}
  // method: TOGOBJ_SET_BUTTON_POSITION
  // set toggle button object position. Additionally set container image, and value
  // $1 (Object) - Toggle object
  // $2 (Longint) - Position

C_OBJECT:C1216($togObj;$1)
C_LONGINT:C283($pos;$2)
C_PICTURE:C286($pic)

$togObj:=$1
$pos:=$2

If ($pos=0) | ($pos=1)
	
	TOGBTN_SET_POS ($togObj;$pos)
	$pic:=TOGOBJ_GET_PIC ($togObj;$pos)
	TOGCTN_SET_IMAGE ($togObj;$pic)
	TOGOBJ_SET_VAL ($togObj;"Position";->$pos)
	
End if 
