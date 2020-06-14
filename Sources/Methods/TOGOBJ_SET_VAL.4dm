//%attributes = {"invisible":true}
  // method: TOGOBJ_SET_VAL
  // set value given object and property name
  // $1 (Object) - Toggle Object
  // $2 (Text) - Property
  // $3 (Pointer) - Pointer to value to set

C_OBJECT:C1216($togObj;$1)
C_TEXT:C284($prop;$2)
C_POINTER:C301($3)  // pointer to value

$togObj:=$1
$prop:=$2

OB SET:C1220($togObj;$prop;$3->)
