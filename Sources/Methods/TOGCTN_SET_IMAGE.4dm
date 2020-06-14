//%attributes = {"invisible":true}
  // method: TOGCTN_SET_IMAGE
  // set container image
  // $1 (Object) - Toggle object
  // $2 - Picture

C_OBJECT:C1216($togObj;$1)
C_PICTURE:C286($pic;$2)
C_TEXT:C284($container)
C_POINTER:C301($ptr)
$togObj:=$1
$pic:=$2

TOGOBJ_GET_VAL ($togObj;"Container";->$container)
$ptr:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$container)
$ptr->:=$pic
