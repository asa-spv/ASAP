//%attributes = {"invisible":true}
  // method: TOGBTN_HANDLE_CLICK
  // handle on click event in Toggle button
  // $1 (Object) - Toggle Object

C_OBJECT:C1216($1;$togObj)
C_BOOLEAN:C305($vMoved;$vTracking)
$togObj:=$1
$vTracking:=False:C215

$vMoved:=False:C215
TOGOBJ_SET_VAL ($togObj;"Dragging";->$vMoved)

  //  // -- V16
  //If (<>QS_TBX_4DMajeur>=16)

  //$vTracking:=Command name(1422)  // Is waiting mouse up 
  //If ($vTracking)  // the mouse button is still not released
  //TOGOBJ_SET_VAL ($togObj;"Tracking";->$vTracking)
  //End if 
  //End if 