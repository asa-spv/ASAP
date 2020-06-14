//%attributes = {"invisible":true}
  // method: TOGOBJ_GET_PIC
  // return either Left or Right picture
  // $1 (Object) - Toggle object
  // $2 (Longint) - Option (0 for left picture, 1 for right picture)

C_OBJECT:C1216($1;$togObj)
C_LONGINT:C283($2;$option)
C_PICTURE:C286($0;$pic)
C_TEXT:C284($picEncText;$prop)
C_BLOB:C604($picBlob)

$togObj:=$1
$option:=$2

Case of 
		
	: ($option=0)  // left picture
		$prop:="Left Picture"
		
	: ($option=1)  // right picture
		$prop:="Right Picture"
		
End case 

TOGOBJ_GET_VAL ($togObj;$prop;->$picEncText)
BASE64 DECODE:C896($picEncText;$picBlob)
BLOB TO PICTURE:C682($picBlob;$pic)
$0:=$pic
