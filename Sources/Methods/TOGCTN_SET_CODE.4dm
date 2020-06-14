//%attributes = {"invisible":true}
  // method: TOGCTN_SET_CODE
  // convenience method to set container code based off ptr to button, value, and container
  // $1 (Text) - Button method path
  // $2 (Pointer) - Poiinter to toggle object
  // $3 - Button name
  // $4 (Text) - Container name
  // $5 (Text) - Value name
  // $6 (Pointer) - Field Pointer

C_TEXT:C284($1;$buttonMethodPath;$3;$button;$4;$container;$5;$val)
C_POINTER:C301($2;$togPtr;$6;$fieldPtr)
C_TEXT:C284($togName;$code;$containerPath;$tableName;$fieldName;$settingName)
C_LONGINT:C283($tblNum;$fldNum)

$buttonMethodPath:=$1
$togPtr:=$2
$button:=$3
$container:=$4
$val:=$5
$fieldPtr:=$6

  // programatically edit container code
$containerPath:=Replace string:C233($buttonMethodPath;$button;$container)

RESOLVE POINTER:C394($togPtr;$togName;$tblNum;$fldNum)

If ($tblNum#-1)
	$tableName:=Table name:C256($fieldPtr)
	$fieldName:=Field name:C257($fieldPtr)
	$settingName:="["+$tableName+"]"+$fieldName
	
	$code:="Case of \n: (Form event=On Clicked)\nC_PICTURE($pic)\nC_OBJECT($togObj)\nC_LONGINT($pos)"
	$code:=$code+"\nC_POINTER($valPtr)\n$togObj:="
	$code:=$code+$togName+"\nTOGCTN_HANDLE_CLICK ($togObj)\nTOGOBJ_GET_VAL ($togObj;\"Position\";->$pos)\n"
	$code:=$code+"$valPtr:=OBJECT Get pointer(Object named;\""+$val+"\")\n"
	$code:=$code+"If ($pos=0)\n$valPtr->:=\"Off\"\n"
	$code:=$code+$settingName+":=False\nElse\n$valPtr->:=\"On\"\n"+$settingName+":=True\nEnd if\nEnd case"
	
Else 
	RESOLVE POINTER:C394($fieldPtr;$FieldName;$tblNum;$fldNum)
	
	$code:="Case of \n: (Form event=On Clicked)\nC_PICTURE($pic)\nC_OBJECT($togObj)\nC_LONGINT($pos)\n"
	$code:=$code+"C_POINTER($valPtr;$fieldPtr)\n$togObj:="+$togName
	$code:=$code+"\n$fieldPtr:=->"+$FieldName+"\nTOGCTN_HANDLE_CLICK ($togObj)\nTOGOBJ_GET_VAL ($togObj;\"Position\";->$pos)\n"
	$code:=$code+"$valPtr:=OBJECT Get pointer(Object named;\""+$val+"\")\n"
	$code:=$code+"If ($pos=0)\n$valPtr->:=\"Off\"\n"
	$code:=$code+"$fieldPtr->:=False\nElse\n$valPtr->:=\"On\"\n$fieldPtr->:=True\nEnd if\nEnd case"
	
End if 

  //If ((Not(Is compiled mode)) & (<>QS_TBX_Component_Mode))
  //METHOD SET CODE($containerPath;$code)
  //End if 
