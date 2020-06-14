//%attributes = {"invisible":true}
  // method: TOGCTN_HANDLE_CLICK
  // handle on click event in Toggle container
  // $1 - Toggle Object

C_OBJECT:C1216($1;$togObj)
C_PICTURE:C286($pic)
C_LONGINT:C283($pos)
$togObj:=$1

$pos:=TOGBTN_CLICK ($togObj)
$pic:=TOGOBJ_GET_PIC ($togObj;$pos)
TOGCTN_SET_IMAGE ($togObj;$pic)
