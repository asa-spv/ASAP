//%attributes = {"invisible":true}
  // method: TOGBTN_CLICK
  // toggles button position. If button on right, will move to left, vice versa
  // $1 (Object)  - Toggle Object
  // $0 (Longint) - Position of button after click (0 for left, 1 for right)

C_OBJECT:C1216($1;$togObj)
C_LONGINT:C283($0;$pos)
C_TEXT:C284($container;$button)

If (Count parameters:C259>=1)
	
	$togObj:=$1
	
	TOGOBJ_GET_VAL ($togObj;"Container";->$container)
	TOGOBJ_GET_VAL ($togObj;"Button";->$button)
	
	$pos:=TOGBTN_GET_POS ($togObj)
	
	If ($pos=0)  // set button to right
		TOGBTN_SET_POS ($togObj;1)
		$pos:=1
	Else   // set button to left
		TOGBTN_SET_POS ($togObj;0)
		$pos:=0
	End if 
	
	TOGOBJ_SET_VAL ($togObj;"Position";->$pos)
	$0:=$pos
	
End if 
